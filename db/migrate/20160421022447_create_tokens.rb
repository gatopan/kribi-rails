class CreateTokens < Kribi::Migration
  def change
    create_table :tokens do |t|
      t.integer :reedemed, index: true
      t.integer :type, index: true
      t.string :token, index: true

      t.timestamps null: false
    end
  end
end
