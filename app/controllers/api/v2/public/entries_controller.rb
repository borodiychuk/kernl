class Api::V2::Public::EntriesController < ApiController

  def index
    raise AuthorizationException unless @storage.public_viewing_enabled
    render :json => @objects.includes(:fields, :values => :attachments)
  end

  def show
    raise AuthorizationException unless @storage.public_viewing_enabled
    render :json => @object
  end

  def create
    raise AuthorizationException unless @storage.public_creating_enabled
    @object = @objects.create!
    @objects.update_attributes! filtered_params
    show
  end

  protected

  def filtered_params
    params.permit(@storage.entry_accessible_attributes)
  end

  def after_initialize
    @storage = Storage.find(params[:storage_id])
    @objects = @storage.entries.published
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
