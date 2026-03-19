class AddTrackingFieldsToHabits < ActiveRecord::Migration[7.2]
  def change
    add_column :habits, :category, :string
    add_column :habits, :frequency_per_week, :integer, null: false, default: 7
    add_column :habits, :priority, :string, null: false, default: "media"
    add_column :habits, :reminder_time, :time
    add_column :habits, :active, :boolean, null: false, default: true
  end
end
