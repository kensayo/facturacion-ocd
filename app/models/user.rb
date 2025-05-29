class User < ApplicationRecord
  has_secure_password

  belongs_to :house
  validates :house, presence: true

  has_many :transactions, dependent: :nullify

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  attr_accessor :remember_token

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64 # Genera una cadena aleatoria segura para URL
  end

  # Recuerda un usuario en la base de datos para su uso en sesiones persistentes.
  def remember
    self.remember_token = User.new_token # Crea un nuevo token virtual
    # Actualiza la columna remember_digest con el hash del token.
    # update_attribute salta las validaciones, lo cual es adecuado aquí.
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Retorna true si el token dado coincide con el digest.
  # BCrypt::Password.new(digest).is_password?(token) compara el token con el hash
  def authenticated?(remember_token)
    # Maneja el caso en que remember_digest sea nil (usuario no recordado)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Olvida a un usuario (elimina el digest del token de recordar).
  def forget
    update_attribute(:remember_digest, nil)
  end
  def full_name
    "#{name} #{lastname}"
  end
end
