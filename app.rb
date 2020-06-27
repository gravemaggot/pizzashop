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
  @pizzas = params[:orders]

  if @pizzas == nil
    erb 'Ваш заказ пуст.'
    return
  end

  @results = []

  @pizzas.split(',').each do |pzz|
    pzz_id = pzz.split('=')[0].split('product_')[1].to_i
    cnt    = pzz.split('=')[1].to_i

    @results[@results.count] = { :name => Product.find(pzz_id).description, :cnt => cnt }
    puts @results
  end

  erb :cart
end
