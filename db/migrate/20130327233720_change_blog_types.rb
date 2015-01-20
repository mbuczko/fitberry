class ChangeBlogTypes < ActiveRecord::Migration
  def change
    change_table :blogs do |t|
      t.change :title, :text
      t.change :description, :text
    end
  end
end
