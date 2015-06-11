class TagsController < ApplicationController
  before_action :api_key
  before_action :offset_params, only: [:index, :nearby]
  
  def index 
    tags = Tag.limit(@limit).offset(@offset)
    
    if tags.present?
      respond_with tags, status: :ok, location: tags_path
    else
      render json: {error: 'Could not find any resources at all.'}, status: :not_found
    end
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
    @tag = Tag.find_by_id(params[:id])
    
    if @tag.present?
      respond_with @tag, status: :ok, location: tags_path(@tag)
    else
      render json: {error: 'Could not find the resource. Check if you are using the right tag_id.'}, status: :not_found
    end
  end
  
  def update
    
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      json_params.require(:tag).permit(:name)
    end
end
