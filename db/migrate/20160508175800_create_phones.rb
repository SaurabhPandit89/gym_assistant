class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :user
      t.string :p_type
      t.string :p_number

      t.timestamps null: false
    end
  end
end
