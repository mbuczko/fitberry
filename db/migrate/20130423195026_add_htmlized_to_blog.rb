class AddHtmlizedToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :htmlized, :text
  end
end
