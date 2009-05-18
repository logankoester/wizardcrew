# Controller for the LastFM leaf.

require 'scrobbler'

class Controller < Autumn::Leaf
  
  def np_command(stem, sender, reply_to, msg)
    if msg
      u = User.find_by_nick(sender[:msg])
    else
      u = User.find_by_nick(sender[:nick])
    end
    if u
      user = Scrobbler::User.new(u.username)
      track = user.recent_tracks.first
      "#{u.nick} is now listening to: #{track.name} by #{track.artist}"
    else
      "That user has not registered a LastFM username (use !lastfm)"
    end
  end
  
  def lastfm_command(stem, sender, reply_to, msg)
    if msg
      u = User.find_by_nick(sender[:nick])
      u = User.new unless u
      
      u.nick = sender[:nick]
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
