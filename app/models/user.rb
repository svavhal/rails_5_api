class User < ApplicationRecord

# Associations
has_many :posts
has_many :comments

# Callbacks
before_create -> { self.auth_token = SecureRandom.hex }
end

