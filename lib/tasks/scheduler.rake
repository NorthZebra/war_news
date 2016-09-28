require 'nokogiri'
require 'open-uri'

desc "This task is called by the Heroku scheduler add-on"
task :add_news => :environment do

  doc = Nokogiri::HTML(open("https://twitter.com/Conflicts"))
  @tweets       = doc.css('.js-tweet-text-container')
  @tweet1       = @tweets[1].text
  @tweet2       = @tweets[2].text
  @tweet3       = @tweets[3].text
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
end
