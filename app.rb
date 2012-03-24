require 'data_mapper'
require 'sinatra'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:root@localhost/link-password')
require './db.rb'

DataMapper.auto_migrate!
puts ENV['DATABASE_URL']

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['imc', 'jonty']
end

get '/upload/*' do
  link = Link.first_or_create(:url => params[:splat].first)
  "Set as #{link.hash_url}"
end

get '/link/:hash' do
  redirect "http://#{Link.get(params[:hash]).url}"
end