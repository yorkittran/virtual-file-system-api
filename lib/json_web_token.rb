require 'jwt'

module JsonWebToken
  HMAC_SECRET = Settings.jwt.hmac_secret
  ALGORITHM = Settings.jwt.algorithm
  EXPIRE_DURATION = 30.days

  class << self
    def encode(payload)
      payload[:exp] = EXPIRE_DURATION.from_now.to_i
      JWT.encode(payload, HMAC_SECRET, ALGORITHM)
    end

    def decode(token)
      return unless token

      body = JWT.decode(token, HMAC_SECRET, true, algorithm: ALGORITHM)
      HashWithIndifferentAccess.new(body.first.except('exp'))
    end
  end
end
