class AddPackageAndQuestionIdToPackagation < ActiveRecord::Migration
  def change
  	add_column :packagations, :package_id, :integer
  	add_column :packagations, :question_id, :integer
  end
end
