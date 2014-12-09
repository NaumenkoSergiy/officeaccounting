class User < ActiveRecord::Base
  validates :email, :password, :confirm_password, presence: true
  validates :password, :confirm_password, length: { minimum: 6, maximum: 32 }
  validates :email, email: true, uniqueness: true
  validate :is_valid_confirm_password?

  has_many :user_companies
  has_many :companies, through: :user_companies

  def generate_token(column)
    self[column] = SecureRandom.hex
    self.save
  end

  private
  
  def is_valid_confirm_password?
    unless self.password == self.confirm_password
      errors.add(:confirm_password, "Пароль підтвердження не є таким як пароль")
    end
  end
end