FactoryBot.define do
    factory :photo do
      title { "Sample Photo" }
      description { "A description of the photo" }
      association :user
      association :portfolio
      association :article
      
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/png') }
    end
  end