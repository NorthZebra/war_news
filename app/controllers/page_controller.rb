class PageController < ApplicationController
  
  def index
    @news = News.ordered_by_date.paginate(:page => params[:page], :per_page => 10)

    #@news_bar = News.includes(:comments).order("created_at desc").limit(1)
  end
end
