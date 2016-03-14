class ApiKeyController < ApplicationController
  before_action :checkuniquekey, only: [:create]
  
  def index    
    if logged_in?
      if current_user.email == "christoffer.goude@gmail.com"
        @apikeys = ApiKey.all
      else
        @apikeys = ApiKey.where(:user_id => current_user.id)
      end
    else
      flash[:login] = 'Please begin by logging in.'
      redirect_to root_url
    end
  end
  
  def new
    @api_key = ApiKey.new
  end
  
  def create
    @api_key = ApiKey.new(key_params)

    @api_key.api_key = SecureRandom.hex
    @api_key.user_id = current_user.id
    
    if @api_key.save
      flash[:key] = 'You have been assigned an API key.'
      redirect_to index_path
    else
      flash[:key] = 'Something went wrong, please try again!'
      redirect_to index_path
    end
  end
  
  def destroy ()
    # Remove a users API key
    if ApiKey.destroy_all(:id => params[:id])
      flash[:admin] = "The chosen API key was revoked!"
    else
      flash[:admin] = "There was an issue with revoking this key!"
    end   
    redirect_to index_path
  end
  
  def show
  end
  
  def checkuniquekey
    ApiKey.where(:user_id => current_user.id).blank?
  end
  
  private
      # Never trust parameters from the scary internet, only allow the white list through.
    def key_params
      params.require(:api_key).permit(:app_name)
    end
end

