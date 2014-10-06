class Address < ActiveRecord::Base

  attr_accessor :full_address
  ### Relations
  belongs_to :member

  ### Validations

  ### Callbacks

  ### Instance Methods

end
