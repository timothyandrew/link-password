require 'data_mapper'
require 'sinatra'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:root@localhost/link-password')
require './db.rb'

DataMapper.auto_upgrade!
puts ENV['DATABASE_URL']

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['username', 'password']
end

get '/upload/*/*' do
  link = Link.first_or_create(:hash_url => params[:splat].shift)
  link.url = params[:splat].first
  link.save
  "URL is http://imc-choir.heroku.com/link/#{link.hash_url}"
end

get '/link/:hash' do
  redirect "http://#{Link.get(params[:hash]).url}"
end