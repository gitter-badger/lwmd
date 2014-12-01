require 'test_helper'

class Api::EndpointsIntegrationTest < ApiTest

  describe "pinging the endpoint" do

    it "returns a successful request when a correct API Key is used" do
      header "Api-Key", "#{ZAPIER_SECRET_TOKEN}"
      get api_ping_path
      last_response.ok?.must_equal true
    end

    it "errors when an invalid API key is used" do
      get api_ping_path
      last_response.ok?.must_equal false
    end
  end

end
