class EventsController < ApplicationController  
  def index
    @events = Event.all
    respond_with @events
  end
  
  def show
    render json: {message: 'Resource not found'}
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
      json_params.require(:event).permit(:name, :address, :latitude, :longitude)
    end
end
