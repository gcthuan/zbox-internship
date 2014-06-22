class DeleteQuestListFromPackage < ActiveRecord::Migration
  def change
  	remove_column :packages, :questlist, :text
  end
end
