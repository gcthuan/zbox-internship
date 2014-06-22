class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.text :questlist

      t.timestamps
    end
  end
end
