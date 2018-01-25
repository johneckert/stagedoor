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

gen = ['Male', 'Female', 'Non-Binary', 'Prefer not to answer']
birth_year = [*1950..1995]

100.times {designer = Designer.create(username: Faker::Pokemon.name, gender: gen.sample, birth_year: birth_year.sample, password: "password", ethnicity: eth.sample )}

#make some contracts

plays = ["A Christmas Carol", "Addams Family", "Aida", "American Idiot", "An American in Paris", "Anastasia", "Anatomy of Gray", "Angels in America", "Annie", "Annie Get Your Gun", "Antigone", "Anyone Can Whistle", "Anything Goes", "Applause", "Aspects of Love", "Assassins", "Avenue", "Babes in Arms", "Babes in Toyland",
  "The Band", "Bare", "Barnum", "Bat Boy the Musical", "Brighton Beach Memoirs", "Bring It On", "Evita", "Falsettos", "Fame", "The Fantasticks", "Fiddler on the Roof", "Finding Neverland", "Finian's Rainbow", "Flower Drum Song", "Follies", "Footloose", "Forbidden Broadway", "Forty-Second Street", "Free As Air",
  "Full Monty", "Funny Girl", "Garfield", "Gentlemen Prefer Blondes", "Gigi", "Girl Crazy", "Godspell", "Grease", "Groundhog Day", "Guys and Dolls", "Gypsy", "Hair", "Hairspray", "Half a Sixpence", "Hamilton: An American Musical", "Happy Days", "Harry Potter and the Cursed Child", "Heathers", "Hedwig and the Angry Inch",
  "Hello Dolly!", "The King and I", "Kinky Boots", "Kiss Me Kate", "Kismet", "Kiss of a Spider Woman", "Knickerbocker Holiday", "La Cage Aux Folles", "Last Five Years", "Legally Blonde", "Merrily We Roll Along", "Million Dollar Quartet", "Miss Saigon", "Murder Ballad", "The Music Man", "My Fair Lady", "New Girl in Town", "Newsies", "Next to Normal",
  "Nice Work If You Can Get It", "Nine", "No, No, Nanette", "No Strings", "Nunsense", "Oh, Coward!", "Oh, Kay!", "Oklahoma!", "Oliver!", "On a Clear Day You Can See Forever", "Once Upon a Mattress", "On the Town", "On the Verge", "Once on this Island", "Paint Your Wagon", "The Pajama Game", "Pal Joey", "Parade", "Patience",
  "Peter Pan", "The Phantom of the Opera", "Pipe Dream", "Pippin", "Porgy and Bess", "The Producers", "Promises, Promises", "Ragtime", "Rent", "Rocky Horror Show", "Salad Days", "Saturday Night Fever", "Scarlet Pimpernel", "School of Rock", "Scrooge", "Secret Garden", "Sound of Music", "South Pacific", "Spamalot",
   "Spelling Bee", "Spring Awakening", "Starmites", "State Fair", "Steel Magnolias", "Steel Pier", "Stop The World - I Want to Get Off!", "Strike Up the Band", "Sunday in the Park with George", "Sunset Boulevard", "Sweeney Todd", "Sweet Charity", "Swing", "Swingtime", "Thirteen", "Thoroughly Modern Millie", "The Threepenny Opera", "Tick Tick Boom", "Timeless", "Titanic",
   "To Kill A Mockingbird", "Tommy", "Twelve Angry Jurors", "Urinetown: The Musical", "West Side Story", "We Will Rock You", "Whistle Down the Wind", "White Christmas", "The Who's Tommy", "Wicked: The Musical", "Wild Party", "Wind in the Willows", "The Wiz", "The Wizard of Oz", "Wonderful Town", "Wonderland", "Xanadu", "Young Frankenstein", "You're a Good Man Charlie Brown", "Ziegfeld Follies"]


year = [*1996..2017].sample
day = [*01..28].sample
month = [*01..12].sample
random_date = DateTime.new(year,month,day)

10000.times {

  year = [*1996..2017].sample
  day = [*01..28].sample
  month = [*01..12].sample
  random_date = DateTime.new(year,month,day)

  contract = Contract.create(venue_id: [*1..159].sample, fee: [*1500..5000].sample, opening_date: random_date, musical: [true, false].sample, designer_id: [*1..100].sample, show_name: plays.sample)

  contract.categories << Category.find([*1..5].sample)

  contract.save
}
