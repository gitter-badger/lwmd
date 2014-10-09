class Address < ActiveRecord::Base

  ### Relations
  belongs_to :member

  ### Validations
  before_save :break_apart_address
  ### Callbacks

  ### Instance Methods

  ### Private Methods
  private
  def break_apart_address
    puts "address is #{self.full_address}"
    address = StreetAddress::US.parse(self.full_address)
    unless address.nil?
      self.line1 = address.line1
      self.city = address.city
      self.state = address.state
      self.postal_code = address.postal_code
    end
  end
end
