require 'rails_helper'
require 'product'

RSpec.describe Product, type: :model do
  it "has a valid product" do
    expect(Product.new).to be_valid
  end
end