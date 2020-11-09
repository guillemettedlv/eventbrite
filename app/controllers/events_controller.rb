class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :is_organizer, only: [:update, :destroy, :edit]
  
  def index
    @all_events = Event.all
  end

	def show
		@event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(organizer: current_user, 
    title: params[:title],
    start_date: params[:start_date],
    duration: params[:duration],
    description: params[:description],
    price: params[:price],
    location: params[:location]		
    )
    @event.avatar.attach(params[:avatar])

    if @event.save
			flash[:success] = "Event successfully added! 👍"
			redirect_to events_path 
		else
    	render 'new' 
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(organizer: current_user, 
      title: params[:title],
      start_date: params[:start_date],
      duration: params[:duration],
      description: params[:description],
      price: params[:price],
      location: params[:location]		
      )
      flash[:success] = "Modification sauvegardée !"
      redirect_to root_path
    else
      flash[:danger] = "Modification non sauvegardée !"
      render :edit
    end
  end
  
  def destroy
  	@event = Event.find(params[:id])
  	@event.destroy
  	flash[:alert] = "Evenement supprimé!"
  	redirect_to root_path
  end




  def is_organizer
  	@event = Event.find(params[:id])
  	puts "*"*1000
  	if current_user != @event.organizer && current_user.is_admin == false
  		flash[:error] = "Impossible"
  		redirect_to event_path
  	end
  end

  def is_validated
    @event = Event.find(params[:id])
    if @event.is_validated != false && current_user.is_admin == false
      flash[:error] = "L'evenement n'est pas sauvegardé"
      redirect_to root_path
    end
  end

end
