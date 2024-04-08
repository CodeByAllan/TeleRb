# frozen_string_literal: true

require "httparty"
# Class responsability for  http services
class HttpClient
  include HTTParty
  def get(url, options = nil)
    self.class.get(url, query: options)
  end

  def post(url, options, headers = nil)
    self.class.post(url, body: options, headers: headers)
  end
end
