class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  require 'nokogiri'
  require 'open-uri'

  def index
    @news = News.ordered_by_date
  end

  def show
  end

  def new
    doc = Nokogiri::HTML(open("https://twitter.com/Conflicts"))
    @tweets = doc.css('.js-tweet-text-container')
    @tweet1 = @tweets[1].text
    @tweet2 = @tweets[2].text
    @tweet3 = @tweets[3].text

    @tweet_params = doc.css('.js-stream-tweet')
    @img_srcs1    = @tweet_params[1].css('@data-image-url')[0]
    @tweet_id1    = @tweet_params[1].css('@data-tweet-id')    
    @img_srcs2    = @tweet_params[2].css('@data-image-url')[0]
    @tweet_id2    = @tweet_params[2].css('@data-tweet-id')    
    @img_srcs3    = @tweet_params[3].css('@data-image-url')[0]
    @tweet_id3    = @tweet_params[3].css('@data-tweet-id')    
    
    
    News.create(news_date: Time.zone.now, tweet_id: @tweet_id1, news_body: @tweet1) 
    News.last.update_attribute :image, News.last.image_from_url(@img_srcs1)
    News.dedupe
    
    News.create(news_date: Time.zone.now, tweet_id: @tweet_id2, news_body: @tweet2) 
    News.last.update_attribute :image, News.last.image_from_url(@img_srcs2)
    News.dedupe
    
    News.create(news_date: Time.zone.now, tweet_id: @tweet_id3, news_body: @tweet3) 
    News.last.update_attribute :image, News.last.image_from_url(@img_srcs3)
    News.dedupe

    @news = News.new
  end

  def edit
  end

  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @news = News.find(params[:id])
    @news.upvote_from current_user
    redirect_to :back  
  end

  def downvote
    @news = News.find(params[:id])
    @news.downvote_from current_user
    redirect_to :back  
  end
  
  private
    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:news_date, :tweet_id, :news_body, :image)
    end
end
