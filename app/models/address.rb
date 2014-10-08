class Address < ActiveRecord::Base

  attr_accessor :full_address
  ### Relations
  belongs_to :member

  ### Validations

  ### Callbacks

  ### Instance Methods
  def to_s
    StreetAddress::US.parse(self.line1 + " " +
                            self.city + " " +
                            self.state + " " +
                            self.postal_code)
  end
end
