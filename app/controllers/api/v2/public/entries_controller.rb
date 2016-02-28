class Api::V2::Public::EntriesController < ApiController

  def index
    render :json => @objects.includes(:fields, :values => :attachments)
  end

  def show
    render :json => @object
  end

  protected

  def after_initialize
    @objects = Storage.find(params[:storage_id]).entries.published
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
