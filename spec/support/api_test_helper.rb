require 'json'

module ApiTestHelper
  def json_response
    JSON.parse(response.body)
  end
end
