require 'rails_helper'

RSpec.describe "news/edit", type: :view do
  before(:each) do
    @news = assign(:news, News.create!(
      :news_body => "MyText"
    ))
  end

  it "renders the edit news form" do
    render

    assert_select "form[action=?][method=?]", news_path(@news), "post" do

      assert_select "textarea#news_news_body[name=?]", "news[news_body]"
    end
  end
end
