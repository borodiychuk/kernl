class Api::V1::PrivateController < ApiController

  before_filter :authenticate!

  protected

  def authenticate!
    raise AuthorizationException unless @user
  end

end
