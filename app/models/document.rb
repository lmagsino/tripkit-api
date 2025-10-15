class Document < ApplicationRecord
  # Associations
  belongs_to :trip
  belongs_to :uploaded_by_user, class_name: 'User'
  has_one_attached :file

  # Validations
  validates :title, presence: true
  validates :document_type, presence: true, 
            inclusion: { in: %w[passport visa flight hotel insurance other] }
  validates :uploaded_at, presence: true

  # Callbacks
  before_validation :set_uploaded_at, on: :create

  private

  def set_uploaded_at
    self.uploaded_at ||= Time.current
  end
end