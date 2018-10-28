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
        if comment.contains?(disapprove)
            in_favor += 5
        elsif comment.contain?(disapprove)
            against += 5
        end
    end
end