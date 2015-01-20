class AddHtmlizedToChallange < ActiveRecord::Migration
  def change
		add_column :challanges, :htmlized, :text
	end
end
