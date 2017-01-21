class Api::V2::Private::StoragesController < Api::V2::PrivateController

  def index
    render :json => @objects.to_json
  end

  def show
    render :json => @object.to_json(
      :include => {
        :fields => {
          :methods => [:content_type]
        },
        :backend_list_fields => {
          :only => [:identifier, :name],
          :methods => [:content_type]
        }
      }
    )
  end

  def update
    @object.update_attributes! filtered_params
    show
  end

  def destroy
    @object.destroy
    answer_ok
  end

  def create
    @object = @objects.create! filtered_params
    update
  end

  protected

  def filtered_params
    params.require(:storage).permit(:name, :public_creating_enabled, :email_notification_on_public_creation_enabled, :public_viewing_enabled, :recaptcha_protected, :recaptcha_secret_key)
  end

  def after_initialize
    @objects = @account.storages
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
