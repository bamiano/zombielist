FactoryGirl.define do
  factory :user do
    email("someemail@email.com")
    password("plaintext")
  end
end
