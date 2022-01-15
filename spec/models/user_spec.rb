require 'rails_helper'

RSpec.describe User, type: :model do  
  it 'is valid with an email and password' do
    user = User.new(
      email: 'test@example.com',
      password: 'password'      
    )
    expect(user).to be_valid
  end

  it 'is invalid without an email address' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with duplicate email address' do
    User.create(email: 'test@example.com', password: 'password')
    user = User.new(email: 'test@example.com', password: 'password')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end