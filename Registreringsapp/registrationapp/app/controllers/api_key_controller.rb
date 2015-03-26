class ApiKeyController < ApplicationController
  before_action :checkuniquekey, only: [:create]
  
  def index
    @apikeys = ApiKey.all
    
    if logged_in?
      unless current_user.email == "christoffer.goude@gmail.com"
        flash[:key] = 'You do not have access to that page!'
        redirect_to authorized_path
      end
    else
      flash[:login] = 'Please begin by logging in.'
      redirect_to root_url
    end
  end
  
  def new
    @api_key = ApiKey.where(:user_id => current_user.id)

    # Handling manual url input from users
    if logged_in?
      if current_user.email == "christoffer.goude@gmail.com"
        flash[:admin] = 'You are an admin, your job is to oversee the API key usage!'
        redirect_to admin_path
      end
    else
      flash[:login] = 'Please begin by logging in.'
      redirect_to root_url
    end
  end
  
  def create
    @api_key = ApiKey.new()

    @api_key.api_key = SecureRandom.hex
    @api_key.user_id = current_user.id
    
    if @api_key.save
      flash[:key] = 'You have been assigned an API key.'
      redirect_to authorized_path
    else
      flash[:key] = 'Something went wrong, please try again!'
      redirect_to authorized_path
    end
  end
  
  def destroy ()
    # Remove a users API key
    if ApiKey.destroy_all(:user_id => params[:id])
      flash[:admin] = "The chosen API key was revoked!"
    else
      flash[:admin] = "There was an issue with revoking this key!"
    end
    if  current_user.email == "christoffer.goude@gmail.com"
      redirect_to admin_path
    else
      flash[:key] = 'You removed your API key!'
      redirect_to authorized_path
    end
    
  end
  
  def checkuniquekey
    if ApiKey.where(:user_id => current_user.id).blank?
      # User has no key
    else
      # User has a key already!
      flash[:key] = 'You already have an API key!'
      redirect_to authorized_path
    end
  end
end

