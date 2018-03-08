class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      #debugger
      login!(user)

    else
      flash.now[:errors] = ["Bad Credentials"]
      render :new
    end

  end

  def destroy
    log_out!
  end
end
