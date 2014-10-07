class Member < ActiveRecord::Base
  enum gender: [ :male, :female ]

  ### Relations
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address
  ### Validations
  phony_normalize :cell_phone, :default_country_code => 'US'
  phony_normalize :home_phone, :default_country_code => 'US'

  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  validates :email,
    presence: true

  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    on: :create

  validates :cell_phone,
    presence: {message: "is required if home phone isn't given"},
    unless: ->(member){member.home_phone.present?}
  validates :home_phone,
    presence: {message: "is required if cell phone isn't given"},
    unless: ->(member){member.cell_phone.present?}

  ### Instance Methods
  def name
    "#{first_name} #{last_name}"
  end
end
