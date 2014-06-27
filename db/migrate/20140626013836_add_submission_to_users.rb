class AddSubmissionToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :submission, :string
  end
end
