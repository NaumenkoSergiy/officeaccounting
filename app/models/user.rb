class User < ActiveRecord::Base
  validates :email, :password, :confirm_password, presence: true
  validates :password, :confirm_password, length: { minimum: 6, maximum: 32 }
  validates :email, email: true, uniqueness: true
  validate :is_valid_confirm_password?

  has_many :user_companies
  has_many :companies, through: :user_companies
  has_one :user_company, -> { where(current_company: true) }
  has_one :current_company, through: :user_company, source: :company

  delegate :accounts, to: :current_company
  delegate :contracts, to: :current_company
  delegate :counterparties, to: :current_company
  delegate :money_registers, to: :current_company
  delegate :currencies, to: :current_company
  delegate :cashiers, to: :current_company
  delegate :credits, to: :current_company
  delegate :id, to: :current_company, prefix: true
  delegate :short_name, to: :current_company, prefix: true

  after_create :send_activation_token

  ROLES_TITLES = {
    :view_symbol => :view,
    :edit_symbol => :edit
  }

  def activated?
    activate_token.blank?
  end

  def activate!
    self.update_column(:activate_token, nil)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private

  def send_activation_token
    UserMailer.welcome_email(self).deliver! unless self.activated?
  end

  def is_valid_confirm_password?
    unless self.password == self.confirm_password
      errors.add(:confirm_password, "Пароль підтвердження не є таким як пароль")
    end
  end
end
