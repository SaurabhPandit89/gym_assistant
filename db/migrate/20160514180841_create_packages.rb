class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.references :membership_plan
      t.integer :contract_length
      t.float :signup_fee

      t.timestamps null: false
    end
  end
end
