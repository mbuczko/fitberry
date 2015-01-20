class AddLocationToMilestone < ActiveRecord::Migration
  def change
    change_table :milestones do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
