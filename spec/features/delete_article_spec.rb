require "rails_helper"


RSpec.feature "Delete Article" do

  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    login_as(@john)
    @article = Article.create(title: "The first article" ,body: "Lorem ipsum blalbalbla", user:@john)
  end
  scenario "A user delete an Article" do
    visit "/"
    click_link(@article.title)
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(page).not_to have_content("The first article")

    expect(current_path).to eq(articles_path)
  end
end
