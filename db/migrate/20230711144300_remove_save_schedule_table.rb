class RemoveSaveScheduleTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :save_schedules
  end
end
