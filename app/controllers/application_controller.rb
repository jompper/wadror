class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :ensure_that_admin, only: [:destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to :back, notice:'Only admin can delete stuff' if current_user.nil? or not current_user.admin
  end

end
