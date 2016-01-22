class Api::V1::Private::ImagesController < Api::V1::PrivateController

  def index
    render :json => @storage.to_json(
      :methods => [:file_url, :file_thumbnail_url]
    )
  end

  def create
    @storage.create! filtered_params
    answer_ok
  end

  def update
    @file.update_attributes! filtered_params
    answer_ok
  end

  def destroy
    @file.destroy
    answer_ok
  end

  def order
    params[:order].each do |f|
      @storage.find(f[:id]).update_attribute :ordering, f[:ordering]
    end
    answer_ok
  end

  protected

  def filtered_params
    params.permit(:file, :ordering)
  end

  def after_initialize
    @product = @account.products.find(params[:product_id])
    @storage = @product.images
    @file = @storage.find params[:id] if params[:id]
  end

end
