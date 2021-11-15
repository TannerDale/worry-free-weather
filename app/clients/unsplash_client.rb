class UnsplashClient
  class << self
    def fetch(url)
      parse_data(conn.get(url))
    end

    private

    def conn
      Faraday.new(
        url: 'https://api.unsplash.com',
        params: {
          client_id: ENV['unsplash_api_key'],
          per_page: 1
        }
      )
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
