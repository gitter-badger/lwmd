class HelpsController < ApplicationController

  def index

  end

  def verify
    @member = Member.where(email: params[:email]).first
    if @member.present?
      if @member.invitation_accepted_at.present?
        # send a password reset
        @member.send_reset_password_instructions
        flash[:notice] = "We found your account! Looks like you may have forgotten \
        your password. We send a reset link to your email account #{@member.email}. \
        You can use it to set your password and log in."
        redirect_to confirm_path
      else
        # member doesn't have an invite or hasn't used it. Send another.
        @member.invite!
        flash[:notice] = "We found your account! You need an invitation token \
        to sign in, though. We sent one to #{@member.email}. Check your inbox \
        and spam filters, just in case."
        redirect_to confirm_path
      end
    else
      flash[:error] = "We couldn't find an account with email #{params[:email]}. \
      Could the account be under a different email?"
      redirect_to help_path
    end
  end

  def confirm

  end
end
