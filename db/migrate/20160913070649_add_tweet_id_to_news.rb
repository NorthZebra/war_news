class AddTweetIdToNews < ActiveRecord::Migration
  def change
    add_column :news, :tweet_id, :string
  end
end
