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
    return erb :cart_is_empty
  end

  @results = parse_pizzas(@pizzas)
  erb :cart
end

post '/submit_cart' do
  return redirect to :cart_is_empty if params[:order][:orders] == ''

  @new_order = Order.new params[:order]
  if @new_order.save
    redirect to :cart_is_empty
  else
    @pizzas  = params[:order][:orders]
    @results = parse_pizzas(@pizzas)
    @error   = @new_order.errors.full_messages.first

    erb :cart
  end
end

get '/cart_is_empty' do
  erb :cart_is_empty
end

get '/admin' do
  @orders = Order.order(id: :desc)
  erb :admin
end

def parse_pizzas(pizzas_string)
  results = []
  pizzas_string ||= ''

  pizzas_string.split(',').each do |pzz|
    pzz_id = pzz.split('=')[0].split('product_')[1].to_i
    cnt    = pzz.split('=')[1].to_i

    next unless Product.exists? id: pzz_id

    obj = Product.find(pzz_id)
    results[results.count] = { name: obj.title, price: obj.price, cnt: cnt }
  end

  results
end
