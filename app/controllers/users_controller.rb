class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @user = User.find(params[:id])
    stop_other_users
    @user_events = Event.where(organizer_id: @user.id)
  end

  def destroy
	  @user = User.find(params[:id])
	  @user.destroy
    flash[:alert] = "User deleted"
    redirect_to root_path
	end

  private

	def stop_other_users
		if (current_user != @user)
			flash[:error] = "Tu ne peux pas acceder à ce profil"
			redirect_to root_path
		end
	end
end
