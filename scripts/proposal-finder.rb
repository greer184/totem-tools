require 'radiator'

# Turn this into command line options
author = 'statsplit'
permlink = 'steemfield-results-round-0'

tempA = 'greer184'
tempP = 'steemfield-implementation-details'

# Regular expressions
line = /(---+)/
header = /({PROPOSAL.+})/

api = Radiator::Api.new

# Collect correctly formatted proposals
api.get_content_replies(tempA, tempP) do |comments|
    comments.each do |comment|
        proposal = comment.body.split(line)[2]
        next unless !proposal.nil?
        if !proposal.index(header).nil?
            puts proposal
        end
    end
end