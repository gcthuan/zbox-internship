class AddDescriptionToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :description, :string
  	change_column :jobs, :description, :string
  	add_column :jobs, :body, :text
  end
end
