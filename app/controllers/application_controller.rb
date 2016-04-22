class ApplicationController < ActionController::Base

  # Rescue from any exception by logging to rollbar and rethrow it
  rescue_from Exception do |exception|
    Rollbar.error exception
    raise exception
  end

end
