require "rails_helper"


RSpec.feature "Show Article" do

  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    login_as(@john)
    @article = Article.create(title: "The first article" ,body: "Lorem ipsum blalbalbla", user:@john)
  end
  scenario "A user shows one Articles" do
    visit "/"
    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
