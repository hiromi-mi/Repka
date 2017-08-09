class PiecesController < ApplicationController
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
          raise 'Year is integer only.' unless param[:year].is_a?(Integer) if param[:year]
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

  private
    def validate_power
      unless is_power_ge?(power_of({index: :normal, create: :shiketai, destroy: :shiketai}[action_name.to_sym]))
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
