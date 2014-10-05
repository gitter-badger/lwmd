class Member < ActiveRecord::Base
  enum gender: [ :male, :female ]

  ### Relations
  has_one :address, dependent: :destroy
  
  ### Validations
  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  validates :email,
    presence: true

  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    on: :create

  ### Instance Methods
  def name
    "#{first_name} #{last_name}"
  end
end
