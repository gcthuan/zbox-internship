class AddDefaultToDeadline < ActiveRecord::Migration
  def change
  	remove_column :users, :deadline
  	add_column :users, :deadline, :datetime, :default => Time.current
  end
end
