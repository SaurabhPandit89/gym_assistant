class CreateMembershipPlans < ActiveRecord::Migration
  def change
    create_table :membership_plans do |t|
      t.string :plan_name
      t.text :plan_description

      t.timestamps null: false
    end
  end
end
