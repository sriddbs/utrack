FactoryBot.define do
  factory :member do
    name FFaker::Name.name
    website_url FFaker::Internet.http_url

    trait :with_website_contents do
      sequence(:website_contents) { |n| { headings: ["Heading #{n}"] } }
    end

    trait :with_friends do
      transient do
        friend nil
      end

      after(:create) do |member, evaluator|
        FactoryBot.create(:friendship, member: member, friend: evaluator.friend)
      end
    end
  end
end
