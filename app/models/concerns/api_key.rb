module ApiKey
  def self.generate
    SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
