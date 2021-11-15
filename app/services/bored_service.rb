class BoredService
  class << self
    def activity(type)
      result = BoredClient.fetch(url(type))

      format_output(result)
    end

    private

    def format_output(data)
      {
        title: data[:activity],
        type: data[:type],
        participants: data[:participants],
        price: data[:price]
      }
    end

    def url(type)
      "/api/activity?type=#{type}"
    end
  end
end
