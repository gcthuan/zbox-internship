class AddDeadlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deadline, :datetime
  end
end
