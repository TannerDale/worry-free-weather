module ApiKeyValidator
  class InvalidKey < StandardError; end

  def validate_api_key
    raise InvalidKey, 'No api key provided' unless params[:api_key].present?

    raise InvalidKey, 'Invalid api key' unless User.valid_api_key?(params[:api_key])
  end
end
