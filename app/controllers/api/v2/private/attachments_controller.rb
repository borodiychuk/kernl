class Api::V2::Private::AttachmentsController < Api::V2::PrivateController

  def index
    render :json => @objects.to_json(:methods => [:file_url, :file_small_url, :file_large_url, :file_thumbnail_url])
  end

  def show
    render :json => @object.to_json
  end

  def destroy
    @object.destroy
    answer_ok
  end

  def create
    @object = @objects.create! filtered_params
    show
  end

  def order
    params[:order].each do |a|
      @objects.find(a[:id]).update_attribute :ordering, a[:ordering]
    end
    answer_ok
  end

  protected

  def filtered_params
    params.permit(:file)
  end

  def after_initialize
    @objects = @account.values.find(params[:value_id]).attachments
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
