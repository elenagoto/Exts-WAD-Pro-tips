class User < ApplicationRecord
  # Callbacks
  before_validation :downcase_email
  after_initialize :default_role!

  # Validation rules
  validates :email, presence: true,
                    uniqueness: true

  # Relationships
  has_many :tips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :favourites, class_name: Tip.name

  has_secure_password

  # Pagination
  paginates_per 6

  # Uploader
  mount_uploader :avatar, AvatarUploader

  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end
end
