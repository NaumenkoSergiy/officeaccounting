class User < ActiveRecord::Base
  acts_as_messageable
  has_secure_password

  scope :by_email, -> (query) {
    where("email LIKE ?", "%#{query.downcase}%")
    .limit(10)
    .collect{ |k| { id: k.id.to_s, text: k.email } }
  }

  validates :email, presence: true
  validates :password, length: { minimum: 6, maximum: 32 }
  validates :email, email: true, uniqueness: true

  has_many :user_companies
  has_many :companies, through: :user_companies
  has_one :user_company, -> { where(current_company: true) }
  has_one :current_company, through: :user_company, source: :company
  has_many :guide_units
  has_many :chats

  delegate :accounts, to: :current_company
  delegate :contracts, to: :current_company
  delegate :counterparties, to: :current_company
  delegate :money_registers, to: :current_company
  delegate :currencies, to: :current_company
  delegate :cashiers, to: :current_company
  delegate :credits, to: :current_company
  delegate :id, :short_name, to: :current_company, prefix: true
  delegate :payment_orders, to: :current_company
  delegate :orders, to: :current_company
  delegate :currency_transactions, to: :current_company
  delegate :main_tools, to: :current_company
  delegate :nomenclatures, to: :current_company
  delegate :departments, to: :current_company
  delegate :products, to: :current_company

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
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def mailboxer_email(object)
    email
  end

  def online?
    $redis.exists( self.id )
  end

  private

  def send_activation_token
    UserMailer.welcome_email(self).deliver_now! unless self.activated?
  end
end
