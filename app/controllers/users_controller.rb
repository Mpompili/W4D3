class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    # user_params = params[:user ]

    user = User.new(user_params)
        # debugger
    if user.save
      session[:session_token] = user.session_token
      flash[:success] = "Successfully logged in!"
      redirect_to cats_url
    else
      flash.now[:errors] = ["Bad credentials"]
      render :new
    end
  end

  def show
    #debugger
    @user = User.find_by(params[:username])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
