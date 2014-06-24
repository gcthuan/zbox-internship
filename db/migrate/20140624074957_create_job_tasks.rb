class CreateJobTasks < ActiveRecord::Migration
  def change
    create_table :job_tasks do |t|
      t.integer :job_id
      t.integer :package_id

      t.timestamps
    end
  end
end
