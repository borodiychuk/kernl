class Api::V1::PrivateController < ApiController

  before_filter :authenticate!

end
