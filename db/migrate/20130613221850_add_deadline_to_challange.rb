class AddDeadlineToChallange < ActiveRecord::Migration
  def change
    add_column :challanges, :deadline, :datetime
  end
end
