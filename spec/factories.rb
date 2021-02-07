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
    factory :user_with_watchlists do
      watchlists { [assocation(:watchlist)] }
    end
    factory :user_with_friendships do
      friendships { [assocation(:friendship)] }
    end
  end

  factory :watchlist do
    movie_id {133}
    title {"Land before time"}
    user
  end

  factory :friendship do 
    user
    friend
  end
end