# Controller for the Chicken leaf.
require 'fleakr'

class Controller < Autumn::Leaf
  
  # Typing "!about" displays some basic information about this leaf.
  
  def chicken_command(stem, sender, reply_to, msg)
    Fleakr.api_key = 'a0f5a493d521ee55509d000a6b439faf'
    chickens = Fleakr.search(:tags => 'chicken')
    @chicken = chickens[rand(a.size)]
  end
end
