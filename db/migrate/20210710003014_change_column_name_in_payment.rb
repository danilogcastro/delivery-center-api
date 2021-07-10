class ChangeColumnNameInPayment < ActiveRecord::Migration[6.0]
  def change
    rename_column :payments, :type, :kind
  end
end
