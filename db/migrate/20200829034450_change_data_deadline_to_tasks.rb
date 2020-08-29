class ChangeDataDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :datetime
    Task.update_all(deadline: DateTime.now)
    change_column_null :tasks, :deadline, false
  end
end
