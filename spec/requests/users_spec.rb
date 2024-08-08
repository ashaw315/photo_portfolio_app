require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:valid_attributes) { { name: "Jane Doe", password: "password", password_confirmation: "password" } }
  let(:invalid_attributes) { { name: "", password: "password", password_confirmation: "password" } }
  let(:bio_update_attributes) { { bio: 'Updated bio' } }
  let(:profile_picture_update_attributes) { { profile_picture: 'http://example.com/new_picture.png' } }

  describe "GET /users" do
    before { get '/users' }

    it "returns users" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:id" do
    context "when the record exists" do
      before { get "/users/#{user_id}" }

      it "returns the user" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:user_id) { 100 }

      before { get "/users/#{user_id}" }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe "POST /users" do
    context "when the request is valid" do
      before { post '/users', params: { user: valid_attributes } }

      it "creates a user" do
        expect(json['name']).to eq('Jane Doe')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post '/users', params: { user: invalid_attributes } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(json['name']).to include("can't be blank")
      end
    end
  end

  describe "PUT /users/:id" do
    let(:user) { create(:user, name: 'John Doe', password: 'oldpassword', password_confirmation: 'oldpassword') }
    let(:update_attributes) { { name: 'Jane Doe', password: 'newpassword', password_confirmation: 'newpassword' } }

    context "when the record exists" do
      before { put "/users/#{user.id}", params: { user: update_attributes } }

      it "updates the record" do
        expect(response).to have_http_status(200)
        expect(json['name']).to eq('Jane Doe')
      end

      it "returns the updated user" do
        expect(json).not_to be_empty
        expect(json['name']).to eq('Jane Doe')
      end
    end

    context "when updating the bio" do
      before { put "/users/#{user.id}", params: { user: bio_update_attributes } }

      it "updates the bio" do
        expect(response).to have_http_status(200)
        expect(json['bio']).to eq('Updated bio')
      end
    end

    context "when updating the profile picture" do
      before { put "/users/#{user.id}", params: { user: profile_picture_update_attributes } }

      it "updates the profile picture" do
        expect(response).to have_http_status(200)
        expect(json['profile_picture']).to eq('http://example.com/new_picture.png')
      end
    end

    context "when the record does not exist" do
      let(:user_id) { 100 }

      before { put "/users/#{user_id}", params: { user: valid_attributes } }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe "DELETE /users/:id" do
    before { delete "/users/#{user_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
