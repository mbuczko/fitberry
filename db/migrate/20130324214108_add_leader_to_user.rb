class AddLeaderToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_lead, :boolean
  end
end
