class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!

  def index
  end

  private
  def admin_check!
    if current_user.admin == false
      redirect_to root_path
    end
  end
end
