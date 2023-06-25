class RemoveBirthdayFromChildren < ActiveRecord::Migration[6.1]
  def change
    remove_column :children, :birthday, :datetime
    rename_column :children, :age, :stage
  end
end
