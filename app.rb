# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'base64'

set :database, 'sqlite3:pizzashop.db'

class Product < ActiveRecord::Base
end

get '/' do
  @products = Product.all
  erb :index
end

get '/about' do
  @encoded_file = Base64.encode64(File.open('./public/media/examples/01. The World Is Yours.mp3', 'rb').read)
  erb :about
end

post '/cart' do
  erb 'Hello!'
end
