class Currency < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :name, scope: :company_id
  validates :name, presence: true, allow_blank: false

  AVAILABLE_CURRENCIES = [:UAH, :USD, :EUR, :RUB, :GBP, :AUD, :AZN, :BYR, :DKK, :ISK, :KZT, :CAD,
                          :MDL, :NOK, :PLN, :SGD, :HUF, :TMT, :UZS, :CZK, :SEK, :CHF, :CNY, :JPY]
end
