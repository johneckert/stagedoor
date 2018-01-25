require 'csv'
require 'faker'

#create design categories
scenic = Category.find_or_create_by(name: "Scenic Design")
costumes = Category.find_or_create_by(name: "Costume Design")
lighting = Category.find_or_create_by(name: "Lighting Design")
sound = Category.find_or_create_by(name: "Sound Design")
projections = Category.find_or_create_by(name: "Projection Design")


#parse data from csv file and create theatre_data hash
csv_text = File.read('./db/seeds.csv')
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
theatre_data = csv.map do |row|
  row.to_hash
end

#itirate over theatre data hash and create Companies
theatre_data.each do |theatre_hash|
  #find or create location
  location = Location.find_or_create_by(name: theatre_hash["CITY"])

  #find or create company and associate with location
  company = Company.find_or_create_by(name: theatre_hash["COMPANY"])

  #create venue and associate to company
  venue = Venue.find_or_create_by(name: theatre_hash["VENUE"])
  venue.contract_type = "#{theatre_hash["CONTRACT "]} #{theatre_hash["RATING"]}"
  venue.company = company
  venue.location = location
  venue.save
end

#make some users
eth = ["Asian/Indian subcontinent", "Black", "Hispanic", "Native American", "Pacific Islander", "White", "Other"]

gen = ['Male', 'Female', 'Non-Binary', 'Prefer not to Answer']
birth_year = [*1950..1995]

100.times {designer = Designer.create(username: Faker::Simpsons.character, gender: gen.sample, birth_year: birth_year.sample, password: "password", ethnicity: eth.sample )}

#make some contracts
year = [*1996..2017].sample
day = [*01..28].sample
month = [*01..12].sample
random_date = Date.new(year,month,day)
########DATETIME GENERATION DOESNT WORK!!!!!!!!!

contract = Contract.create(venue_id: [1..159].sample, fee: [1500..5000], opening_date: random_date, musical: [true, false].sample, designer_id: [1..100], show_name: Faker::Book.title)
