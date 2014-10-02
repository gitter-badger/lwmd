class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.date :birthdate
      t.boolean :active, default: true, null: false
      t.string :usat_number
      t.integer :gender
      t.text :notes

      t.timestamps
    end
  end
end
