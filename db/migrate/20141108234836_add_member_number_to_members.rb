class AddMemberNumberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :member_number, :integer
  end
end
