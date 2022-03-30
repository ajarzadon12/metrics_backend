FactoryBot.define do
  factory :metric_info do
    metric { create(:metric) }
    value { Faker::Number.between(from: 1, to: 30) }
    timestamp { Faker::Time.between(from: DateTime.now - 1.second, to: DateTime.now) }

    trait :timestamp_within_1_min do
      timestamp { Faker::Time.between(from: DateTime.now - 1.minute, to: DateTime.now) }
    end

    trait :timestamp_within_1_hour do
      timestamp { Faker::Time.between(from: DateTime.now - 1.hour, to: DateTime.now) }
    end

    trait :timestamp_within_1_day do
      timestamp { Faker::Time.between(from: DateTime.now - 1.day, to: DateTime.now) }
    end
  end
end
