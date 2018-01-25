require 'rails_helper'

describe Company do

  it "has a name" do
    comp = Company.new
    expect(comp.save).to eq(false)
    comp.name = "Scenic Design"
    expect(comp.save).to eq(true)
  end

end
