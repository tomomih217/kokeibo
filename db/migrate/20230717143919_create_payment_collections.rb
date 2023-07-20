class CreatePaymentCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_collections do |t|
      t.references :child
      t.datetime :paymented_at

      t.timestamps
    end
  end
end
