class AddJobToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :job_name, :string
  end
end
