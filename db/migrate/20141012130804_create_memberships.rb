class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :category, null: false
      t.integer :year, null: false
      t.decimal :price_paid, null: false
      t.date :date_paid, null: false
      t.boolean :active, default: true, null: false
      t.text :notes
    end
  end
end
