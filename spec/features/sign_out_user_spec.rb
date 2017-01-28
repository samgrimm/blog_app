require "rails_helper"


RSpec.feature "Sign Out User" do
  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password

    click_button "Log in"
  end
  scenario  do
    visit "/"

    click_link "Sign out"

    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_content("Sign out")

  end

end
