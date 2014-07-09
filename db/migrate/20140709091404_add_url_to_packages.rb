class AddUrlToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :url, :string
  end
end
