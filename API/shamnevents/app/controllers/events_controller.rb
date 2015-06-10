class EventsController < ApplicationController
  before_action :api_key
  before_action :offset_params, only: [:index, :orderbydate, :nearby]
  
  def index
    if params[:creator_id].present?
      @creator = Creator.find(params[:creator_id])
      events = @creator.events.limit(@limit).offset(@offset)
    else if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      events = @tag.events.limit(@limit).offset(@offset)
    else
      events = Event.order(:created_at).limit(@limit).offset(@offset)
    end
  end
    if events.present?
      respond_with events, status: :ok
    end
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with @event

    rescue ActiveRecord::RecordNotFound
      render json: {message: "The event could not be found!"}
  end
  
  def create
    event = Event.new(event_params)
    
    if event.save
      respond_with event
    else
      render json: {message: 'Event could not be created'}
    end
  end
  
  def update
    
  end 
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      json_params.require(:event).permit(:creator_id, :name, :address, :latitude, :longitude)
    end
end
