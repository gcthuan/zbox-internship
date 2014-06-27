class AddIdToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :user_id, :integer
  	add_column :assignments, :job_id, :integer
  end
end
