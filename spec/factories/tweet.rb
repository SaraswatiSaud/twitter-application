FactoryBot.define do
  factory :tweet do
    content { 'This is test.' }
    association :user   
  end
end
