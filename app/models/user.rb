class User < ApplicationRecord
    self.inheritance_column = :_type_disabled

    has_many :orders

    enum role: { admin: 'admin', regular: 'regular' }
end
