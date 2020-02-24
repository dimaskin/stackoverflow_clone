FactoryBot.define do
  sequence :title do |n|
    "Question #{n}"
  end

  factory :question do
    title { "MyString" }
    body { "MyText" }

    factory :invalid_question do
      title { '' }
      body { '' }
    end
  end
end
