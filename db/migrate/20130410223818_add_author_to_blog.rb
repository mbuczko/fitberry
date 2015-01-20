class AddAuthorToBlog < ActiveRecord::Migration
  def change
    change_table :blogs do |t|
      t.integer :user_id
    end
  end
end
