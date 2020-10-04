FactoryBot.define do
  factory :address, aliases: [:bill_address, :ship_address], class: Spree::Address do
    firstname 'John'
    lastname 'Doe'
    company 'Company'
    address1 '10 Lovely Street'
    address2 'Northwest'
    city 'Herndon'
    zipcode '20170'
    phone '123-456-7890'
    alternative_phone '123-456-7899'

    state { Spree::State.find_by(name: 'Victoria') || Spree::State.first || create(:state) }
    country do |address|
      if address.state
        address.state.country
      else
        Spree::Country.find_by(name: 'Australia') || Spree::Country.first || create(:country)
      end
    end

    trait :randomized do
      firstname { Faker::Name.first_name }
      lastname { Faker::Name.last_name }
      address1 { Faker::Address.street_address }
      address2 nil
      phone { Faker::PhoneNumber.phone_number }
    end
  end
end