module CounterpartiesHelper
  def presents_params?
    counterparty = params[:counterparty]
    ['costs', 'income'].include?(counterparty[:page]) || 'out' == counterparty[:type]
  end
end
