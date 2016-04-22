class PrivateController < ApplicationController
  before_filter :authenticate_user!
  prepend_before_action :assign_account

  protected

  def assign_account
    @user    = current_user
    @account = @user.account
  end

end
