class News < ActiveRecord::Base
  require "open-uri"
  
  acts_as_votable
  has_many :comments
  
  has_many :images
  attr_reader :image_from_url
  has_attached_file :image, styles: { medium: "700x500>", thumb: "200x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def image_from_url(url)
    if url.present?
      self.image = open(url)
    end
  end
  
  def self.dedupe
    grouped = all.group_by{|news| [news.tweet_id] }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift # or pop for last one
      duplicates.each{|double| double.destroy} 
    end
  end
  scope :ordered_by_date, -> { order created_at: :desc }
end

News.dedupe