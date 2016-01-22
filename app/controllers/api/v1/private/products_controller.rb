class Api::V1::Private::ProductsController < Api::V1::PrivateController

  def index
    sortable_by = %w( id number title )
    render_paginated @storage.order(sorting sortable_by), {
      :only => [:enabled, :id, :number, :title]
    }
  end

  def show
    render :json => @product
  end

  def update
    @product.update_attributes! filtered_params
    show
  end

  def destroy
    @product.destroy
    answer_ok
  end

  def create
    @product = @storage.create! filtered_params
    show
  end

  protected

  def filtered_params
    params.require(:product).permit(:enabled, :title, :subtitle, :number, :description)
  end

  def after_initialize
    @storage = @account.projects.find(params[:project_id]).products
    @product = @storage.find(params[:id]) if params[:id]
  end

end
