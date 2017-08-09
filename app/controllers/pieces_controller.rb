class PiecesController < ApplicationController
  before_action :logged_in_user

  def index
    @pieces = Piece.all
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

  def edit
    redirect_to pieces_path
  end

  def destroy
    redirect_to pieces_path
  end

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
