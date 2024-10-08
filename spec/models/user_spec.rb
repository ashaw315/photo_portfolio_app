require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', password: 'password', password_confirmation: 'password')
    user.save
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(password: 'password')
    expect(user).to_not be_valid
  end
end
