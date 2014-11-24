class MembershipsController < ApplicationController
  before_action :authenticate_member!
  before_action :check_for_admin!

  def index
    @current_year = params[:year] || Date.today.year
    @memberships = Membership.joins(:members).where(year: @current_year)
    @unique_memberships = @memberships.uniq
    @memberships_count = @memberships.count
    @years = Membership.all.pluck(:year).uniq
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
