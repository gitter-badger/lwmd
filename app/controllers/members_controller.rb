class MembersController < ApplicationController

  def index
    @members = Member.order('last_name')
  end

end
