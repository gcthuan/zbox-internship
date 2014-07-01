class AddJobIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :job_id, :integer
  	add_index :users, :job_id
  end
end
