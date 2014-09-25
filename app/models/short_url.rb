require 'bcrypt'

class ShortUrl < ActiveRecord::Base
  before_create :generate_short_url, :generate_token

  def generate_short_url
    self.short_url = ShortUrl.generate_short_url(self.url)
  end

  def generate_token
    self.token = ShortUrl.generate_token unless self.token
  end

  ## Class Methods

  def self.generate_short_url(url)
    alphanumeric = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
    short_url    = 10.times.map {|char| alphanumeric[rand(alphanumeric.length)] }.join('')

    return short_url_unique?(short_url) ? short_url : generate_short_url(url)
  end

  def self.short_url_unique?(short_url)
    record = where(short_url: short_url).limit(1).count
    return record > 0 ? false : true
  end

  def self.generate_token
    salt   = BCrypt::Engine.generate_salt(7)
    secret = Time.now.hash.to_s

    return BCrypt::Engine.hash_secret(secret, salt)
  end

  def self.validate_token(token)
    record = where(token: token).limit(1).count
    return record > 0 ? true : false
  end
end
