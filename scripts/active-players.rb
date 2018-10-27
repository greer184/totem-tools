require 'radiator'

api = Radiator::Api.new

api.get_account_history("qfilter", -1, 10000) do |data|
    data.each do |i, item|
        type, op = item.op
        if type == "delegate_vesting_shares"
            puts op.delegator
            puts op.vesting_shares
        end
    end
end