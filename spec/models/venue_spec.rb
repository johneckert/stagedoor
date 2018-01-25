require 'rails_helper'

describe Venue do

  it "belongs to location" do
    v = Venue.new
    l = Location.new
    v.location = l
    expect(v.location).to eq(l)
  end

  it "belongs to a company" do
    v = Venue.new
    c = Company.new
    v.company = c
    expect(v.company).to eq(c)
  end
end
