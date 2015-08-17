FactoryGirl.define do
  factory :gadget do
    token { SecureRandom.base64(64) }

    factory :gadget_with_images do
      transient do
        images_cnt 5
      end

      after(:build) do |gadget, evaluator|
        create_list(:image, evaluator.images_cnt, gadget: gadget)
      end
    end
  end
end
