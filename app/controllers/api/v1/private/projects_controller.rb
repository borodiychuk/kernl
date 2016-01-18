class Api::V1::Private::ProjectsController < Api::V1::PrivateController

  def index
    render :json => @storage
  end

  def show
    render :json => @project
  end

  protected

  def after_initialize
    @storage = @account.projects
    @project = @storage.find(params[:id]) if params[:id]
  end

end
