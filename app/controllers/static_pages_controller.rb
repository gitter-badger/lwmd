class StaticPagesController < ApplicationController
  before_action :authenticate_member!, only: :profile
  
  def home

  end

  def profile
    @member = current_member
  end

end
