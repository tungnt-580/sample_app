class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {email.downcase!}
  validates :name, presence: true, length: {maximum:Settings.name_max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.password_min_length}

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ?   
      Bcrypt::Engine::MIN_COST : Bcrypt::Engine.cost
    Bcrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if  remember_digest.nil?
    Bcrypt::Password.new(rememer_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end
end
