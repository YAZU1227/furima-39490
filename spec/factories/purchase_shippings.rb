FactoryBot.define do
  factory :purchase_shipping do
    post_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
    telephone_number { '09011111111' }
    token { 'tok_abcdefghijk00000000000000000' }
    user_id { 1 }
    item_id { 1 }
  end
end
