class CreateStamps < ActiveRecord::Migration[6.1]
  def change
    create_table :stamps do |t|
      t.references :child, null: false, foreign_key: true
      t.integer :status, default: 0
      t.datetime :stamped_at, null: false

      t.timestamps
    end
  end
end
