require 'method'

class Pair < Method
  post 'pairings/create'

  required :pairing_phrase
  required :user_name
end

class PairSMS < Method
  post 'pairings/create/sms'

  required :phone_number
  required :user_name
  optional :phone_country
end

class GetPairingStatus < Method
  get 'pairings/:pairing_id'

  required :pairing_id
end
