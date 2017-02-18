class Api::V2::Private::FieldsController < Api::V2::PrivateController

  def index
    render :json => @objects.to_json({
      :methods => [:content_type]
    })
  end

  def show
    render :json => @object.to_json({
      :methods => [:content_type]
    })
  end

  def update
    @object.update_attributes! filtered_params_update
    show
  end

  def destroy
    @object.destroy
    answer_ok
  end

  def create
    @object = @objects.create! filtered_params_creation
    update
  end

  protected

  def filtered_params_creation
    params.permit(:content_type, :identifier, :name, :ordering, :shown_in_backend_list).tap do |whitelisted|
      whitelisted[:options] = params[:options]
    end
  end

  def filtered_params_update
    params.require(:field).permit(:identifier, :name, :ordering, :shown_in_backend_list).tap do |whitelisted|
      whitelisted[:options] = params[:options]
    end
  end

  def after_initialize
    @objects = @account.storages.find(params[:storage_id]).fields
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
