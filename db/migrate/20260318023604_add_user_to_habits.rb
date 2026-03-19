class AddUserToHabits < ActiveRecord::Migration[7.2]
  def change
    add_reference :habits, :user, null: false, foreign_key: true
  end
end
