class PiecesController < ApplicationController
  def index
    @pieces = Piece.all
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
      flash[:success] = 'The registration successed.'
    end

    redirect_to pieces_path
  end
end
