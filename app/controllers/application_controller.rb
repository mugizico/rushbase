class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :about, :interests, :avatar, :industry_id]
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :industry_id, :full_name]
  end

  def after_sign_in_path_for(resource)
    profile_path
  end

  def after_sign_out_path_for(resource)
  	root_path
  end

  def meetup_member?
    meetup = Meetup.find(params[:meetup_id])
    #redirect_to meetup_url(meetup.id) unless meetup.member?(current_user)

  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
