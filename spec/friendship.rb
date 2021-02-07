# FactoryBot.define do
#   factory :user2 do
#     username {"f2"} 
#     email {"f2@test.com"} 
#     password {"f2"} 
#     password_confirmation {"f2"}
#   end
# end

# FactoryBot.define do
#   factory :user3 do
#     username {"f3"} 
#     email {"f3@test.com"} 
#     password {"f3"} 
#     password_confirmation {"f3"}
#   end
# end

# FactoryBot.define do
#   factory :friendship do
#     user2
#     user3
#     user_id {2}
#     friend_id {3}
#   end
# end

# https://stackoverflow.com/questions/35940681/build-factories-for-self-referential-associations-in-rails
# factory :user do
#   gender :male
#   name "super test"

#   trait :with_referrer do
#     association :referrer, factory: :user
#   end
# end

# FactoryGirl.create(:user, :with_referrer)

# https://stackoverflow.com/questions/31420046/self-joins-and-factory-girl
# FactoryGirl.define do
#   factory :candidate do
#     name { Faker::Name.name }
#         affiliation { Faker::Team.name }
#         platform { Faker::Company.catch_phrase }
#         association :nominator, factory: :user
#   end
# end

# https://stackoverflow.com/questions/14444878/factory-girl-how-to-set-up-a-has-many-through-association
# factory :job do
#   ...

#   after_create do |job|
#     job.details << FactoryGirl.create(:detail)
#   end
# end