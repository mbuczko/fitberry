class AddChallangeToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :challange_id, :integer
  end
end
