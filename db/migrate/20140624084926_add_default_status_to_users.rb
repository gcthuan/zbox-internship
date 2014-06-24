class AddDefaultStatusToUsers < ActiveRecord::Migration
  def change
    change_column :users, :status, :string, :default => 'Registered'
  end
end
