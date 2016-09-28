class PageController < ApplicationController
  
  def index
    @news = News.ordered_by_date.paginate(:page => params[:page], :per_page => 10)
  end
end
