class AddCodFeeToShippingMethods < ActiveRecord::Migration[8.0]
  def change
    add_column :spree_shipping_methods, :cod, :boolean, default: false, null: false
  end
end
