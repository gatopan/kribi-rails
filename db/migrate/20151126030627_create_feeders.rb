class CreateFeeders < Kribi::Migration
  def change
    create_table :feeders do |t|

      t.timestamps null: false
    end
  end
end
