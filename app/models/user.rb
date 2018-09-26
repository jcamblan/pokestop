class User < ApplicationRecord

  attr_accessor :remember_token

  # On définit les validations indispensables à la création d'un nouvel user --------------------

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Franchement j'ai pas bien compris ce que ça fait, a priori permet d'accélérer les tests de création d'user
  # en limitant la complexité de l'encryption du password ----------------------

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Génération d'un token unique pour sécuriser les cookies ----------------------

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # On associe le token random à son utilisateur pour le retrouver dans le cadre des sessions persistantes

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Renvoie true si le token du cookie égale le token sauvegardé en base

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # On met fin à la session permanente d'un user en supprimant le token en base
  def forget
    update_attribute(:remember_digest, nil)
  end
end
