require 'rails_helper'

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
      it 'responds with a MissingUrl error' do
        post :create
        expect(response.code).to eq('400')
        expect(response.body).to eq(UrlsHelper::MISSING_URL)
      end
    end

    describe 'with no token' do
      before do
        post :create, url: 'http://example.com/articles'
        expect(response.code).to eq('200')

        @short_url = ShortUrl.first
        @json = JSON.parse(response.body)
      end

      it 'creates a new token' do
        expect(@json['token']).to be_truthy
        expect(@json['token']).to eq(@short_url.token)
      end

      it 'returns a short url' do
        expect(@json['short_url']).to eq(@short_url.short_url)
      end
    end

    describe 'with an invalid token' do
      it 'responds with an InvalidToken error' do
        post :create, url: 'http://example.com/link2', token: 'totallyinvalid'
        expect(response.code).to eq('400')
        expect(response.body).to eq(UrlsHelper::INVALID_TOKEN)
      end
    end

    describe 'with a valid token' do
      it 'returns a short url tied to that token' do
        short_url = ShortUrl.create(url: 'http://example.com/link1')
        token     = short_url.token

        post :create, url: 'http://example.com/link2', token: short_url.token
        expect(response.code).to eq('200')

        json = JSON.parse(response.body)
        expect(json['url']).to eq('http://example.com/link2')
        expect(json['token']).to eq(token)
      end
    end
  end 

  describe 'GET' do
    describe 'with an invalid short url' do
      it 'responds with an MissingShortUrl error' do
        get :show, id: '1234'

        expect(response.code).to eq('404')
        expect(response.body).to eq(UrlsHelper::MISSING_SHORT_URL)
      end
    end

    describe 'with a valid short url' do
      it 'redirects to the stored url with a 301' do
        url1 = ShortUrl.create(url: 'http://example.com/')
        get :show, id: url1.short_url

        expect(response.code).to eq('301')
        expect(response).to redirect_to(url1.url)
      end
    end
  end
end
