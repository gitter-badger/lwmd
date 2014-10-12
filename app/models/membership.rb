class Membership < ActiveRecord::Base
  CATEGORIES = [ "Individual", "Family" ]

  ### Relations
  has_many :member_memberships
  has_many :members, through: :member_memberships

  ### Validations

  validates :category,
    presence: true,
    inclusion: { in: CATEGORIES }

  validates :price_paid,
    presence: true

  validates :year,
    presence: true

  validates :date_paid,
    presence: true

  ### Instance Methods
  def expires_on
    # in this use case, expiration is always based on
    # calendar year. So this is a date object set to the
    # last day of the year corresponding to the
    # :year attribute.
    expiration_date = DateTime.new(:year)
    expiration_date.at_end_of_year
  end

end
