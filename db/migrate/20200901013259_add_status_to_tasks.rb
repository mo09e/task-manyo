class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string
    Task.update_all(status: '未着手')
    change_column_null :tasks, :status, false
  end
end
