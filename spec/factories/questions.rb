FactoryBot.define do
  factory :question do
    body { "MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
