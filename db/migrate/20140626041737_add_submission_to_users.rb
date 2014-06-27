class AddSubmissionToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :submission, :string
  end
  def self.down
	remove_column :users, :submission
  end
end
