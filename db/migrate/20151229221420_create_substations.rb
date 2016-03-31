class CreateSubstations < Kribi::Migration
  def change
    create_table :substations do |t|

      t.timestamps null: false
    end
  end
end
