class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :item, null: false
      t.integer :amount, null: false
      t.references :child

      t.timestamps
    end
  end
end
