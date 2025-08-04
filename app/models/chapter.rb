class Chapter < ApplicationRecord
  belongs_to :book
  has_many_attached :photos

  validates :title, presence: true
  validates :content, presence: true
end
