class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :logged_in?, :current_user, :admin?

  # Locale methods
  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Methods to define logged in and current user
  def current_user
    if @current_user.present?
      return @current_user
    end

    @current_user = User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end

  def admin?
    current_user.role == 'admin'
  end
end
