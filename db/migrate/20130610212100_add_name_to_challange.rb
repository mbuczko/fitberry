class AddNameToChallange < ActiveRecord::Migration
  def change
    add_column :challanges, :name, :string
  end
end
