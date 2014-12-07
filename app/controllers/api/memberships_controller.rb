class Api::MembershipsController < ApplicationController
  protect_from_forgery with: :null_session
  before_filter :validate_api_key

  def create
    mp = params[:membership]
    membership = Membership.new(category: mp[:category],
                                  year: mp[:year],
                                  date_paid: mp[:date_paid],
                                  price_paid: mp[:price_paid])
    members_attributes = membership_params[:members_attributes]
    members_attributes.each do |k,v|
      v[:gender] == "m" || "Male" ? v[:gender] = 0 : v[:gender] = 1
      initial_password = "password" + \
      SecureRandom.random_number(9999).to_s.rjust(4, "0")
      member = Member.find_or_initialize_by(email: v[:email]) do |m|
        m.first_name = v[:first_name]
        m.last_name = v[:last_name]
        m.avatar = v[:avatar]
        m.birthdate = v[:birthdate]
        m.gender = v[:gender]
        m.active = true
        m.usat_number = v[:usat_number]
        m.cell_phone = v[:cell_phone]
        m.home_phone = v[:home_phone]
        m.password = initial_password
        m.password_confirmation = initial_password
      end

      member.save
      if v[:full_address].present?
        address = Address.create(full_address: v[:full_address])
        member.address = address
      end
      if k == "0"
        membership.member_memberships.build(primary: true, member: member)
      else
        membership.member_memberships.build(member: member)
      end
    end
    if membership.save
      render json: membership, status: :ok
    else
      render :json => { :errors => membership.errors.full_messages }
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:category,
                             :price_paid,
                             :year,
                             :date_paid,
                             members_attributes: [
                              :member_id,
                              :first_name,
                              :last_name,
                              :avatar,
                              :email,
                              :birthdate,
                              :gender,
                              :active,
                              :usat_number,
                              :cell_phone,
                              :home_phone,
                              :notes,
                              :full_address
                            ]
                          )
  end
end
