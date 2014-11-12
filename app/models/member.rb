class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  MEMBER_SEED = 134
  enum gender: [ :male, :female ]

  ### Relations
  has_one :address, dependent: :destroy
  has_many :member_memberships, inverse_of: :member
  has_many :memberships, through: :member_memberships

  accepts_nested_attributes_for :address
  ### Validations
  phony_normalize :cell_phone, :default_country_code => 'US'
  phony_normalize :home_phone, :default_country_code => 'US'

  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  validates :email,
    uniqueness: true

  validates :member_number,
    uniqueness: true,
    numericality: { only_integer: true }

  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    on: :create

  validates :cell_phone,
    presence: {message: "is required if home phone isn't given"},
    unless: ->(member){member.home_phone.present?}
  validates :home_phone,
    presence: {message: "is required if cell phone isn't given"},
    unless: ->(member){member.cell_phone.present?}

  ### Callbacks
  before_validation :generate_member_number, on: :create

  ### Instance Methods
  def name
    "#{first_name} #{last_name}"
  end

  def generate_member_number
    if member_number.blank?
      position =  self.new_record? ? Member.count + 1 : id
      self.member_number = Integer(Date.today.year.to_s \
        + (position + MEMBER_SEED).to_s.rjust(5, "0"))
    end
  end
end
