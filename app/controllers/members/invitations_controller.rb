class Members::InvitationsController < Devise::InvitationsController
  def edit
    # store the invitation token in a session cookie.
    # if the member chooses to use an omniauth provider
    # for login, we'll need it in the callback.
    cookies[:token] = params[:invitation_token]
    super
  end
end
