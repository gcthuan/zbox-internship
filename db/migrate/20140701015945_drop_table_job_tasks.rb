class DropTableJobTasks < ActiveRecord::Migration
  def up
  	drop_table :job_tasks
  end
  def down
	ActiveRecord::IrreversibleMigration
  end
end
