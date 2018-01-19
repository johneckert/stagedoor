MOD 2 FINAL PROJECT

 - Designer  —- has_many DesignCategories, has_many Categories through: DesignCategories has_many Contracts
 -- name:string, union_id:integer, password:string
- DesignerCategories
-- belongs_to Designer, belongs_to Category
 - Category —- has_many Users, has many Contracts
	- Lighting
	- Scenic
	- Costume
	- Sound
	- Projection
-- name:string, assistant:boolean(default false)
- Location —- has_many companies, has many venues through companies
--  name:string
- Company —- Has many Venues, Has many Contracts through Venues, Belongs_to Location
-- name:string
- Venue —- Belongs to Company. Has_many Contracts
-- name:string
- Contract —- Belongs to Venue, Belongs to User, Belongs to Design Category
	—- Conditional columns based on Contract_type, or prepare for ‘nil’ values to autofill.
	—- category:string (e.g. Musical / Non Musical), type:string, fee:integer


Things that should be built in:
	-- Categories, Companies, Venues, Contract.Type / have base data

To Do
	-- Venue contract type method
	-- Graphs / Data Visualization / Interesting UI

TESTS
