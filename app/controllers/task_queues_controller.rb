class TaskQueuesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!

  def index
    @tasks = TaskQueue.all.includes(:user).includes(:tweet => :genre).order(:created_at)
  end

  private
  def admin_check!
    if !current_user.admin
      redirect_to root_path
    end
  end
end
