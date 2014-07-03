class AddAppointmentDateToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :appointment_date, :datetime
  end
end
