class Link
  include DataMapper::Resource
  property :hash_url, String, :key => true, :default => lambda { |r,p| (0...6).map{ ('a'..'z').to_a[rand(26)] }.join }
  property :url, String, :required => true
end