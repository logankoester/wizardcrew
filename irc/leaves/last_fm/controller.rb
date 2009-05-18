# Controller for the LastFM leaf.

require 'scrobbler'

class Controller < Autumn::Leaf
  
  def np_command(stem, sender, reply_to, msg)
    if msg
      nick = msg
    else
      nick = sender[:nick]
    end
    
    u = User.find_by_nick(nick.downcase)
    
    if u
      user = Scrobbler::User.new(u.username)
      track = user.recent_tracks.first
      "#{nick} is listening to #{track.name} by #{track.artist}"
    else
      # Maybe it's a last.fm user rather than a nick
      user = Scrobbler::User.new(nick)
      track = user.recent_tracks.first
      if track
        "#{nick} is listening to #{track.name} by #{track.artist}"
      else
        "That user does not exist or has not scrobbled any tracks"
      end
    end
  end
  
  def lastfm_command(stem, sender, reply_to, msg)
    if msg
      u = User.find_by_nick(sender[:nick].downcase)
      u = User.new unless u
      
      u.nick = sender[:nick].downcase
      u.username = msg
      
      if u.save
        "Your Last.fm username has been set to #{msg}"
      else
        "There was a problem saving your username"
      end
    else
      "Your username is too short"
    end
  end
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
end
