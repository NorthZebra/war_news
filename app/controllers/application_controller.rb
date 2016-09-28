class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  protect_from_forgery

  before_filter :get_news_last, :get_comment_last

  protected
  
  def get_news_last
    @news_last = News.order("created_at desc").limit(1)
  end
  
  def get_comment_last
    @comment_last = Comment.order("created_at desc").limit(3)
  end

end
