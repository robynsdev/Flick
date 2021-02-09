FactoryBot.define do
  factory :user, aliases: [:friend] do
    sequence :username do |n|
      "name#{n}"
    end
    sequence :email do |n|
      "email#{n}@test.com"
    end
    sequence :password do |n|
      "password#{n}"
    end
    sequence :password_confirmation do |n|
      "password#{n}"
    end

    trait :invalid do 
      email {nil}
    end

    factory :user_with_watchlists do
      transient do
        watchlists_count { 5 }
      end
      after(:create) do |user, evaluator|
        create_list(:watchlist, evaluator.watchlists_count, user: user)
        user.reload
      end
    end
    factory :user_with_friendships do
      transient do
        friendships_count { 5 }
      end
      after(:create) do |user, evaluator|
        create_list(:friendship, evaluator.friendships_count, user: user)
        user.reload
      end
    end
  end

  factory :watchlist do
    movie_id {133}
    title {"Land before time"}
    association :user

    trait :invalid do 
      title {nil}
    end
  end

  factory :friendship do 
    association :user
    association :friend
  end
end