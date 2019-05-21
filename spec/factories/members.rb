FactoryBot.define do
  factory :member do
    name FFaker::Name.name
    website_url FFaker::Internet.http_url
  end
end
