class AddPaymentCollectionIdToPayments < ActiveRecord::Migration[6.1]
  def change
    add_reference :payments, :payment_collection, null: false, foreign_key: true
  end
end
