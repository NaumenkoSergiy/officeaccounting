class MoneyChartService
  def initialize(registers)
    @registers = registers
  end

  def column_chart

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', I18n.t('money.chart_column.period'))
    data_table.new_column('number', I18n.t('income'))
    data_table.new_column('number', I18n.t('spending'))
    data_table.add_rows(@registers.chart_data)

    GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  private

  def opts
    { width: 400, height: 240, title: I18n.t('money.chart_column.title') }
  end
end
