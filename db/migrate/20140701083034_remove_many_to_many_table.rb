class RemoveManyToManyTable < ActiveRecord::Migration
  def change
  	drop_table :assignments
  end
end
