class DownloadsController < ApplicationController
  def pieces_csv_template
    download_file(Rails.root.join('public', 'download', 'template.csv'))
  end

  private
    def download_file(path)
      send_file(path, filename: path.basename, length: File::stat(path).size)
    end
end
