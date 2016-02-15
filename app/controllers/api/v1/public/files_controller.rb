class Api::V1::Public::FilesController < ApiController

  def index
    render :json => @storage.to_json(:methods => [:file_url, :file_small_url, :file_large_url, :file_thumbnail_url])
  end

  protected

  def after_initialize
    @storage = Project.find(params[:project_id]).field_files
  end

end
