class AddNameToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :name, :string
    
  end
end
