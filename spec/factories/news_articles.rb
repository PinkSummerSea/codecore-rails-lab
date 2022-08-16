FactoryBot.define do
  random_text = "blah blah blah"
  factory :news_article do
    sequence(:title) {|n| Faker::Book.title + "#{n}"}
    description {random_text}
    view_count {rand(0..50_000)}
    association :user, factory: :user
  end
end
