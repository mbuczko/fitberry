class AddGmapsToMilestone < ActiveRecord::Migration
  def change
    change_table :milestones do |t|
      t.boolean :gmaps
    end
  end
end
