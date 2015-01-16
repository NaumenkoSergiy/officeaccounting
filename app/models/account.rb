class Account < ActiveRecord::Base
  belongs_to :company
  
  ACCOUNT = {
    'Поточний рахунок' => :current,
    'Вкладний (депозитний) рахунок' => :deposit,
    'Поточний рахунок типу «Н»' => :current_n,
    'Поточний рахунок типу «П»' => :current_p,
    'Рахунок іноземного представництва' => :foreign_missions,
    'Інвестиційний рахунок нерезидента-інвестора' => :IANRI,
    'Рахунок виборчого фонду' => :electoral_fund,
    'Поточний рахунок УЄФА' => :UEFA
  }
end
