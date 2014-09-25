require 'rails_helper'

RSpec.describe ShortUrl, :type => :model do
  describe '#generate short_url' do
    it 'returns a random string' do
      url1 = ShortUrl.generate_short_url('1234')
      url2 = ShortUrl.generate_short_url('1234')

      expect(url2).to_not eq(url1)
    end

    it 'is unique' do
      url1 = ShortUrl.create(url: '1234').short_url
      url2 = ShortUrl.generate_short_url('1234')

      expect(ShortUrl.short_url_unique?(url1)).to be_falsy
      expect(ShortUrl.short_url_unique?(url2)).to be_truthy
    end
  end
end
