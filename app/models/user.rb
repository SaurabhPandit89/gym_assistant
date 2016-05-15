class User < ActiveRecord::Base

  has_many :addresses
  has_many :phones
  belongs_to :membership_plan
  belongs_to :package

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :membership_plan

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :email, presence: true
  validates :emergency_contact, presence: true
  validates :membership_plan_id, presence: true
  validates :package_id, presence: true
  validates :joining_date, presence: true

  before_validation :set_membership_plan_id, :set_expiration_date

  scope :expiring_subscription, -> { where('DATE(expiration_date) <= DATE(?) AND DATE(expiration_date) - CURDATE() > 0', Date.today + 30.days) }
  scope :recently_added, -> { where('DATE(joining_date) >= DATE(?)', Date.today - 5.days) }

  def set_membership_plan_id
    package = Package.find(package_id)
    self.membership_plan_id = package.membership_plan_id
  end

  def set_expiration_date
    self.expiration_date = ((joining_date + package.contract_length.months) - 1.day).to_date
  end

  # def subscription_end_date
  #   ((joining_date + package.contract_length.months) - 1.day)
  # end

  # def self.expiring_subscription
  #   User.where("? <= #{30.days}", (Date.today - subscription_end_date))
  # end

end
