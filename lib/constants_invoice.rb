module Constants_invoice
  FORMS_OF_INVOICE = [
    {account_number: 10, name: "основні засоби", type: "активи", subcount1: "основні засоби", subcount2: "група основних засобів" },
    {account_number: 22, name: "малоцінні активи та інвентар", type: "активи", subcount1: "номенклатура", subcount2: "-" },    
    {account_number: 31, name: "грошові кошти", type: "активи", subcount1: "рахунок", subcount2: "стаття руху коштів" },
    {account_number: 36, name: "розрахунки з покупцями", type: "активи", subcount1: "контрагент", subcount2: "договір" },
    {account_number: 37, name: "розрахунки по авансах виданих", type: "активи", subcount1: "контрагент", subcount2: "договір" },
    {account_number: 40, name: "капітал", type: "пасиви", subcount1: "-", subcount2: "-" },      
    {account_number: 44, name: "прибуток нерозподілений", type: "пасиви", subcount1: "-", subcount2: "-" },      
    {account_number: 63, name: "розрахунки з продавцями", type: "пасиви", subcount1: "контрагент", subcount2: "договір" },
    {account_number: 64, name: "розрахунки за податками", type: "пасиви", subcount1: "податок", subcount2: "-" }, 
    {account_number: 65, name: "розрахунки із страхування", type: "пасиви", subcount1: "вид нарахувань", subcount2: "-" },  
    {account_number: 66, name: "оплата праці",   type: "пасиви", subcount1: "працівник", subcount2: "-" },   
    {account_number: 68, name: "аванси отримані", type: "пасиви", subcount1: "контрагент", subcount2: "договір" },
    {account_number: 70, name: "дохід від реалізації", type: "доходи", subcount1: "стаття доходів", subcount2: "-" },  
    {account_number: 79, name: "фінансовий результат", type:  "доходи", subcount1: "-", subcount2: "-" },     
    {account_number: 90, name: "собівартість  реалізації", type: "витрати", subcount1: "стаття затрат", subcount2: "-" },   
    {account_number: 91, name: "загальновиробничі витрати", type: "витрати", subcount1: "стаття затрат", subcount2: "-" },   
    {account_number: 92, name: "адміністративні витрати", type: "витрати", subcount1: "стаття затрат", subcount2: "-" }   
  ].freeze
end
