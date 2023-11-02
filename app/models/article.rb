class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10 }
  
  def comment_count
    comments.count
  end
end

