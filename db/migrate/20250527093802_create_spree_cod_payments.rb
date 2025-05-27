class CreateSpreeCodPayments < ActiveRecord::Migration[8.0]
  def change
    create_table :spree_cod_payments, if_not_exists: true do |t|
      t.references :user
      t.decimal :cod_fee, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
