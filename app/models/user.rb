class User < ApplicationRecord
  has_secure_password
  
  def full_name
    "#{name} #{lastname}"
  end
end
