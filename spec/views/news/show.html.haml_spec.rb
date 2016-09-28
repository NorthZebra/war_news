require 'rails_helper'

RSpec.describe "news/show", type: :view do
  before(:each) do
    @news = assign(:news, News.create!(
      :news_body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
