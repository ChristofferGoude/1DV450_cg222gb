class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:api_key)
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

  # GET /users/new
  def new
    @user = User.new
  end
  
  # GET /users/:id
  def show
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
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save     
      log_in @user    
      flash[:key] = 'Welcome to the registration app!'
      redirect_to authorized_path
    else
      if @user.email.present?
        flash[:register] = 'This email adress is not valid or already in use!'
      else
        flash[:register] = 'You must enter an email adress!'
      end
      
      redirect_to register_path
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def login
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
