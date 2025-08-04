class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy

  enum :status, { draft: 0, published: 1 }, default: :draft

  validates :title, presence: true
  validates :author, presence: true
end
