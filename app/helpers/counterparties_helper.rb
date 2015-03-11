module CounterpartiesHelper
  def counterparty_page?
    counterparty = params[:counterparty]
    ['costs', 'income'].include?(counterparty[:page]) || 'out' == counterparty[:type]
  end
end
