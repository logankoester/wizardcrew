class User
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :nick, String
  property :username, String
end
