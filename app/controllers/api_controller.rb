class ApiController < ApplicationController
  respond_to :json
  after_filter  :set_version_header

  # See docs for status codes here: http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-26#page-57

  # Rescue from any exception by logging to rollbar. No rethrow.
  rescue_from Exception do |exception|
    Rollbar.error exception
    render json: { errors: [exception.message] }, status: 500
  end if

  # Rescue from any AuthorizationException by redirecting to frontpage
  rescue_from AuthorizationException do
    render json: { errors: ["Benutzername und/oder Passwort falsch. Bitte versuchen Sie es erneut oder stellen Sie Ihr Passwort wieder her."] }, status: 403
  end

  rescue_from GenericException do |exception|
    render json: { errors: [exception.message] }, status: 400
  end

  # Not found exception hanling
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: ["Nicht gefunden!"] }, status: 404
  end

  # Record invalid exception hanling
  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: [exception.message] }, status: 400
  end

  # Special error handler for API for roure not found error
  def route_not_found
    render json: { errors: ["Nicht gefunden!"] }, status: 404
  end

  protected

  def set_version_header
    headers['X-Version'] = Settings.version
  end

  def render_paginated relation, options = {}
    limit = params[:limit] ? params[:limit].to_i : 20
    limit = 100 if limit > 100
    offset = params[:page].to_i > 0 ? (params[:page].to_i - 1) * limit : 0
    headers['X-Total-Count'] = relation.count.to_s
    render json: relation.limit(limit).offset(offset).to_json(options)
  end

  # Prepare sorting SQL statement
  def sorting sortable_by
    if params[:orderby] && sortable_by.include?(params[:orderby])
      field = params[:orderby]
    else
      field = sortable_by.first
    end
    direction = params[:reverse] ? "DESC" : "ASC"
    "#{field} #{direction}"
  end

  # This method is called in case we just need to respond smth as OK
  def answer_ok
    head :no_content
  end

end
