# frozen_string_literal: true

require "httparty"
# Class responsability for  http services
class HttpClient
  include HTTParty
  def get(url, options)
    self.class.get(url, query: options)
  end

  def post(url, options)
    self.class.post(url, body: options)
  end
end
