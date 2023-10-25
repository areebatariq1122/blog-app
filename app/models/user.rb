class User < ApplicationRecord
  rolify
  extend Devise::Models
  
  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: [:standard, :visitor, :admin]

  ROLES = %w[standard visitor admin] 


  def add_admin_role
    self.add_role(:admin)
  end

  def add_visitor_role
    self.add_role(:visitor)
  end

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end
end
