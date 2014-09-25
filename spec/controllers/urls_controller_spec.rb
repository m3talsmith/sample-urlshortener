require 'rails_helper'

RSpec.shared_examples 'requires a valid short url' do
  describe 'with no short url' do
    it 'responds with an MissingShortUrl error'
  end

  describe 'with an invalid short url' do
    it 'responds with a MissingShortUrl error'
  end
end

RSpec.shared_examples 'requires a token' do
  describe 'with no token' do
    it 'responds with an MissingToken error'
  end

  describe 'with an invalid token' do
    it 'responds with an InvalidToken error'
  end
end

RSpec.describe UrlsController, :type => :controller do
  describe 'POST' do
    describe 'with no url' do
      it 'responds with a MissingUrl error'
    end

    describe 'with no token' do
      it 'creates a new token'
      it 'returns a short url'
    end

    describe 'with an invalid token' do
      it 'responds with an InvalidToken error'
    end

    describe 'with a valid token' do
      it 'returns a short url tied to that token'
    end
  end 

  describe 'GET' do
    it_behaves_like 'requires a valid short url'

    describe 'with a valid short url' do
      it 'redirects to the stored url with a 303'
    end
  end

  describe 'PUT' do
    it_behaves_like 'requires a valid short url'
    it_behaves_like 'requires a token'

    describe 'with no url' do
      it 'responds with a MissingURL error'
    end

    describe 'with a valid token and url' do
      it 'responds with an updated short url'
    end
  end

  describe 'DELETE' do
    it_behaves_like 'requires a valid short url'
    it_behaves_like 'requires a token'

    describe 'with a valid token and short url' do
      it 'responds with a ShortUrlDeleted message'
    end
  end
end
