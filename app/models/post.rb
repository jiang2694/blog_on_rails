class Post < ApplicationRecord
  belongs_to :user

  has_many(:comments, dependent: :destroy)
  validates(:title, presence: true, uniqueness: true)
  validates(:body, presence: true, length: { minimum: 10 })
end
