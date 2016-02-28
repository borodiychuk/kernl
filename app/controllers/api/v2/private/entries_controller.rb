class Api::V2::Private::EntriesController < Api::V2::PrivateController

  def index
    sortable_by = %w( id number title )
    render_paginated @objects.order(sorting sortable_by)
  end

  def show
    render :json => @object
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
    @object = @objects.create!
    update
  end

  protected

  def filtered_params
    params.permit(@storage.entry_accessible_attributes)
  end

  def after_initialize
    @storage = @account.storages.find(params[:storage_id])
    @objects = @storage.entries
    @object  = @objects.find(params[:id]) if params[:id]
  end

end
