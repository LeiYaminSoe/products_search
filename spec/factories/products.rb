FactoryGirl.define do
  factory :product, class: Product do
    title 'zeta'
    description 'zeta'
    country 'United States'
    price '7.59'
    
    association :tags, factory: :tag
  end

  factory :tag, class: Tag do
    name 'accessories'
  end
end