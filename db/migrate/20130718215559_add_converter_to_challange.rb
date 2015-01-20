class AddConverterToChallange < ActiveRecord::Migration
  def change
    add_column :challanges, :converter, :float
  end
end
