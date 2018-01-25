require 'rails_helper'

describe Contract do


  it "belongs to a venue" do
    c = Contract.new
    v = Venue.new
    c.venue = v
    expect(c.venue).to eq(v)
  end

  it "has a location through its venue" do
    c = Contract.new
    v = Venue.new
    l = Location.new
    c.venue = v
    c.venue.location = l
    expect(c.venue.location).to eq(l)
  end

  it "has many categories" do
    c = Contract.new
    c2 = Category.new
    c3 = Category.new
    c.categories << c2
    c.categories << c3
    expect(c.categories).to eq([c2, c3])
  end

  it "belongs to a designer" do
    c = Contract.new
    d = Designer.new
    c.designer = d
    expect(c.designer).to eq(d)
  end

  it "has a fee" do
    c = Contract.new
    c.fee = 100
    expect(c.fee).to eq(100)
  end

  it "has a real opening Date" do
    c = Contract.new
    c.opening_date = DateTime.new(1994, 01, 19)
    expect(c.opening_date).to be_a(Date)
  end

end
