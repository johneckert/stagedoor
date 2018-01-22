class MoveLocationBelongsToToVenue < ActiveRecord::Migration[5.1]
  def change
    remove_belongs_to :companies, :location
    add_belongs_to :venues, :location
  end
end
