class AddHtmlizedToComment < ActiveRecord::Migration
  def change
    add_column :comments, :htmlized, :text
  end
end
