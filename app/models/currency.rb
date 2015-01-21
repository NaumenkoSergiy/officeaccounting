class Currency < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :name, scope: :company_id
  validates :name, presence: true, allow_blank: false

  CURRENCY = {
    'UAH - українська гривня' => :UAH,
    'USD - доллар США' => :USD,
    'EUR - Евро' => :EUR,
    'RUB - российский рубль' => :RUB,
    'GBP - англійський фунт стерлінг' => :GBP,
    'AUD - австралійський долар' => :AUD,
    'AZN - Азербайджанський манат' => :AZN,
    'BYR - білоруський рубль' => :BYR,
    'DKK - датських крон' => :DKK,
    'ISK - ісландський крон' => :ISK,
    'KZT - казахстанський тенге' => :KZT,
    'CAD - канадський долар' => :CAD,
    'MDL - молдовський леїв' => :MDL,
    'NOK - норвезький крон' => :NOK,
    'PLN - польський злот' => :PLN,
    'SGD - сінгапурський долар' => :SGD,
    'HUF - угорський форинт' => :HUF,
    'TMT - Туркменський манат' => :TMT,
    'UZS - узбецький сум' => :UZS,
    'CZK - чеський крон' => :CZK,
    'SEK - шведський крон' => :SEK,
    'CHF - швейцарський франк' => :CHF,
    'CNY - юань женьміньбі (Китай)' => :CNY,
    'JPY - японський єн' => :JPY
  }
end
