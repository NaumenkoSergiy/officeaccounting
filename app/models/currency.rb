class Currency < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :name, scope: :company_id
  validates :name, presence: true, allow_blank: false

  CURRENCY = {
    'AUD - австралійський долар' => :AUD,
    'AZN - Азербайджанський манат' => :AZN,
    'GBP - англійський фунт стерлінг' => :GBP,
    'BYR - білоруський рубль' => :BYR,
    'DKK - датських крон' => :DKK,
    'USD - доллар США' => :USD,
    'EUR - Евро' => :EUR,
    'ISK - ісландський крон' => :ISK,
    'KZT - казахстанський тенге' => :KZT,
    'CAD - канадський долар' => :CAD,
    'MDL - молдовський леїв' => :MDL,
    'NOK - норвезький крон' => :NOK,
    'PLN - польський злот' => :PLN,
    'RUB - российский рубль' => :RUB,
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