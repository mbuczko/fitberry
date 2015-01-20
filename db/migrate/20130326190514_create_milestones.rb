class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.integer  :challange_id
      t.integer  :number
      t.string   :name
      t.float    :distance

      t.timestamps
    end
  end
end
