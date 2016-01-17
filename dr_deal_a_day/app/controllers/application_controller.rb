class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @orders = Order.all
  end

  def upload
    begin
      if params['file'].nil?
        flash[:alert] = 'Please select a file to upload'
      else
        orders = DataFile.import(params['file'])

        # Format Revenue Sums
        raw_import_revenue = orders.inject(0) { |sum, o| sum + o.order_revenue }
        import_revenue = view_context.number_to_currency(raw_import_revenue)
        total_revenue = view_context.number_to_currency(Order.total_revenue)

        flash[:notice] = "Added #{orders.count} order(s) totaling #{import_revenue} dollars. Total revenue is now #{total_revenue}"
      end
    rescue DuplicateError => e
      flash[:alert] = e.message
    rescue UnsupportedFileType => e
      flash[:alert] = e.message
    end


    redirect_to '/'
  end
end
