class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # invitation_token will be included if the member is setting up
    # the connection for the first time
    auth = request.env["omniauth.auth"]

    # not getting provider or ui
    logger.info auth.inspect
    
    token = cookies[:token]
    @member = Member.from_omniauth(auth, token)
    cookies.delete :token
    if @member.persisted?
      sign_in_and_redirect @member, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:error] = "Sorry! We could not connect you with any member account."
      redirect_to unauthenticated_root_path
    end
  end
end
