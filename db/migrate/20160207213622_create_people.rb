class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, index: true
      t.string :last_name, index: true
      t.string :email, index: true
      t.string :password_digest, index: true
      t.integer :role, index: true
      t.string :token, index: true
      t.text :biography

      t.timestamps null: false
    end
  end
end
