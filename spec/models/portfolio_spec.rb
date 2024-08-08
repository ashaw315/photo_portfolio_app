require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  # Setup
  let(:user) { FactoryBot.create(:user) }
  let(:portfolio) { FactoryBot.create(:portfolio, user: user) }

  # Validations
  it "is valid with valid attributes" do
    expect(portfolio).to be_valid
  end

  it "is not valid without a title" do
    portfolio.title = nil
    expect(portfolio).not_to be_valid
  end

  # Associations
  it "belongs to a user" do
    expect(portfolio.user).to eq(user)
  end

  it "has many photos" do
    photo1 = FactoryBot.create(:photo, portfolio: portfolio)
    photo2 = FactoryBot.create(:photo, portfolio: portfolio)
    expect(portfolio.photos).to include(photo1, photo2)
  end

  it "destroys associated photos when destroyed" do
    photo1 = FactoryBot.create(:photo, portfolio: portfolio)
    photo2 = FactoryBot.create(:photo, portfolio: portfolio)
    expect { portfolio.destroy }.to change(Photo, :count).by(-2)
  end
end
