class MembersController < ApplicationController

  def index
    @members = Member.order('last_name')
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_path, notice: "Member added successfully"
    else
      render "new"
    end
  end

  private
    def member_params
      params.require(:member).permit(:first_name,
                                     :last_name,
                                     :email,
                                     :birthdate,
                                     :gender,
                                     :usat_number,
                                     :notes)
    end
end
