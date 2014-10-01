class UrlsController < ApplicationController
  include UrlsHelper

  before_filter :requires_url, only: [:create]
  before_filter :validates_token

  def create
    short_url = ShortUrl.create(url: params[:url], token: params[:token])
    render json: short_url.to_json
  end

  def show
    short_url = ShortUrl.find_by_short_url(params[:id])
    if short_url
      redirect_to short_url.url, status: '301' and return
    else
      render text: MISSING_SHORT_URL, status: '404' and return
    end
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
