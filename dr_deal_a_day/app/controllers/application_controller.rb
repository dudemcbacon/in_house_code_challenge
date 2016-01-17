class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @orders = Order.all
  end

  def upload
    if params['file'].nil?
      flash[:alert] = 'Please select a file to upload'
    else
      DataFile.import(params['file'])
    end

    total_revenue = view_context.number_to_currency(DataFile.total_revenue)

    flash[:notice] = "Added XX orders totaling $XX.XX dollars. Total revenue is #{total_revenue}"

    redirect_to '/'
  end
end
