class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false
      t.text :content, nul: false

      t.timestamps
    end
  end
end
