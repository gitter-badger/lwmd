class MembersController < ApplicationController
  before_action :authenticate_member!

  def index
    @members = Member.order('last_name')
  end

  def new
    @member = Member.new
    @address = @member.build_address
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      flash[:notice] = "Member added successfully"
      redirect_to members_path
    else
      render "new"
    end
  end

  def edit
    @member = Member.find(params[:id])
    if @member.address.present?
      @address = @member.address
    else
      @member.build_address
    end
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
                    :active,
                    :usat_number,
                    :cell_phone,
                    :home_phone,
                    :notes,
                    {address_attributes: [:full_address]})
    end
end
