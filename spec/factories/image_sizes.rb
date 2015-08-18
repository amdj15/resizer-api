FactoryGirl.define do
  factory :image_size do
    width { Faker::Number.between(100, 150) }
    height { Faker::Number.between(100, 150) }

    factory :invalid_image_size do
      height "text value"
    end
  end
end
