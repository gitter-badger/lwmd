class MemberMembership < ActiveRecord::Base

  ### Relations
  belongs_to :member
  belongs_to :membership

  ### Validations
  validates_presence_of :member
  validates_presence_of :membership
  validates_associated :membership
  
  accepts_nested_attributes_for :member

  ### Instance Methods

end
