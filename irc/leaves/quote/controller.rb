# Controller for the Quote leaf.

require 'httparty'

class QuoteSite
  include HTTParty
  base_uri 'wizards.mikelouth.co.uk'
end

class Controller < Autumn::Leaf
  
  def quote_command(stem, sender, reply_to, msg)
    # This method renders the file "quote.txt.erb"
    html = QuoteSite.post('/index.php', :query => {:do => 'add', :quote => msg})
    @resp = /<td width="100%" align="center" class="title">(.*?)<\/td>/m.match(html)[1].strip
  end
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
end
