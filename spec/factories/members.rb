FactoryBot.define do
  factory :member do
    name FFaker::Name.name
    website_url FFaker::Internet.http_url

    trait :with_website_contents do
      sequence(:website_contents) { |n| { headings: ["Heading #{n}"] } }
    end
  end
end
