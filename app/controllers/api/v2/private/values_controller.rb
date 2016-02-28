class Api::V2::Private::ValuesController < Api::V2::PrivateController

  def show
    render :json => @value.to_json
  end

  protected

  def filtered_params
    params.permit(:file)
  end

  def after_initialize
    @entry   = @account.entries.find(params[:entry_id]) if params[:entry_id]
    @storage = @entry.storage if @entry
    @storage = @account.storages.find(params[:storage_id]) if params[:storage_id]
    @values  = @storage.fields.find_by_identifier!(params[:field]).values
    # If entry is provided, then we findfirst  or creare, otherwise just create
    @value =  if @entry
                @values.of_entry(@entry).first_or_create!
              else
                @values.create!
              end
  end

end
