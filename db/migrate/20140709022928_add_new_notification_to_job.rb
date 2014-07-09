class AddNewNotificationToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :new_notification, :integer, default: 0
  end
end
