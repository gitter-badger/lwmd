class Api::EndpointsController < ApplicationController
  respond_to :json

  def ping
    @authorization = request.headers["Api-Key"]
    if @authorization.present? && @authorization == ZAPIER_SECRET_TOKEN
      head :ok, content_type: "application/json"
    else
      payload = {
        error: "Invalid authentication token provided."
      }
      render :json => payload, :status => :bad_request
    end
  end
end
