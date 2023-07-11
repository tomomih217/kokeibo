class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :item, null: false
      t.integer :amount, null: false
      t.integer :payment_day, null: false
      t.boolean :is_auto, default: false
      t.references :child

      t.timestamps
    end
  end
end
