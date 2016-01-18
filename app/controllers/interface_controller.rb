class InterfaceController < ApplicationController

  before_action :assign_action_name

  # Rescue from any AuthorizationException by redirecting to frontpage
  rescue_from AuthorizationException do
    redirect_to :action => :landing
  end

  def landing
    return redirect_to :action => :app if @user
    @base = "/"
  end

  def application
    #return redirect_to :action => :landing unless @user
    #authenticate!
    @base = "/app/"
  end

  # Force sign out user. Used as intermediate point to redirect users to
  def reauth
    sign_out current_user if user_signed_in?
    redirect_to :action => :landing
  end

  private

  def assign_action_name
    @action = action_name
  end

end
