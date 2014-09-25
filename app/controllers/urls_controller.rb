class UrlsController < ApplicationController
  include UrlsHelper

  layout false
  before_filter :requires_url, only: [:create]
  before_filter :validates_token

  def create
    short_url = ShortUrl.create(url: params[:url], token: params[:token])
    render json: short_url.to_json
  end

  private
  
  def requires_url
    render text: MISSING_URL, status: '400' unless params[:url] and return
    return true if params[:url]
  end

  def validates_token
    return true unless params[:token]
    valid = ShortUrl.validate_token(params[:token])
    render text: INVALID_TOKEN, status: '400' unless valid and return
    return valid
  end
end
