require "rails_helper"

RSpec.describe "Comments", type: :request do
  before do
    @john = User.create!(email: "john@example.com", password: "foobar", password_confirmation: "foobar")
    @article = Article.create(title: "The first article" ,body: "Lorem ipsum blalbalbla", user: @john)
    @fred = User.create!(email: "fred@example.com", password: "foobar", password_confirmation: "foobar")
  end
  describe "POST /articles/:id/comments" do
    context 'with a non signed in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome blog"}}
      end
      it "redirects user to sign in page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with a signed in user' do
      before do
        login_as(@fred)
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome blog"}}
      end
      it "create comment" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(@article)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end
