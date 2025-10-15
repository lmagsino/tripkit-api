class User < ApplicationRecord
  has_secure_password

  # Associations
  has_many :created_trips, class_name: 'Trip', foreign_key: 'creator_id', dependent: :destroy
  has_many :trip_memberships, dependent: :destroy
  has_many :trips, through: :trip_memberships
  has_many :expenses, foreign_key: 'paid_by_user_id', dependent: :destroy
  has_many :expense_splits, dependent: :destroy
  has_many :itinerary_items, foreign_key: 'created_by_user_id', dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?

  # Normalize email to lowercase
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end