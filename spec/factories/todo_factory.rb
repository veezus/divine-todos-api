FactoryBot.define do
  factory :todo do
    sequence :title {|i| "An arbitrary todo ##{i}" }

    factory :checked_todo do
      checked_at { DateTime.now }
    end
  end
end
