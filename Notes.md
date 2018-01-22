MOD 2 FINAL PROJECT

-- Designer
  - has_many DesignerCategories, has_many Categories through: DesignCategories, has_many Contracts
  - name:string, union_id:integer, password:string, gender:string
-- DesignerCategory
  - belongs_to Designer, belongs_to Category
-- Category —- has many designer categories, has_many designers through designer categories, has many Contracts
  - Lighting
  - Scenic
  - Costume
  - Sound
  - Projection
  - name:string, assistant:boolean(default false)
-- Location
  - has_many companies, has many venues through companies
  -  name:string
-- Company
  - Has many Venues, Has many Contracts through Venues, Belongs_to Location
  - name:string, location:belongs_to
-- Venue —- Belongs to Company. Has_many Contracts
  - name:string, company:belongs_to
-- Contract
  - Belongs to Venue, Belongs to User, Belongs to Category
	- Autofill nil values for Contract fill out forms based on the type selected?
	- category:string (e.g. Musical / Non Musical), type:string, fee:integer, date:date (show opening date)


Things that should be built in:
	- Categories, Companies, Venues, Contract.Type / have base data

To Do
	- Venue contract type method
  - Base built in data listed above
	- Graphs / Data Visualization / Interesting UI (ruby gems?) -- GOOGLE
  - Tests
  - IF THERE IS TIME: Job Posting Board / Classifieds
  - What data do we want to display at each route?
  - Limit our routes to what's necessary
  - 'Project Only' contract autofill venue, allows user to type in / datalist
  - Function to calculate designer age based on birth_year / time.now.year
  - VALIDATIONS

  Julien Notes 1/20/18
  -> Should the assistant:boolean be in the Category table, or should it be in the Contract? I'm thinking maybe the Contract because it could change on a case by case basis, but I also wouldn't know. Doing it now as part of the Category model.
    --> moved to contract -JT
  -> What if the contract were the join table between user and category? would that make sense?
    --> Since contracts can have multiple categories, the join table should be there. Many to Many Category-Contract, and Designer has many categories through contracts that they've submitted. This allows us to remove the designer categories model/table.

  John Notes 1/21/18
  -> Contract has User ID not Designer ID, we should rename one or the other
    - done
  -> Wondering if we should remove union_id since we don't really need it.
    -done
  -> we don't need to track minimum fees
    -all good
  -> Assistant will require a little extra work, pay structure is different - we should talk about
    - fuck assistants remove this later
    - done

  Discussion Notes 1/22/18
  -> 'Project Only' contract is a one off contract that freelancers will experience, and will be where the database info is most key. Venue can be filled in to 'N/A' or something, but Company will need to be a datalist to fill in.
  -> change name to username
    - done
  -> remove union id
    - done
  -> add password column and bcrypt to user
    - done
  -> add age range, ethnicity, and optional for ALL
    - done
  -> add session controller
    - done
  -> switch: venue belongs to location and company, company has many locations through venue and vice versa
  -> data calcs
      - min, max, median, mean
      - within a time window (based on show date)
    ---> graph data visualization on this ^
    ---> use 'date select'
  -> import list of theaters/locations/companies/contract_type via google sheets csv
    --> location = city, contract_type = contract + rating
    --> how to load contract template based on venue? for now, drop down for each option, later, validates? > move contract_type to venue
    ---> done
  -> validates that company owns venue on form submit
  -> integrate ruby google charts wrapper in order to create graphs!
