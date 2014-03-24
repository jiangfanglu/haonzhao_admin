class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      
      t.string :name, :username, :email, :password, :activation, :usertype, :token, :salt
      t.integer :block, :sendEmail, :resetCount, :thumbnail
      t.datetime :registerDate, :lastvisitDate, :lastResetTime
      t.text :params

      t.timestamps
    end
  end
end
