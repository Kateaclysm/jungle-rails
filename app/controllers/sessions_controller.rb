class SessionsController < ApplicationController

  def new
  end

  def create
    # Call the class method on User that you defined, which handles authentication logic.
    user = User.authenticate_with_credentials(params[:email], params[:password])

    user = User.find_by_email(params[:email])
    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end