require 'radiator'

# Turn this into command line options
author = 'statsplit'
permlink = 'steemfield-proposal-1'

tempA = 'greer184'
tempP = 'steemfield-implementation-details'

# Yes and No Strings
approve = "{YES}"
disapprove = "{NO}"

api = Radiator::Api.new

# Weight for and against
in_favor = 0.0
against = 0.0

# Count up votes on the post
api.get_content_replies(tempA, tempP) do |comments|
    comments.each do |comment|
        if comment.contains?(disapprove) {
            in_favor += 5
        } elsif comment.contain?(disapprove) {
            against += 5
        } 
    end
end