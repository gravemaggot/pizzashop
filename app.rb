# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'base64'

set :database, 'sqlite3:pizzashop.db'

# Classes
class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
  validates :username, presence: true, length: { minimum: 3 }
  validates :phone, presence: true
  validates :adres, presence: true
  validates :orders, presence: true
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
  @new_order = Order.new
  @pizzas = params[:orders]

  if @pizzas.nil? || @pizzas == ''
    return erb 'Ваш заказ пуст!'
  end

  @results = get_pizzas_result(@pizzas)
  erb :cart
end

post '/submit_cart' do
  @new_order = Order.new params[:order]
  if @new_order.save 
    erb "Ваш заказ принят!<script type='text/javascript'> window.localStorage.clear() </script>"
  else
    @pizzas  = params[:order][:orders]
    @results = get_pizzas_result(@pizzas)
    @error   = @new_order.errors.full_messages.first

    erb :cart
  end
end

def get_pizzas_result(pizzas_string)
  pizzas_string.nil? do
    return []
  end

  puts pizzas_string

  results = []

  pizzas_string.split(',').each do |pzz|
    pzz_id = pzz.split('=')[0].split('product_')[1].to_i
    cnt    = pzz.split('=')[1].to_i

    if Product.exists?(id: pzz_id)
      pzz_name = Product.find(pzz_id).description
      results[results.count] = { name: pzz_name, cnt: cnt }
    end
  end

  results
end
