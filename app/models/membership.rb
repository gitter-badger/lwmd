class Membership < ActiveRecord::Base
  CATEGORIES = [ "Individual", "Family" ]

  MAX_FAMILY_MEMBERS = 4

  ### Relations
  has_many :member_memberships, inverse_of: :membership
  has_one :primary_member, -> { where primary: true },
                              class_name: "MemberMemberships"
  has_many :members, through: :member_memberships

  accepts_nested_attributes_for :member_memberships,
    reject_if: proc { |m| m[:member_id].blank? }

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

  validate do
    has_a_member
    max_one_member_for_individual_plan
    max_members_for_family_plan
  end

  ### Methods
  def self.member_ids_for_year(year)
    Membership.joins(:members).where(year: year).pluck('members.id')
  end

  ### Instance Methods
  def build_family
    3.times { member_memberships.build }
  end

  def build_primary
    member_memberships.build(primary: true)
  end

  def expires_on
    # in this use case, expiration is always based on
    # calendar year. So this is a date object set to the
    # last day of the year corresponding to the
    # :year attribute.
    expiration_date = DateTime.new(self.year)
    expiration_date.at_end_of_year
  end

  def total_member_memberships
    member_memberships.reject(&:marked_for_destruction?)
  end

  def member_ids
    members.pluck(:id)
  end

  ### Private Methods
  private
  def has_a_member
    errors.add :members, "You need at least one member" if total_member_memberships.empty?
  end

  def max_one_member_for_individual_plan
    if total_member_memberships.count > 1 && category == "Individual"
      errors.add :members, "Only one member allowed in this plan"
    end
  end

  def max_members_for_family_plan
    if total_member_memberships.count > MAX_FAMILY_MEMBERS
      errors.add :members, "Only #{MAX_FAMILY_MEMBERS} members allowed per membership"
    end
  end

end
