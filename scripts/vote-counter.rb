require 'radiator'
require_relative 'active-players'

# Turn this into command line options
totem = 'qfilter'
permlink = 'steemfield-proposal-1'

tempA = 'greer184'
tempP = 'steemfield-implementation-details'

# Yes and No Strings
approve = "{YES}"
disapprove = "{NO}"

api = Radiator::Api.new
players = get_player_base(api, totem)
puts players

# Weight for and against
in_favor = 0.0
against = 0.0

# Count up votes on the post
api.get_content_replies(tempA, tempP) do |comments|
    comments.each do |comment|
        voter_index = players.index{|x| comment.author == x["name"]} 
        if !voter_index.nil?
            if comment.contains?(approve)
                in_favor += 1.0 * players[voter_index]["vote"]
            elsif comment.contain?(disapprove)
                against += 1.0 * players[voter_index]["vote"]
            end
        end
    end
end