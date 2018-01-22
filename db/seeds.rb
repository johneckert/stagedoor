require 'csv'

#create design categories
scenic = Category.create(name: "Scenic Design")
costumes = Category.create(name: "Costume Design")
lighting = Category.create(name: "Lighting Design")
sound = Category.create(name: "Sound Design")
projections = Category.create(name: "Projection Design")


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
