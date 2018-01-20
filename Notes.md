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
	- Graphs / Data Visualization / Interesting UI (ruby gems?)
  - Tests
  - IF THERE IS TIME: Job Posting Board / Classifieds

  Julien Notes 1/20/18
  -> Added all of our models as resources except for 'DesignerCategory' that we'll be able to access as pages for stats etc. Using generate model for the join table since don't think we'll need it.
  -> Should the assistant:boolean be in the Category table, or should it be in the Contract? I'm thinking maybe the Contract because it could change on a case by case basis, but I also wouldn't know. Doing it now as part of the Category model.
    --> moved to contract
  -> What if the contract were the join table between user and category? would that make sense?
    --> Since contracts can have multiple categories, the join table should be there. Many to Many Category-Contract, and Designer has many categories through contracts that they've submitted. This allows us to remove the designer categories model/table.
