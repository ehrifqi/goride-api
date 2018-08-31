class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {in: 6..20}
  validates :full_name, presence: true
  validates :phone_number, presence: true, length: {in: 11..13}

  has_one :member_detail
end
