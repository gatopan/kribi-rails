class CreateGrids < Kribi::Migration
  def change
    create_table :grids do |t|

      t.timestamps null: false
    end
  end
end
