class RemoveChildFromPayments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :payments, :child, null: false, foreign_key: true
  end
end
