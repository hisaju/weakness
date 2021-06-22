class SessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user
      cookies[:session_key] = @user.login
      redirect_to messages_url
    else
      flash.now[:alert] = 'ログイン失敗'
      render :new
    end
  end

  def destroy
    cookies.delete(:session_key)
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
