class User < ApplicationRecord
  has_many :submissions

  validates :name, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password
  
  enum :role, { default: 0, manager: 1, admin: 2 }
end