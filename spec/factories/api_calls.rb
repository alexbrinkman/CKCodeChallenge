FactoryGirl.define do
  factory :api_call, class: ApiCall do
    source 'PageHit'
    status '200'
  end
end