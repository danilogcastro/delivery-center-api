class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :external_code
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.decimal :total

      t.timestamps
    end
  end
end
