class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  enum :status, { draft: 0, published: 1 }, default: :draft
end
