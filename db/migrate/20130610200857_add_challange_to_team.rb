class AddChallangeToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :challange_id, :integer
  end
end
