require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "Saves Product" do
      @category = Category.new(name: "Name")
      @product = Product.new(name: "Name", price_cents: 100, quantity: 2, category: @category)
      @product.save
      expect(@product.save).to be true
    end

    it "check to see if name is present" do
      @category = Category.new(name: "Name")
      @product = Product.new(name: nil, price_cents: 100, quantity: 2, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    
    it "throws an error with no price" do
      @category = Category.new(name: "Name")
      @product = Product.new(name: "Name", price_cents: nil, quantity: 2, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
    
    it "throws an error with no quantity" do
      @category = Category.new(name: "Name")
      @product = Product.new(name: "Name", price_cents: 100, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "throws an error with no category" do
      @category = Category.new(name: "Name")
      @product = Product.new(name: "Name", price_cents: 100, quantity: 2, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end

end
 