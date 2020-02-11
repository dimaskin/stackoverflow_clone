FactoryBot.define do
  factory :question do
    title { "MyText" }
    body  { "MyText" }

    # trait :invalid do
    #   body { nil }
    # end
  end
end
