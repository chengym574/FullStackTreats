class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    self.inheritance_column = :_type_disabled

    has_many :orders

    enum role: { admin: 'admin', regular: 'regular' }
end
