class ApiKeyController < ApplicationController
  def new
    # Some code for getting a new api key 
  end
  
  def create
    @api_key = ApiKey.new()

    begin
      @api_key.api_key = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
    
    if @api_key.save
      flash[:login] = 'You have been assigned an API key.'
      redirect_to authorized_path
    else
      flash[:register] = 'Something went wrong, please try again!'
      redirect_to authorized_path
    end
  end
  
  def destroy 
    # Remove a users API key
  end
end
