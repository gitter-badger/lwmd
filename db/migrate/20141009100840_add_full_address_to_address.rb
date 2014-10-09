class AddFullAddressToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :full_address, :string, length: 500
  end
end
