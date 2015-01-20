class ChangeChallangesTypes < ActiveRecord::Migration
  def change
    change_table :challanges do |t|
      t.change :title, :text
      t.change :description, :text
    end
  end
end
