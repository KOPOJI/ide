class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :user_activity

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', alert: (exception.message)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end


  private

  def user_activity
    current_user.try :touch
  end

  def page_not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => true, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
