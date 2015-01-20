class AddSyncDateToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.datetime :last_sync_date
    end
  end
end
