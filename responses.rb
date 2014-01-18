require 'response'

class PairingStatus < Response
  field :id
  field :enabled
  field :user_id
  field :user_name
end

class AuthenticationStatus < Response
  field :id
  field :pending
  field :granted
  field :automated
  field :reason
  field :terminal_id
  field :terminal_name
end
