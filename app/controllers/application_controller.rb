class ApplicationController < ActionController::Base
  before_action :require_login
  def require_login
  end

  def current_user
    sess = Session.find_by(session_key: cookies[:session_key])
    return if sess.blank?

    obj = JSON.parse(sess.content)
    User.find(obj['user_id'].to_i)
  end

  helper_method :current_user
end
