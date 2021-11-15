class BoredClient
  class << self
    def fetch(url)
      parse_data(conn.get(url))
    end

    private

    def conn
      Faraday.new('http://www.boredapi.com')
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
