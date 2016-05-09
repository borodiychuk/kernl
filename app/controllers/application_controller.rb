class ApplicationController < ActionController::Base

  before_action :after_initialize

  # Rescue from any exception by logging to rollbar and rethrow it
  rescue_from Exception do |exception|
    Rollbar.error exception
    raise exception
  end

  protected

  def after_initialize
    # This method can be overriden in the inhericed controllers
  end

end
