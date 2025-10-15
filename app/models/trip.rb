class Trip < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: 'User'
  has_many :trip_memberships, dependent: :destroy
  has_many :users, through: :trip_memberships

  # Validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :base_currency, presence: true
  validates :active_currency, presence: true
  validates :invite_code, presence: true, uniqueness: true
  validate :end_date_after_start_date

  # Callbacks
  before_validation :generate_invite_code, on: :create
  after_create :add_creator_as_member

  private

  def generate_invite_code
    self.invite_code ||= loop do
      code = SecureRandom.alphanumeric(6).upcase
      break code unless Trip.exists?(invite_code: code)
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def add_creator_as_member
    trip_memberships.create(user: creator, role: 'creator')
  end
end