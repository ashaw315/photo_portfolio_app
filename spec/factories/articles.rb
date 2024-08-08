FactoryBot.define do
    factory :article do
      title { "Sample Article Title" }
      content { "This is the content of the article." }
      
      # Assuming you have associations with Portfolio and User
      association :user
      association :portfolio
  
      # Optional: You can add traits if you need different variations
      trait :with_custom_title do
        title { "Custom Article Title" }
      end
  
      trait :with_long_content do
        content { "This is a much longer piece of content for the article, which might be useful for testing purposes. It provides more detailed information and covers various aspects of the topic discussed in the article." }
      end
  
      trait :without_portfolio do
        portfolio { nil }
      end
    end
  end
  