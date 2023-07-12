class CreatePlanCollectionTable < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_collection_tables do |t|
      t.string :references
      t.string :child

      t.timestamps
    end

    remove_reference :plans, :child
    add_reference :plans, :plan_collection, foreign_key: true
  end
end
