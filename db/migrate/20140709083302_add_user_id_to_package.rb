class AddUserIdToPackage < ActiveRecord::Migration
  def change
  	add_column :packages, :user_id, :integer
  end
end
