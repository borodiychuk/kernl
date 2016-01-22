class Api::V1::Public::ProductsController < ApiController

  SERIALIZATION_OPTIONS = {
    :only => [:id, :number, :title, :subtitle, :description],
    :methods => [:prices],
    :include => {
      :images => {
        :only => [],
        :methods => [:file_url, :file_small_url, :file_large_url, :file_thumbnail_url]
      }
    }
  }

  def index
    render :json => @storage.includes(:images, :product_prices).to_json(SERIALIZATION_OPTIONS)
  end

  def show
    render :json => @product.to_json(SERIALIZATION_OPTIONS)
  end

  protected

  def after_initialize
    @storage = Project.find(params[:project_id]).products.published
    @product = @storage.find(params[:id]) if params[:id]
  end

end
