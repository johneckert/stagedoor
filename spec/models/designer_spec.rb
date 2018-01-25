require 'rails_helper'

describe Designer do

  it "validates presence of all fields" do
    des = Designer.new
    expect(des.save).to eq(false)
    des.gender = "Male"
    expect(des.save).to eq(false)
    des.username = "julien!"
    expect(des.save).to eq(false)
    des.ethnicity = "Other"
    expect(des.save).to eq(false)
    des.birth_year = 1994
    expect(des.save).to eq(false)
    des.password = "julien!"
    expect(des.save).to eq(true)
  end


end
