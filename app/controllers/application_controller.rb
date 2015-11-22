class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :adjust_lang
  def index
  end
  
  def adjust_lang
	if session[:language] == "en" || session[:language].nil?
		I18n.locale = :en
	elsif session[:language] == "pl"
		I18n.locale = :pl
	end 
  end
end
