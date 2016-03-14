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
      
      # Redo admin check via helper
      redirect_to index_path
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
