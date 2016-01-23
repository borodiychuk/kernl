class Api::V1::Private::ProductVariantsController < Api::V1::PrivateController

  def index
    render :json => @storage
  end

  def create
    @storage.create! filtered_params
    answer_ok
  end

  def update
    @variant.update_attributes! filtered_params
    answer_ok
  end

  def destroy
    @variant.destroy
    answer_ok
  end

  protected

  def filtered_params
    params.permit(:name, :value)
  end

  def after_initialize
    @product = @account.products.find(params[:product_id])
    @storage = @product.product_variants
    @variant   = @storage.find params[:id] if params[:id]
  end

end
