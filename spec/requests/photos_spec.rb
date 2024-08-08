require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:portfolio) { FactoryBot.create(:portfolio, user: user) }
  let!(:article) { FactoryBot.create(:article) }

  let(:valid_attributes) {
    {
      photo: {
        title: "Sample Photo",
        description: "A description of the photo",
        article_id: article.id,
        user_id: user.id,
        image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/png')
      }
    }
  }

  let(:invalid_attributes) {
    {
      photo: {
        title: nil,
        description: nil,
        article_id: nil,
        user_id: nil
      }
    }
  }

  describe "GET /portfolios/:portfolio_id/photos" do
    it "returns a list of photos" do
      FactoryBot.create(:photo, user: user, portfolio: portfolio, article: article)
      get portfolio_photos_path(portfolio)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "POST /portfolios/:portfolio_id/photos" do
    it "creates a new photo" do
      expect {
        post portfolio_photos_path(portfolio), params: valid_attributes
      }.to change(Photo, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /portfolios/:portfolio_id/photos/:id" do
    it "shows a photo" do
      photo = FactoryBot.create(:photo, user: user, portfolio: portfolio, article: article)
      get portfolio_photo_path(portfolio, photo)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["id"]).to eq(photo.id)
    end
  end

  describe "PATCH /portfolios/:portfolio_id/photos/:id" do
    it "updates a photo" do
      photo = FactoryBot.create(:photo, user: user, portfolio: portfolio, article: article)
      patch portfolio_photo_path(portfolio, photo), params: { photo: { title: "Updated Title" } }
      expect(response).to have_http_status(:ok)
      expect(photo.reload.title).to eq("Updated Title")
    end
  end

  describe "DELETE /portfolios/:portfolio_id/photos/:id" do
    it "deletes a photo" do
      photo = FactoryBot.create(:photo, user: user, portfolio: portfolio, article: article)
      expect {
        delete portfolio_photo_path(portfolio, photo)
      }.to change(Photo, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
