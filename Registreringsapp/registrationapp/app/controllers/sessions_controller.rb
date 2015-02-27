class SessionsController < ApplicationController
  def new
    #Called to show login form
  end
  
  # Called when a users tries to login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      
      # Checks the status of the logged in user
      if user.email == "christoffer.goude@gmail.com"
        redirect_to admin_path     
      else
        redirect_to authorized_path
      end 
    else
      # Create an error message.
      flash[:login] = 'Invalid email/password combination!'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
