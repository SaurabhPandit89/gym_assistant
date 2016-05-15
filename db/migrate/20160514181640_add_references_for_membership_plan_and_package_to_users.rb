class AddReferencesForMembershipPlanAndPackageToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :membership_plan, index: true, foreign_key: true
    add_reference :users, :package, index: true, foreign_key: true
  end
end
