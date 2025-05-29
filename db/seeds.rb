# Crear una casa
house = House.create!(
  state: "Tachira",
  name: "Casa de Encuentro y Formacion San Juan de la Cruz",
  address: "Potrero de  las Casas",
  shortname: "CARTEPO",
  city: "San Cristobal",
  country: "Venezuela",
  email: "example@example.com",
  code: 10015
)


# Crea monedas
currencies = [
  {
    symbol: '$',
    code: 'USD',
    name: 'Dólar Estadounidense'
  },
  {
    symbol: 'Bs.',
    code: 'VES',
    name: 'Bolívar Digital'
  },
  {
    symbol: '€',
    code: 'EUR',
    name: 'Euro'
  },
  {
    symbol: '$',
    code: 'COP',
    name: 'Peso Colombiano'
  }
]

currencies.each do |currency|
  Currency.create!(code: currency[:code]) do |c|
    c.symbol = currency[:symbol]
    c.name = currency[:name]
  end
end

# Crear cuentas
accounts_data = [
  { name: "Pesos Efectivo", balance: 0.00, code: 1, currency: "COP" },
  { name: "Dolares Efectivo", balance: 0.00, code: 2, currency: "USD" },
  { name: "Bolivares Efectivo", balance: 0.00, code: 3, currency: "VES" },
  { name: "Euros Efectivo", balance: 0.00, code: 4, currency: "EUR" },
]


accounts_data.each do |data|
  Account.create!(
    name: data[:name],
    balance: data[:balance],
    code: data[:code],
    currency: Currency.find_by!(code: data[:currency]),
    house: house
  )
end

# Crear un usuario
user = User.create!(
  username: "kenny",
  name: "Kenny",
  lastname: "Ortega",
  birthdate: Date.new(1990, 10, 8),
  password: "19501388",
  password_confirmation: "19501388",
  house: house
)

transaction_types_data = [
  { name: "Ingreso General", description: "Representa cualquier entrada de dinero general.", code: 100 },
  { name: "Compra de Combustible", description: "Gastos relacionados con la adquisición de combustible para vehículos.", code: 201 },
  { name: "Compra de Comida", description: "Gastos en alimentos y bebidas.", code: 202 },
  { name: "Compra de Medicinas", description: "Gastos en productos farmacéuticos y atención médica.", code: 203 },
  { name: "Salario", description: "Ingresos provenientes de un sueldo o salario.", code: 101 },
  { name: "Servicios Públicos", description: "Pagos de servicios como electricidad, agua, gas, etc.", code: 204 },
  { name: "Transferencia Recibida", description: "Dinero recibido de otra cuenta o persona.", code: 102 },
  { name: "Transferencia Enviada", description: "Dinero enviado a otra cuenta o persona.", code: 205 }
]

transaction_types_data.each do |data|
  TransactionType.create!(data)
rescue ActiveRecord::RecordInvalid => e
  puts "  Error al crear #{data[:name]}: #{e.message}"
rescue ActiveRecord::RecordNotUnique => e
  puts "  Error de unicidad al crear #{data[:name]}: #{e.message}"
end

# Crear 5 transactions
10.times do |i|
  Transaction.create!(
    amount: rand(100.0..1000.0).round(2),
    date: Date.today - i.days,
    description: "Descripcion #{i + 1}",
    details: "Detalles de #{i + 1}",
    exchange_rate: rand(20.0..25.0).round(2),
    is_income: [true, false].sample,
    invoice_number: SecureRandom.hex(5),
    user: user,
    account: Account.all.sample,
    transaction_type: TransactionType.all.sample
  )
end

