class User < ApplicationRecord
  # Validation rules
  validates :email, presence: true,
                    uniqueness: true

  # Relationships
  has_many :tips
  has_many :comments
  has_and_belongs_to_many :favourites, class_name: Tip.name

  has_secure_password

  # Pagination
  paginates_per 6
end
