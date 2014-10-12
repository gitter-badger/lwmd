class CreateMemberMemberships < ActiveRecord::Migration
  def change
    create_table :member_memberships do |t|
      t.integer :member_id, null: false
      t.integer :membership_id, null: false
      t.boolean :primary
    end
  end
end
