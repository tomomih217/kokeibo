class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :age
      t.string :nursery_school
      t.string :kindergarten
      t.string :primary_school
      t.string :junior_high_school
      t.string :high_school
      t.string :university
      t.integer :living_alone_funds
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
