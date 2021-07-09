class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :external_code
      t.integer :store_id
      t.string :sub_total
      t.string :delivery_fee
      t.decimal :total_shipping
      t.string :total
      t.string :country
      t.string :state
      t.string :city
      t.string :district
      t.string :street
      t.string :complement
      t.float :latitude
      t.float :longitude
      t.string :dt_order_create
      t.string :postal_code
      t.string :number

      t.timestamps
    end
  end
end
