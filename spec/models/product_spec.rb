require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'is valid with valid attributes' do
      category = Category.create(name: 'Bush')
      product = Product.new(name: 'Scraggly Bush', price: 999.99, quantity: 10, category: category)
      expect(product).to be_valid
    end

    it 'is invalid without a name attribute' do
      category = Category.create(name:'Hydrangeas')
      product = Product.new(name: nil, price: 99.99, quantity: 10, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without a price attribute' do
      category = Category.create(name: 'Hydrangeas') 
      product = Product.new(name: 'Test', quantity: 10, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is invalid without a quantity attribute' do
      category = Category.create(name: 'Hydrangeas') 
      product = Product.new(name: 'Test', price: 99.99, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'is invalid without a category' do
      product =Product.new(name: 'Test', price: 99.99, quantity: 10)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
