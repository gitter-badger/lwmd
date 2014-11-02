class MembershipsController < ApplicationController

  def index
    @memberships = Membership.order('lower(members.last_name)').joins(:members)
  end

  def new
    @membership = Membership.new
    @category = params[:category].present? ? "Family" : "Individual"
    @membership.build_primary
    if params[:category].present? && params[:category] == "Family"
      @membership.build_family
    end
    @members = Member.all
  end

  def create
    @membership = Membership.new(membership_params)

    if @membership.save
      flash[:notice] = "Membership added successfully"
      redirect_to memberships_path
    else
      @members = Member.all
      render "new", category: params[:category]
    end
  end

  private
  def membership_params
      params.require(:membership)
            .permit(:category,
                    :price_paid,
                    :year,
                    :date_paid,
                    member_memberships_attributes:  [:primary, :member_id])
  end
end
