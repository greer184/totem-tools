require 'radiator'

def get_player_base(api, totem) 

    # Get latest STEEM per VEST number
    convertion = 0
    api.get_dynamic_global_properties do |data|
        steem = data.total_vesting_fund_steem
        vests = data.total_vesting_shares
        convertion = steem.to_f / vests.to_f
    end

    players = []
    api.get_account_history(totem, -1, 10000) do |data|
        data.each do |i, item|
            type, op = item.op

            # Only look for delegation operations.
            if type == "delegate_vesting_shares"

                # Calculated STEEM delegated to totem.
                steem = op.vesting_shares.to_f * convertion

                # Create new player
                if steem >= 0.0     
                    player = Hash.new
                    player["name"] = op.delegator
                
                    # Update with latest player data.
                    dup = players.index{|x| op.delegator == x["name"] }
                    if !dup.nil?
                        players.delete_at(dup)
                    end
                
                    # Cap voting power at 1 STEEM.
                    player["vote"] = steem 
                    if steem > 1.0
                        player["vote"] = 1.0
                    end

                    # Store players in array.
                    if steem > 0.0 
                        players.push(player)
                    end
                end
            end
        end
    end
    players

end

# Get players
api = Radiator::Api.new
puts get_player_base(api, "statsplit")