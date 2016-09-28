require 'rails_helper'

RSpec.describe "news/index", type: :view do
  before(:each) do
    assign(:news, [
      News.create!(
        :news_body => "MyText"
      ),
      News.create!(
        :news_body => "MyText"
      )
    ])
  end

  it "renders a list of news" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
