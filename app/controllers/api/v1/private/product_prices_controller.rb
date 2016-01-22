class Api::V1::Private::ProductPricesController < Api::V1::PrivateController

  def index
    render :json => @storage
  end

  def create
    @storage.create! filtered_params
    answer_ok
  end

  def update
    @price.update_attributes! filtered_params
    answer_ok
  end

  def destroy
    @price.destroy
    answer_ok
  end

  protected

  def filtered_params
    params.permit(:price, :amount)
  end

  def after_initialize
    @product = @account.products.find(params[:product_id])
    @storage = @product.product_prices
    @price   = @storage.find params[:id] if params[:id]
  end

end
