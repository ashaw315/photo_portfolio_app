FactoryBot.define do
    factory :portfolio do
      title { "My Portfolio" }
      description { "This is a sample description for the portfolio." }
      association :user
    end
  end