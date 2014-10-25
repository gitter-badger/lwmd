class Membership < ActiveRecord::Base
  CATEGORIES = [ "Individual", "Family" ]

  ### Relations
  has_many :member_memberships, inverse_of: :membership
  has_many :members, through: :member_memberships

  accepts_nested_attributes_for :members

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

  validates :members,
    presence: {message: ": you need at least one of them"}
  ### Methods

  ### Instance Methods
  def expires_on
    # in this use case, expiration is always based on
    # calendar year. So this is a date object set to the
    # last day of the year corresponding to the
    # :year attribute.
    expiration_date = DateTime.new(self.year)
    expiration_date.at_end_of_year
  end

end
