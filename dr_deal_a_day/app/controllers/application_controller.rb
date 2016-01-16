class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @datafiles = DataFile.all
  end

  def upload
    csv_file_path = params['file']
    DataFile.import(csv_file_path)
  end
end
