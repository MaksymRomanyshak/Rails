class OmdbClient
    URL = 'http://www.omdbapi.com'

    def initialize
        @api_key = Rails.application.credentials.omdb[:apikey]
    end

    def search(string)
        parse_body(
            Faraday.get(URL, {apikey: @api_key, s: string})
        )
    end

    def search_by_title(string)
        parse_body(
            Faraday.get(URL, {apikey: @api_key, t: string})
        )
    end

    private

    def parse_body(response)
        JSON.parse(response.body)
    end
end