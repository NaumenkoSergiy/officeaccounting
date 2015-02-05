class Currency < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :name, scope: :company_id
  validates :name, presence: true, allow_blank: false

  CURRENCY = {
    :UAH_s => :UAH,
    :USD_s => :USD,
    :EUR_s => :EUR,
    :RUB_s => :RUB,
    :GBP_s => :GBP,
    :AUD_s => :AUD,
    :AZN_s => :AZN,
    :BYR_s => :BYR,
    :DKK_s => :DKK,
    :ISK_s => :ISK,
    :KZT_s => :KZT,
    :CAD_s => :CAD,
    :MDL_s => :MDL,
    :NOK_s => :NOK,
    :PLN_s => :PLN,
    :SGD_s => :SGD,
    :HUF_s => :HUF,
    :TMT_s => :TMT,
    :UZS_s => :UZS,
    :CZK_s => :CZK,
    :SEK_s => :SEK,
    :CHF_s => :CHF,
    :CNY_s => :CNY,
    :JPY_s => :JPY
  }
end
