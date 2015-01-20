class AddBaseToUser < ActiveRecord::Migration
  def change
    add_column :users, :base_distance, :float, :default => 0
    add_column :users, :base_steps, :integer, :default => 0
    add_column :users, :base_calories, :integer, :default => 0
  end
end
