class AddNullFalseToCv < ActiveRecord::Migration
  def change
  	remove_column :users, :cv
  	add_column :users, :cv, :string, :null => false, :default => ""
  end
end
