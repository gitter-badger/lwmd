desc "Adds sample member data"
task seed_members: [:environment] do
  member_params = [
    { first_name:   'Example',
      last_name:    'Member',
      email:        'ptc_member@example.com',
      birthdate:    '1985-10-26',
      gender:       0,
      usat_number:  '2012000000001',
      address: Address.create!(line1: "123 Any Street",
                               city: "Pittsburgh",
                               state: "PA",
                               postal_code: "15222"),
      cell_phone: "555-555-5555"}
  ]

  member_params.each do |params|
    Member.where(email:params[:email]).first_or_initialize do |member|
      member.update_attributes!(params)
    end
  end
end
