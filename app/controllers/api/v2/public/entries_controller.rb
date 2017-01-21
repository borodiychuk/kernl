class Api::V2::Public::EntriesController < ApiController

  include Recaptcha::Verify

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
    raise GenericException.new("reCAPTCHA protection thinks you are robot") unless verify_recaptcha(:secret_key => @storage.recaptcha_secret_key)
    @object = @objects.create! :creator_ip => request.remote_ip
    @object.update_attributes! filtered_params
    NotificationsMailer.entry_creation(@object).deliver if @storage.email_notification_on_public_creation_enabled
    answer_ok
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
