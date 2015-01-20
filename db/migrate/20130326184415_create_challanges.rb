class CreateChallanges < ActiveRecord::Migration
  def change
    create_table :challanges do |t|
      t.string  :title
      t.string  :description
      t.integer :distance_steps
      t.float   :distance_km
      t.boolean :active
      t.date    :activation_date

      t.timestamps
    end
  end
end
