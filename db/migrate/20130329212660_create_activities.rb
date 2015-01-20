class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :challange_id
      t.integer :active_score
      t.integer :calories_out
      t.integer :steps
      t.float   :distance

      t.timestamps
    end
  end
end
