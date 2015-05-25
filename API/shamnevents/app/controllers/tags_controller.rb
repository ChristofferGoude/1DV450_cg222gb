class TagsController < ApplicationController
  def index
    @tags = Tag.all
    respond_with @tags
  end
  
  def create
    tag = Tag.new(tag_params)
    
    if tag.save
      respond_with tag
    else
      render json: {message: 'Tag could not be created'}
    end
  end
  
  def show
  
  end
  
  def update
    
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      json_params.require(:tag).permit(:name, :event_id)
    end
end
