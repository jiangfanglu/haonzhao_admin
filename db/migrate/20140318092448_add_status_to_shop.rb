class AddStatusToShop < ActiveRecord::Migration
  def change
    add_column :oc_manufacturer, :status, :string
  end
end
