class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birth_date
      t.string :email
      t.string :gender
      t.string :emergency_contact

      t.timestamps null: false
    end
  end
end
