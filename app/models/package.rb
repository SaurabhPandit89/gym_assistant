class Package < ActiveRecord::Base
  
  belongs_to :membership_plan
  has_many :users
  
end
