class UsersController < ApplicationController
  skip_before_action :require_login
  before_action -> { redirect_back(fallback_location: root_path) if current_user }

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:session_key] = @user.login
      redirect_to messages_url, notice: 'ユーザー登録が完了しました'
    else
      flash.now[:warning] = "ユーザー登録に失敗しました。\r#{@user.errors.full_messages}"
      return render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :tel, :email, :password, :password_confirmation)
  end

end
