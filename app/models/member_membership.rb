class MemberMembership < ActiveRecord::Base

  ### Relations
  belongs_to :member
  belongs_to :membership

  ### Validations
  validates_presence_of :member
  validates_presence_of :membership

  validate :has_only_one_membership_per_year,
    on: :create

  accepts_nested_attributes_for :member

  ### Instance Methods
  def primary?
    primary
  end

  private
  def has_only_one_membership_per_year
    if Membership.member_ids_for_year(membership.year).include?(member_id)
      membership.errors.add :base, 'This member is already paid for the year'
    end
  end
end
