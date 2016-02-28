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

  protected

  def after_initialize
    @objects = @account.storages
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
