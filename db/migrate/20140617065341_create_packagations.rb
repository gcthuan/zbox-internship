class CreatePackagations < ActiveRecord::Migration
  def change
    create_table :packagations do |t|

      t.timestamps
    end
  end
end
