class Api::V1::Private::FilesController < Api::V1::PrivateController

  def index
    sortable_by = %w( id number title )
    render :json => @storage
  end

  def show
    render :json => @file
  end

  def update
    @file.update_attributes! filtered_params
    show
  end

  def destroy
    @file.destroy
    answer_ok
  end

  def create
    @file = @storage.create! filtered_params
    show
  end

  protected

  def filtered_params
    params.permit(:file, :description)
  end

  def after_initialize
    @storage = @account.projects.find(params[:project_id]).field_files
    @file = @storage.find(params[:id]) if params[:id]
  end

end
