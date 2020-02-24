FactoryBot.define do
  sequence(:body) do |i|
    "Some answer #{i}"
  end

  factory :answer do
    association :question
    body

    factory :invalid_answer do
      question { nil }
      body { nil }
    end
  end
end
