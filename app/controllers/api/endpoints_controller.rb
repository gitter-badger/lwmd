class Api::EndpointsController < ApplicationController
  before_filter :validate_api_key

  def ping
      head :ok, content_type: "application/json"
  end
end
