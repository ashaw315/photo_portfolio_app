require 'rails_helper'

RSpec.describe "Articles", type: :request do
    let!(:portfolio) { FactoryBot.create(:portfolio) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:articles) { FactoryBot.create_list(:article, 10, portfolio: portfolio, user: user) }
    let(:portfolio_id) { portfolio.id }
    let(:article_id) { articles.first.id }
    let(:valid_attributes) { { title: "New Article", content: "Content of the article", portfolio_id: portfolio_id, user_id: user.id } }
    let(:invalid_attributes) { { title: "", content: "Content of the article", portfolio_id: portfolio_id, user_id: user.id } }

  describe "GET /portfolios/:portfolio_id/articles" do
    before { get "/portfolios/#{portfolio_id}/articles" }

    it "returns a list of articles" do
      expect(response).to have_http_status(:success)
      expect(response.body).to include(articles.first.title, articles.second.title)
    end
  end

  describe "GET /portfolios/:portfolio_id/articles/:id" do
    before { get "/portfolios/#{portfolio_id}/articles/#{article_id}" }

    context "when the record exists" do
      it "returns the article" do
        expect(response).to have_http_status(:success)
        expect(response.body).to include(articles.first.title)
      end
    end

    context "when the record does not exist" do
      let(:article_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to include("Record not found")
      end
    end
  end

  describe "POST /portfolios/:portfolio_id/articles" do
    context "when the request is valid" do
      before { post "/portfolios/#{portfolio_id}/articles", params: { article: valid_attributes } }

      it "creates an article" do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('New Article')
      end
    end

    context "when the request is invalid" do
      before { post "/portfolios/#{portfolio_id}/articles", params: { article: invalid_attributes } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a validation failure message" do
        expect(JSON.parse(response.body)['title']).to include("can't be blank")
        expect(JSON.parse(response.body)['title']).to include("is too short (minimum is 3 characters)")
      end
    end
  end

  describe "PUT /portfolios/:portfolio_id/articles/:id" do
    context "when the record exists" do
      before { put "/portfolios/#{portfolio_id}/articles/#{article_id}", params: { article: { title: 'Updated Title' } } }

      it "updates the article" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['title']).to eq('Updated Title')
      end

      it "returns a validation failure message if update is invalid" do
        put "/portfolios/#{portfolio_id}/articles/#{article_id}", params: { article: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['title']).to include("can't be blank")
        expect(JSON.parse(response.body)['title']).to include("is too short (minimum is 3 characters)")
      end
    end

    context "when the record does not exist" do
      let(:article_id) { 100 }

      before { put "/portfolios/#{portfolio_id}/articles/#{article_id}", params: { article: valid_attributes } }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to include("Record not found")
      end
    end
  end

  describe "DELETE /portfolios/:portfolio_id/articles/:id" do
    before { delete "/portfolios/#{portfolio_id}/articles/#{article_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end

end
