class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :age, null: false
      t.string :nursery_school, null: false
      t.string :kindergarten, null: false
      t.string :primary_school, null: false
      t.string :junior_high_school, null: false
      t.string :high_school, null: false
      t.string :university, null: false
      t.integer :living_alone_funds, null: false
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
