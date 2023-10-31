class User < ApplicationRecord
  rolify
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { standard: 0, visitor: 1, admin: 2 }

  ROLES = %w[standard visitor admin]

  def add_admin_role
    add_role(:admin)
  end

  def add_visitor_role
    add_role(:visitor)
  end

  after_initialize do
    self.role ||= :standard if new_record?
  end
end
