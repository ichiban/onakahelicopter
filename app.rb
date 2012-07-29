# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require 'onakahelicopter'
require 'sinatra'
require 'cgi'
require 'uri'
require 'haml'
require 'json'

configure do
  set :haml, :format => :html5
end

helpers do
  def h(str)
    CGI.escapeHTML(str)
  end

  def csrf_token
    Rack::Csrf.csrf_token(env)
  end

  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end

  def u(str)
    URI.escape(str)
  end

  def twitter_form_url_for(text)
    url = URI('http://twitter.com/home')
    status = ['おなか', text, ' #おなかヘリコプター'].join
    url.query = "status=#{u status}"
    url.to_s
  end
end

get '/' do
  haml :index
end

post '/dajare' do
  text = params[:text]
  dajare = OH::Dajare.first(:text => text)
  if dajare.nil?
    OH::Dajare.create :text => text, :deta => true
  else
    dajare.update :deta => true
  end
  redirect to(twitter_form_url_for(text))
end

get '/suggest' do
  search = Sunspot.search(OH::Dajare) do
    fulltext params[:for]
    paginate :page => 1, :per_page => 8
  end

  result = {
    :dajare => []
  }

  search.results.each do |dajare|
    result[:dajare] << {
      :deta => dajare.deta,
      :text => dajare.text
    }
  end

  JSON.generate(result)
end
