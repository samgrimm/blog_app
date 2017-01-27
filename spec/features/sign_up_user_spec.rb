require "rails_helper"


RSpec.feature "Sign up User" do
  scenario "with valid credentials" do
    visit "/"

    click_link "Sign Up"
    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")

  end
  scenario "with invalid credentials" do
    visit "/"

    click_link "Sign Up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    expect(page).to have_content("2 errors prohibited this user from being saved")
  end
end
