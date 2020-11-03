class UsersController < ApplicationController
  #Runs :set_user method before anything else
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  #User should be logged in to perform all other actions
  before_action :require_user, only: [:edit, :update, :destroy]
  
  #Only for same user
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end  

  # GET /users/1
  def show
    #@movies = @user.movies
    @movies = @user.movies.paginate(page: params[:page], per_page: 4)    
  end

  # GET /users/new
  def new
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to The Movies Club, #{@user.username}!"
      #Set user session
      session[:user_id] = @user.id
      redirect_to root_path #user_path(@user)
    else
      #flash[:alert] = "User was NOT created"
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully"
      redirect_to @user
    else
      #flash[:alert] = "User was NOT updated"
      render 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    #End session if current user
    session[:user_id] = nil
    @user.destroy
    flash[:notice] = "Account and all associated movies were successfully deleted."
    redirect_to root_path
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :full_name, :email, :password)
  end

  # Only allow user to perform the action(s) on their account
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own account"
      redirect_to @user
    end
  end
end