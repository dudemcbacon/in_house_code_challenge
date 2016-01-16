class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @orders = Order.all
  end

  def upload
    DataFile.import(params['file'])
  end
end
