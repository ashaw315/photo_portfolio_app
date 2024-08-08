require 'rails_helper'

RSpec.describe "Portfolios", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:portfolio) { FactoryBot.create(:portfolio, user: user) }

  describe "GET /portfolios" do
    it "returns a list of portfolios" do
      portfolio1 = FactoryBot.create(:portfolio, user: user)
      portfolio2 = FactoryBot.create(:portfolio, user: user)

      get "/portfolios"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(portfolio1.title, portfolio2.title)
    end
  end

  describe "GET /portfolios/:id" do
    context "when the record exists" do
      it "returns the portfolio" do
        get "/portfolios/#{portfolio.id}"

        expect(response).to have_http_status(:success)
        expect(response.body).to include(portfolio.title)
      end
    end

    context "when the record does not exist" do
      it "returns a not found message" do
        get "/portfolios/999999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Record not found")
      end
    end
  end

  describe "POST /portfolios" do
    it "creates a new portfolio" do
      portfolio_params = {
        portfolio: {
          title: "My New Portfolio",
          description: "A description of my new portfolio",
          user_id: user.id
        }
      }

      post "/portfolios", params: portfolio_params

      expect(response).to have_http_status(:created)
      expect(Portfolio.last.title).to eq("My New Portfolio")
    end

    context "when the request is invalid" do
      it "returns a validation failure message" do
        portfolio_params = { portfolio: { title: "", user_id: user.id } }
        post "/portfolios", params: portfolio_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe "PUT /portfolios/:id" do
    context "when the record exists" do
      it "updates the portfolio" do
        put "/portfolios/#{portfolio.id}", params: { portfolio: { title: 'Updated Title' } }

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Updated Title')
      end

      it "returns a validation failure message if update is invalid" do
        put "/portfolios/#{portfolio.id}", params: { portfolio: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end

    context "when the record does not exist" do
      it "returns a not found message" do
        put "/portfolios/999999", params: { portfolio: { title: 'Updated Title' } }
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe "DELETE /portfolios/:id" do
    context "when the record exists" do
      it "deletes the portfolio" do
        delete "/portfolios/#{portfolio.id}"

        expect(response).to have_http_status(:no_content)
        expect(Portfolio.find_by(id: portfolio.id)).to be_nil
      end
    end

    context "when the record does not exist" do
      it "returns a not found message" do
        delete "/portfolios/999999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Record not found")
      end
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
