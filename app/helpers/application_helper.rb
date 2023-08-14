require 'json'
require "httparty"

module ApplicationHelper
  def ocrVeryfi(urlPhoto)
    url = "https://api.veryfi.com/api/v8/partner/documents"
    headers = {
      "Content-Type" => 'application/json',
      "Accept" => 'application/json',
      "CLIENT-ID" => ENV['CLIENT_ID_VERYFI'],
      "AUTHORIZATION" => "apikey #{ENV['API_KEY_VERYFI']}"
    }

    payload = {
      file_url: urlPhoto
    }.to_json

    response = HTTParty.post(url, headers: headers, body: payload)
    data = JSON.parse(response.body)
  end
end
