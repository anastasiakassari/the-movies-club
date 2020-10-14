class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #Get user by email
    user = User.find_by(email: params_email)

    if user && user.authenticate(params_password
    )
      #Create new session
      session[:user_id] = user.id

      #Show message
      flash[:notice] = 'Logged in successfully'
      redirect_to user

    else

      #Show message immediatelly 
      flash.now[:alert] = 'Authentication was NOT successful'
      render 'new'

    end
  end

  def destroy
    # Terminate user session
    session[:user_id] = nil

    #Show message
    flash[:notice] = 'Logged out successfully'
    redirect_to root_path

  end

  private

  def params_email
    params[:session][:email]
  end

  def params_password
    params[:session][:password]
  end
end