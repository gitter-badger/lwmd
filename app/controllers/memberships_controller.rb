class MembershipsController < ApplicationController

  def index
    @memberships = Membership.order('lower(members.last_name)').joins(:members)
  end

  def new
    @membership = Membership.new
    @membership.members.build
    @members = Member.all
  end

  def create
    @membership = Membership.new(membership_params.except(:member))
    if params[:membership][:member][:id].present?
      @member = Member.find(params[:membership][:member][:id])
      # strong params hates my custom :member parameter
      @membership.members << @member
    end

    if @membership.save
      flash[:notice] = "Membership added successfully"
      redirect_to memberships_path
    else
      @members = Member.all
      render "new"
    end
  end

  private
  def membership_params
      params.require(:membership)
            .permit(:category,
                    :price_paid,
                    :year,
                    :date_paid,
                    member:  [:id])
  end
end
