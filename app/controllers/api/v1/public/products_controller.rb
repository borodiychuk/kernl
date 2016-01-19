class Api::V1::Public::ProductsController < Api::V1::ApiController

  def index
    render :json => []#@storage
  end

  def show
    render :json => {}#@product
  end

  protected

  def after_initialize
    #@storage = @account.products
    #@product = @storage.find(params[:id]) if params[:id]
  end

end
