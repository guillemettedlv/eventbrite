class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
  	@event = Event.find(params[:id])
    @attendances = @event.attendances
  end

  def new
    @event = Event.find(params[:id])
  end

  def create
  	@event = Event.find(params[:id])

  	a = Attendance.create(stripe_customer_id: "Free event",user: current_user, event: @event)

  	flash[:success] = "You successfully joined the event!"
		redirect_to root_path
  end
end
