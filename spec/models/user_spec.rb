require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  
    it "It must be created with a password and password_confirmation fields" do
      @user = User.new(name: "Mike", email: "test@test.com", password: "mike", password_confirmation: 'mike')
      @user.save!
      expect(@user).to be_present
    end

 

  end
end
