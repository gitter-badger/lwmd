class AddDeviseInvitableToMembers < ActiveRecord::Migration
  def change
      add_column :members, :invitation_token, :string
      add_column :members, :invitation_created_at, :datetime
      add_column :members, :invitation_sent_at, :datetime
      add_column :members, :invitation_accepted_at, :datetime
      add_column :members, :invitation_limit, :integer
      add_column :members, :invited_by_id, :integer
      add_column :members, :invited_by_type, :string
      add_index :members, :invitation_token, :unique => true
  end

  # Allow null encrypted_password
  change_column :members, :encrypted_password, :string, :null => true
end
