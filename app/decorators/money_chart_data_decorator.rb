class MoneyChartDataDecorator
  attr_accessor :registers

  def initialize(registers)
    @registers = registers
  end

  def main_chart_data
    data = []
    [1, 3, 12].map do |number|
      data_by_month = registers.by_month(number)
      income = data_by_month.by_type('income')
      costs = data_by_month.by_type('costs')
      data << [number.month.ago.to_date, income.sum(:total), costs.sum(:total)]
    end
    data
  end

  def article_chart_data(type)
    data = []
    result_registers = registers.by_type(type)
    result_registers.map(&:article).uniq.each do |article|
      data << [article.name, result_registers.where(article: article).sum(:total)]
    end
    data
  end

  def account_money_chart
    data = []
    registers.all.map(&:account).uniq.each do |acc|
      account_registers = registers.where(account: acc)
      remain_money = account_registers.by_type('income')&.sum(:total).to_f - account_registers.by_type('costs')&.sum(:total).to_f
      data << [acc.name, remain_money]
    end
    data
  end
end
