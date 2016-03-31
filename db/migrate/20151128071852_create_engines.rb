class CreateEngines < Kribi::Migration
  def change
    create_table :engines do |t|

      t.timestamps null: false
    end
  end
end
