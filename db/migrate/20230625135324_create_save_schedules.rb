class CreateSaveSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :save_schedules do |t|
      t.integer :age_from
      t.integer :age_to
      t.integer :amount
      t.references :child

      t.timestamps
    end
  end
end
