class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.date :news_date
      t.text :news_body

      t.timestamps null: false
    end
  end
end
