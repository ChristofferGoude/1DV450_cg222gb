class CreatorsController < ApplicationController
  before_action :api_key
  
  def index
    @creators = Creator.order(:name)
    respond_with @creators
  end

  def create
    creator = Creator.new(creator_params)
    
    if creator.save
      respond_with creator
    else
      render json: {message: 'New creator could not be added'}
    end
  end
  
  def show
    @creator = Creator.find_by_id(params[:id])
    if @creator.present?
      respond_with @creator, status: :ok, location: creators_path(@creator)
    else
      render json: {error: 'Could not find this creator. Please check input.'}, status: :not_found
    end
  end
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def creator_params
      json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      json_params.require(:creator).permit(:name)
    end
end
