class CreateTransformers < Kribi::Migration
  def change
    create_table :transformers do |t|

      t.timestamps null: false
    end
  end
end
