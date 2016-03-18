module MoneyChartData
  def main_chart_data
    data = []
    [1, 3, 12].map do |number|
      data_by_month = MoneyRegister.where('date > ?', number.month.ago)
      income = data_by_month.by_type('income')
      costs = data_by_month.by_type('costs')
      data << [number.month.ago.to_date, income.sum(:total), costs.sum(:total)]
    end
    data
  end

  def article_chart_data
    data = []
    all.map(&:article).uniq.each do |article|
      data << [article.name, where(article: article).sum(:total)]
    end
    data
  end

  def account_money_chart
    data = []
    all.map(&:account).uniq.each do |acc|
      account_registers = where(account: acc)
      remain_money = account_registers.by_type('income')&.sum(:total).to_i - account_registers.by_type('costs')&.sum(:total).to_i
      data << [acc.name, remain_money]
    end
    data
  end
end
