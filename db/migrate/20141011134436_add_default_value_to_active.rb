class AddDefaultValueToActive < ActiveRecord::Migration
  def up
    change_column_default :members, :active, true
  end

  def down
    change_column_default :members, :active, nil
  end
end
