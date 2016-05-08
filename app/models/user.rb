class User < ActiveRecord::Base

  has_many :addresses
  has_many :phones

  accepts_nested_attributes_for :addresses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :email, presence: true
  validates :emergency_contact, presence: true

end
