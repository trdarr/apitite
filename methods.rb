require 'method'

class Pair < Method
  post 'pairings/create'

  required :pairing_phrase
  required :user_name
  optional

  returns PairingStatus
end

class PairQR < Method
  post 'pairings/create/qr'

  required :user_name
  optional

  returns PairingStatus
end

class PairSMS < Method
  post 'pairings/create/sms'

  required :phone_number
  required :user_name
  optional :phone_country
end

class GetPairingStatus < Method
  get 'pairings/:pairing_id'

  returns PairingStatus
end

class Authenticate < Method
  post 'authentication_requests/initiate'

  required :pairing_id
  required :terminal_name
  optional :action_name
  optional

  returns AuthenticationStatus
end

class AuthenticateByUserName < Method
  post 'authentication_requests/initiate'

  required :user_name
  required :name
  required :name_extra
  optional :action_name
  optional

  returns AuthenticationStatus
end

class GetAuthenticationStatus < Method
  get 'authentication_requests/:authentication_request_id'
end

class AuthenticateWithOTP < Method
  post 'authentication_reuqests/:authentication_request_id/otp_auth'

  required :otp
end

class CreateUserTerminal < Method
  post 'user_terminals/create'

  required :user_name
  required :name
  required :name_extra
end

class SetToopherEnabledForUser < Method
  post 'users'

  required :user_name
  required :enabled
end
