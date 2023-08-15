class AddFromAgeForNurserySchoolToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :from_age_for_nursery_school, :integer, default: 0
  end
end
