class RemoveChildFromPayments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :payments, :child
  end
end
