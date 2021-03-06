class AddTaxTotalsToOrder < ActiveRecord::Migration
  def up
    add_column :spree_orders, :included_tax_total, :decimal,
               precision: 10, scale: 2, null: false, default: 0.0

    add_column :spree_orders, :additional_tax_total, :decimal,
               precision: 10, scale: 2, null: false, default: 0.0
  end

  def down
    remove_column :spree_orders, :included_tax_total
    remove_column :spree_orders, :additional_tax_total
  end
end
