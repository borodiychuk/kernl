class Api::V2::Private::ValuesController < Api::V2::PrivateController

  def show
    @object = @field.values.create! unless @object
    render :json => @object.to_json
  end

  protected

  def filtered_params
    params.permit(:file)
  end

  def after_initialize
    @entry   = @account.entries.find(params[:entry_id]) if params[:entry_id]
    @storage = @entry.storage if @storage
    @object  = @storage.fields.find_by_identifier!(params[:field]).values.of_entry(@entry).first if @entry && params[:field]
    @field   = @account.storages.find(params[:storage_id]).fields.find_by_identifier!(params[:field]) if params[:storage_id] && params[:field]
  end

end
