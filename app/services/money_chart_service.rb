class MoneyChartService
  attr_reader :registers

  def initialize(registers)
    @registers = registers
  end

  def main
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Period')
    data_table.new_column('number', I18n.t('income'))
    data_table.new_column('number', I18n.t('spending'))
    data_table.add_rows(registers.main_chart_data)

    GoogleVisualr::Interactive::ColumnChart.new(data_table, opts(I18n.t('money.chart.main.title')))
  end

  def article_income
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Article')
    data_table.new_column('number', 'Costs')
    data_table.add_rows(registers.article_chart_data('income'))

    GoogleVisualr::Interactive::PieChart.new(data_table, opts(I18n.t('money.chart.article_income.title')))
  end

  def article_costs
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Article')
    data_table.new_column('number', 'Income')
    data_table.add_rows(registers.article_chart_data('costs'))

    GoogleVisualr::Interactive::PieChart.new(data_table, opts(I18n.t('money.chart.article_income.title')))
  end

  def account_money
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Account')
    data_table.new_column('number', 'Money')
    data_table.add_rows(registers.account_money_chart)

    GoogleVisualr::Interactive::BarChart.new(data_table, opts(I18n.t('money.chart.account.title')))
  end

  private

  def opts(title)
    { width: 380, height: 240, is3D: true, title: title }
  end
end
