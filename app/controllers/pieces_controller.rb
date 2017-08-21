class PiecesController < ApplicationController
  before_action :logged_in_user
  before_action :validate_power

  def index
    @pieces = Piece.all
    @columns = [:id, :title, :teacher, :year, :kind, :data] +
      (is_power_ge?(power_of(:shiketai)) ? [:operation] : [])
    respond_to do |format|
      format.html
      format.json { render json: PieceDatatable.new(view_context) }
    end
  end

  def create
    begin
      raise 'no file was specified.' if params[:file].nil?
      sheet = Roo::Spreadsheet.open(params[:file].tempfile)
      header = sheet.row(1)
      2.upto(sheet.last_row).each do |i|
        param = ActionController::Parameters.new(Hash[header.zip sheet.row(i)]).
          permit(:title, :teacher, :year, :kind, :data)
        begin
          raise 'Year is integer only.' if param[:year] and not (param[:year].to_s =~ /\A[0-9.]+\z/)
          param[:year] = param[:year].to_i if param[:year]
          piece = Piece.new(param)
          raise piece.errors.full_messages.join('<br />') unless piece.save
        rescue => ex
          raise "Line #{i} : #{ex.message}"
        end
      end
    rescue => ex
      flash[:danger] = 'The registration failed : <br />' + ex.message
    else
      flash[:success] = 'The registration succeeded.'
    end

    redirect_to pieces_path
  end

  def destroy
    Piece.find(params[:id]).destroy
    flash[:success] = 'The piece was deleted.'
    redirect_to pieces_path
  end

  def download_csv_template
    file_name = 'template.csv'
    file_path = Rails.root.join('public', file_name)
    stat = File::stat(file_path)
    send_file(file_path, filename: file_name, length: stat.size)
  end

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def validate_power
      unless is_power_ge?(power_of({index: :normal, create: :shiketai, destroy: :shiketai}[action_name.to_sym]))
        flash[:danger] = "You are not allowed to do the action."
        redirect_to pieces_url
      end
    end
end
