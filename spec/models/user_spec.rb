require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # Test for passwords
    it "It must be created with a password and password_confirmation fields" do
      @user = User.new(name: "Mike", email: "test@test.com", password: "mike", password_confirmation: 'mike')
      @user.save
      expect(@user).to be_present
    end
    
    it "It should not save if passwords don't match" do
      @user = User.new(name: "Mike", email: "test@test.com", password: "mike", password_confirmation: 'mark')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "It should not save if password is nil" do
      @user = User.new(name: "Mike", email: "test@test.com", password: nil, password_confirmation: 'mike')
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "It should not save if password is less then 3 characters" do
      @user = User.new(name: "Mike", email: "test@test.com", password: 'ab', password_confirmation: 'ab')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

    # Test for emails and name
    it "Name cannot be blank" do
      @user = User.new(name: nil, email: 'test@test.com', password: "mike", password_confirmation: "mike")
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "Email cannot be blank" do
      @user = User.new(name: "Mike", email: nil, password: "mike", password_confirmation: "mike")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should have a unique email" do
      @user1 = User.new(name: "Mike", email: "test@test.com", password: "mike", password_confirmation: "mike")
      @user2 = User.new(name: "Mark", email: "test@test.com", password: "mark", password_confirmation: "mark")
      @user1.save
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "should have a unique email (case sensitive)" do
      @user1 = User.new(name: "Mike", email: "test@test.com", password: "mike", password_confirmation: "mike")
      @user2 = User.new(name: "Mark", email: "Test@TEst.com", password: "mark", password_confirmation: "mark")
      @user1.save
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

  end

  # for logging in visitor
  describe 'authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      @user = User.new(name: "Mike", email: 'test@test.com', password: 'mike', password_confirmation: 'mike')
      @user.save

      @user = User.authenticate_with_credentials('test@test.com', 'mike')
      expect(@user).not_to be(nil)
    end
  end
    
  it 'should not pass with invalid credentials' do
    @user = User.new(name: "Mike", email: 'test@test.com', password: 'mike', password_confirmation: 'mike')
    @user.save

    @user = User.authenticate_with_credentials('test@test.com', 'mark')
    expect(@user).to be(nil)
  end

  it 'should pass even with whitespaces' do
    @user = User.new(name: "Mike", email: 'test@test.com', password: 'mike', password_confirmation: 'mike')
    @user.save

    @user = User.authenticate_with_credentials(' test@test.com ', 'mike')
    expect(@user).not_to be(nil)
  end

  it 'should pass even with caps in the email' do
    @user = User.new(name: "Mike", email: 'test@test.com', password: 'mike', password_confirmation: 'mike')
    @user.save

    @user = User.authenticate_with_credentials('TEst@teSt.com ', 'mike')
    expect(@user).not_to be(nil)
  end
  
end
