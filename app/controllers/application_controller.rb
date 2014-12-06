class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def root_path_by_role
    if member_signed_in?
      if current_member.is_admin?
        memberships_path
      else
        member_root_path
      end
    else
      unauthenticated_root_path
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if current_member.is_admin?
      memberships_path
    else
      member_root_path
    end
  end

  def after_sign_out_path_for(resource)
    unauthenticated_root_path
  end

  def check_for_admin!
    unless current_member.is_admin?
      handle_authorization_error
    end
  end

  def check_for_admin_or_current_member!(resource)
    member = Member.find(resource)
    handle_authorization_error unless member_signed_in? &&
      (current_member.is_admin? || current_member == member)
  end

  def handle_authorization_error
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(root_path_by_role)
  end

  ###
  # API filter methods

  def validate_api_key
    unless api_key_valid?
      render json: {message: 'Invalid authentication token provided.'}, status: :bad_request
      return
    end
  end

  def api_key_valid?
    @authorization = request.headers["Api-Key"]
    return true if @authorization.present? && @authorization == ZAPIER_SECRET_TOKEN
  end
end
