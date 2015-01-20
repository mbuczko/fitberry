class DeviseCreateUsers < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    User.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password') if direction == :up
  end

  def change
    create_table(:users) do |t|
      t.integer :user_id
      t.integer :team_id
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_secret
      t.string :password
      t.string :encrypted_password
      t.string :avatar
      t.string :town
      t.string :gender
      t.string :nickname
      t.string :about
      t.string :department
      t.string :role
      t.date   :birth

      t.timestamps
    end

    add_index :users, [:uid, :provider],  :unique => true
    add_index :users, :email,  :unique => true
  end
end
