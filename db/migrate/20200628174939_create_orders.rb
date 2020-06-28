class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :username
      t.string :phone
      t.string :adres
      t.string :orders

      t.timestamps
    end
  end
end
