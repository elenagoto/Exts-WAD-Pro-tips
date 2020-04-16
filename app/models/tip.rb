class Tip < ApplicationRecord
  # Validation rules
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :body,  presence: true

  # Relationships
  belongs_to :user
  has_many   :comments
  has_and_belongs_to_many :users

  # Scopes
  scope :most_recent_active, -> { order(updated_at: :desc).limit(4) }
  scope :title_contains, ->(term) { where('title LIKE ?', "%#{term}%") }
  scope :body_contains, ->(term) { where('body LIKE ?', "%#{term}%") }
  scope :search, ->(search_term) { title_contains(search_term).or(body_contains(search_term)) }
end
