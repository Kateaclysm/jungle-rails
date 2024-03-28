require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'Will fail if a password is not provided' do
      user = User.new(first_name: 'Kate', last_name: 'Hundt', email: 'kate@test.com', password_confirmation: 'Test')
      expect(user).not_to be_valid
    end

    it 'Will fail if a password confirmation is not provided' do
      user = User.new(first_name: 'Kate', last_name: 'Hundt', email: 'kate@test.com', password: 'Test')
      expect(user).not_to be_valid
    end

    it'Will fail if the password is not the same as the confirmed password field' do
      user= User.new(first_name: 'Kate', last_name: 'Hundt', email: 'kate@test.com', password:'Test', password_confirmation: 'Boo')
      expect(user).not_to be_valid
    end 
    it'Will reject a user with a duplicate email, regardless of case' do
      user= User.create!(first_name: 'Kate', last_name: 'Hundt', email: 'kate@example.com', password: 'Test', password_confirmation: 'Test')
      dupe_user = User.new(first_name: 'Kate', last_name: 'Hundt', email: 'KATE@example.com', password: 'Test', password_confirmation: 'Test')
      expect(dupe_user).not_to be_valid
  end
    it'Will reject a user missing a first_name' do
      user = User.new(last_name: 'Hundt', email: 'kate@example.com', password: 'Test', password_confirmation: 'Test')
      expect(user).not_to be_valid
    end

    it'Will reject a user missing a last_name' do
      user = User.new(first_name: 'Kate', email: 'kate@example.com', password: 'Test', password_confirmation: 'Test')
      expect(user).not_to be_valid
    end

    it'Will reject a user missing an email' do
      user = User.new(first_name: 'Kate', last_name: 'Hundt', password: 'Test', password_confirmation: 'Test')
      expect(user).not_to be_valid
    end

    it'Will reject a user if their password is shorter than 4 characters' do
      user = User.new(first_name: 'Kate', last_name: 'Hundt', password: 'Boo', password_confirmation: 'Boo')
      expect(user).not_to be_valid
    end

  end
  
  describe '.authenticate_with_credentials' do

    let!(:user) { User.create!(email: "test@example.com", password: "password123", first_name: "Test", last_name: "User", password_confirmation:'password123') } #<= sample user!

    it "authenticates a user with valid credentials" do
      authenticated_user = User.authenticate_with_credentials("test@example.com", "password123")
      expect(authenticated_user).to eq(user)
    end

    it'Accepts and authenticates a user regardless of white space' do
      authenticated_user = User.authenticate_with_credentials(" test@example.com", "password123")
      expect(authenticated_user).to eq(user)
    end

    it'Accepts a user and logs them in regardless of character case input' do
      authenticated_user = User.authenticate_with_credentials("TeSt@exAmPle.CoM", "password123")
      expect(authenticated_user).to eq(user)
    end
  end
end 
