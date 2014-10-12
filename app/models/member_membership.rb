class MemberMembership < ActiveRecord::Base

  ### Relations
  belongs_to :member
  belongs_to :membership

  ### Validations

  ### Instance Methods

end
