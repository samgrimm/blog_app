require "rails_helper"


RSpec.feature "Editing Articles" do

  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    login_as(@john)
    @article = Article.create(title: "The first article" ,body: "Lorem ipsum blalbalbla", user:@john)

  end
  scenario "A user edits an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Article"
    fill_in "Body", with: "Updated body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq (article_path(@article))

  end

  scenario "A user fails to edit an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq (article_path(@article))

  end

end
