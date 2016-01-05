require 'faraday'
require 'json'

module Samwise
  class Client
    def initialize(api_key:)
      @api_key = api_key || ENV['DATA_DOT_GOV_API_KEY']
    end

    def get_duns_info(duns:)
      response = lookup_duns(duns: duns)
      JSON.parse(response.body)
    end

    def duns_is_valid?(duns:)
      response = lookup_duns(duns: duns)
      response.status == 200
    end

    private

    def lookup_duns(duns:)
      duns = Samwise::Util.format_duns(duns: duns)
      response = Faraday.get(Samwise::Protocol.duns_url(duns: duns, api_key: @api_key))
    end
  end
end
