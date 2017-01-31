require "rails_helper"


RSpec.feature "Show Article" do

  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    @fred = User.create!(email: "fred@example.com", password: "foobar", password_confirmation: "foobar")
    @article = Article.create(title: "The first article" ,body: "Lorem ipsum blalbalbla", user:@john)
  end
  scenario "to non-signed in users hide the edit and delete buttons" do
    visit "/"
    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  scenario "to non-article owner signed in hide the edit and delete buttons" do
    login_as(@fred)
    visit "/"
    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to article owner signed in show the edit and delete buttons" do
    login_as(@john)
    visit "/"
    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end
