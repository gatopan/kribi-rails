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
    first_name: 'Approver',
    last_name: '1',
    email: 'approver-1@kribi.com',
    email_confirmation: 'approver-1@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :APPROVER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Approver',
    last_name: '2',
    email: 'approver-2@kribi.com',
    email_confirmation: 'approver-2@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :APPROVER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Approver',
    last_name: '3',
    email: 'approver-3@kribi.com',
    email_confirmation: 'approver-3@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :APPROVER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Reviewer',
    last_name: '1',
    email: 'reviewer-1@kribi.com',
    email_confirmation: 'reviewer-1@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :REVIEWER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Reviewer',
    last_name: '2',
    email: 'reviewer-2@kribi.com',
    email_confirmation: 'reviewer-2@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :REVIEWER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Reviewer',
    last_name: '3',
    email: 'reviewer-3@kribi.com',
    email_confirmation: 'reviewer-3@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :REVIEWER,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Inputter',
    last_name: '1',
    email: 'inputter-1@kribi.com',
    email_confirmation: 'inputter-1@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :CLERK,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Inputter',
    last_name: '2',
    email: 'inputter-2@kribi.com',
    email_confirmation: 'inputter-2@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :CLERK,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Inputter',
    last_name: '3',
    email: 'inputter-3@kribi.com',
    email_confirmation: 'inputter-3@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :CLERK,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Inputter',
    last_name: '4',
    email: 'inputter-4@kribi.com',
    email_confirmation: 'inputter-4@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :CLERK,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  },
  {
    first_name: 'Inputter',
    last_name: '5',
    email: 'inputter-5@kribi.com',
    email_confirmation: 'inputter-5@kribi.com',
    password: 'password',
    biography: 'hello there',
    role: :CLERK,
    avatar: File.open("./test/fixtures/sample_avatar.png")
  }
].each do |attribute_set|
  Person.create!(attribute_set)
end
