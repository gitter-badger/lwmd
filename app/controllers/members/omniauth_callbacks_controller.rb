class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # invitation_token will be included if the member is setting up
    # the connection for the first time
    auth = request.env["omniauth.auth"]
    token = cookies[:token]
    if token.present?
      @member = Member.accept_invitation!(:invitation_token => token)
      if @member
        # https otherwise it tries to redirect and errors
        profile_photo_url = auth.info.image
        https_url = profile_photo_url.gsub("­http","htt­ps")
        @member.update_attributes!(provider: auth.provider,
                                   uid: auth.uid,
                                   avatar: https_url)
      end
    else
      @member = Member.where(provider: auth.provider, uid: auth.uid).first
    end
    if @member
      # delete the cookie in case they get in to this workflow again
      # during the session
      cookies.delete :token
      sign_in_and_redirect @member, :event => :authentication #this will throw if @member is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:error] = "Sorry! We could not connect you with any member account."
      redirect_to unauthenticated_root_path
    end
  end
end
