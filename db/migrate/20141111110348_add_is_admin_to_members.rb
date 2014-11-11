class AddIsAdminToMembers < ActiveRecord::Migration
  def change
    add_column :members, :is_admin, :boolean, null: false, default: false
  end
end
