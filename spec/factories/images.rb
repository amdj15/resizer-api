FactoryGirl.define do
  factory :image do
    filename { "#{SecureRandom.uuid}.jpg" }
    gadget

    factory :image_with_sizes do
      transient do
        image_sizes_cnt 10
      end

      after(:build) do |image, evaluator|
        create_list(:image_size, evaluator.image_sizes_cnt, image: image)
      end
    end
  end
end
