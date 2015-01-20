class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string   :title
      t.string   :description
      t.string   :author
      t.datetime :published_at

      t.timestamps
    end
  end
end
