class AddIsAutoToPaymentCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_collections, :is_auto, :boolean, default: false
  end
end
