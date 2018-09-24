FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email { Faker::Internet.email }
    address {Faker::Address.full_address}
    password {"12345678"}
    password_confirmation {"12345678"}
    phone_number {Faker::PhoneNumber.phone_number}
    role {"trainee"}
  end

  factory :admin, class: User do
    name {Faker::Name.name}
    email { Faker::Internet.email }
    address {Faker::Address.full_address}
    password {"12345678"}
    password_confirmation {"12345678"}
    phone_number {Faker::PhoneNumber.phone_number}
    role {"suppervisor"}
  end
end
