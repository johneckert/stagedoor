require 'rails_helper'

describe Category do

  it "has a name" do
    cat = Category.new
    expect(cat.save).to eq(false)
    cat.name = "Scenic Design"
    expect(cat.save).to eq(true)
  end
  
end
