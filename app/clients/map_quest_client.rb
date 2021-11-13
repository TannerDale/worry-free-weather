class MapQuestClient
  class << self
    def fetch(url)
      parse_data(conn.get(url))
    end

    private

    def conn
      Faraday.new(
        url: 'http://www.mapquestapi.com',
        params: { key: ENV['mapquest_api_key'] }
      )
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
