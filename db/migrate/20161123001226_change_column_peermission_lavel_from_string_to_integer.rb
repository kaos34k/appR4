class ChangeColumnPeermissionLavelFromStringToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :users,:peermission_lavel, :string
    add_column :users,:peermission_lavel, :integer, default: 1
  end
end
