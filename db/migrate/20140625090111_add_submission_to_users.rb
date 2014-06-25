class AddSubmissionToUsers < ActiveRecord::Migration
  def self.up
  	add_attachment :users, :submission
  end

  def self.down
  	remove_attachment :users, :submission
  end
end
