1.times  { GasPressureReducingStation.create! }
1.times  { Chromatograph.create! }
1.times  { WeatherStation.create! }
1.times  { Plant.create! }
1.times  { NewOilTank.create! }
1.times  { ServiceOilTank.create! }
5.times  { Feeder.create! }
5.times  { Transformer.create! }
13.times { Engine.create!}
1.times  { Substation.create! }

[
  {
    first_name: 'approver',
    last_name: 'approver',
    email: 'approver@kribi.com',
    email_confirmation: 'approver@kribi.com',
    password: 'password',
    biography: 'approver',
    role: :APPROVER
  },
  {
    first_name: 'reviewer',
    last_name: 'reviewer',
    email: 'reviewer@kribi.com',
    email_confirmation: 'reviewer@kribi.com',
    password: 'password',
    biography: 'reviewer',
    role: :REVIEWER
  },
  {
    first_name: 'clerk',
    last_name: 'clerk',
    email: 'clerk@kribi.com',
    email_confirmation: 'clerk@kribi.com',
    password: 'password',
    biography: 'clerk',
    role: :CLERK
  }
].each do |attribute_set|
  Person.create!(attribute_set)
end
