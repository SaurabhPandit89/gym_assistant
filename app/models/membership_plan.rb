class MembershipPlan < ActiveRecord::Base
  
  has_many :packages
  has_many :users

  accepts_nested_attributes_for :packages, allow_destroy: true

end
