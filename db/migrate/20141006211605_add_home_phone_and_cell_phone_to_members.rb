class AddHomePhoneAndCellPhoneToMembers < ActiveRecord::Migration
  def change
    add_column :members, :home_phone, :string
    add_column :members, :cell_phone, :string
  end
end
