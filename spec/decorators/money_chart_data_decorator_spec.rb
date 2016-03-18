require 'rails_helper'

describe MoneyChartDataDecorator do
  let(:account) { FactoryGirl.create(:account) }
  let(:company) { FactoryGirl.create(:company) }
  let(:article) { FactoryGirl.create(:article) }
  let!(:money_register_income) { FactoryGirl.create(:money_register, account: account, company: company, article: article, type_money: 'income', date: 15.days.ago) }
  let!(:money_register_costs) { FactoryGirl.create(:money_register, account: account, company: company, article: article, type_money: 'costs', total: 2, date: 35.days.ago) }
  let(:instance) { MoneyChartDataDecorator.new(MoneyRegister.all) }

  describe 'main chart data' do
    let(:data) { instance.main_chart_data }
    let(:income_money) { money_register_income.total }
    let(:income_costs) { money_register_costs.total }

    it 'has data for month' do
      expect(data.first).to eq([1.month.ago.to_date, income_money, 0.0])
    end

    it 'has data for 3 months' do
      expect(data.second).to eq([3.month.ago.to_date, income_money, income_costs])
    end

    it 'has data for 12 months' do
      expect(data.third).to eq([12.month.ago.to_date, income_money, income_costs])
    end
  end

  describe 'article chart data' do
    %w(income costs).each do |type|
      let("result_#{type}_data") { [[article.name, send("money_register_#{type}").total]] }

      it "has data for #{type}" do
        expect(instance.article_chart_data(type)).to eq(send("result_#{type}_data"))
      end
    end
  end

  describe 'account money chart' do
    let(:remain_money) { money_register_income.total - money_register_costs.total }

    it 'has account remain money' do
      expect(instance.account_money_chart.first).to eq([account.name, remain_money])
    end
  end
end
