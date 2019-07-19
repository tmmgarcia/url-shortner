FactoryBot.define do
  factory :short_uri do
    original_uri { 'https://devs.gapfish.com/' }
    path { 'guhaig9' }
    times_clicked { 0 }
  end
end
