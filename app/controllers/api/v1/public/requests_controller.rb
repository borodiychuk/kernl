class Api::V1::Public::RequestsController < ApiController

  def create
    data = {
      :project => @project
    }
    data[:product]         = @product         if @product
    data[:product_variant] = @product_variant if @product_variant
    data[:message]         = params[:message] unless params[:message].blank?
    RequestsMailer.inquiry(data).deliver_now
    answer_ok
  end

  protected

  def after_initialize
    @project = Project.find(params[:project_id])
    @product = @project.products.published.find(params[:id]) if params[:id]
    @product_variant = @product.product_variants.find(params[:product_variant_id]) if params[:product_variant_id]
  end

end
