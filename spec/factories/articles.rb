FactoryBot.define do
  factory :article do
    title { FFaker::BaconIpsum.phrase }
    body { FFaker::BaconIpsum.phrase }
    status { ['public', 'private', 'archived'].sample }
  end
end
