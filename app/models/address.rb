class Address < ActiveRecord::Base

  belongs_to :user

  validates :address_type, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

end
