class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def is_admin
    if current_user.is_admin == false
      flash[:error] = "You're not admin !"
      redirect_to root_path
    end
  end

end
