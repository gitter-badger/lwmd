class MembersController < ApplicationController

  def index
    @members = Member.order('last_name')
  end

  def new
    @member = Member.new
    @address = @member.build_address
  end

  def create
    @member = Member.new(member_params)
    # this could be refactored to get out of the controller at some point
    if params[:member][:address_attributes][:full_address].present?
      entered_address = params[:member][:address_attributes][:full_address]
      parsed_address = StreetAddress::US.parse(entered_address)
      @address = @member.build_address
      @address.line1 = parsed_address.line1
      @address.city = parsed_address.city
      @address.state = parsed_address.state
      @address.postal_code = parsed_address.postal_code
    end

    if @member.save
      flash[:notice] = "Member added successfully"
      redirect_to members_path
    else
      render "new"
    end
  end

  def edit
    @member = Member.find(params[:id])
    @address = @member.build_address
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      flash[:notice] = "Member updated successfully"
      redirect_to members_path
    else
      render "edit"
    end
  end

  private
    def member_params
      params.require(:member)
            .permit(:first_name,
                    :last_name,
                    :email,
                    :birthdate,
                    :gender,
                    :usat_number,
                    :cell_phone,
                    :home_phone,
                    :notes,
                    {address_attributes: [:full_address]})
    end
end
