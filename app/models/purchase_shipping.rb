class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building, :telephone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :telephone_number, numericality: { only_integer: true }, length: { in: 10..11 }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
  purchase = Purchase.create(user_id: user_id, item_id: item_id)
  Shipping.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building,
                  telephone_number: telephone_number, purchase_id: purchase.id)
  end
end
