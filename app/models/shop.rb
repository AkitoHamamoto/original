class Shop < ApplicationRecord

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :postal_code
    validates :address
    PHONE_REGEX = /\A\d{11}\z/.freeze
    validates :phone_number, format: { with: PHONE_REGEX, message: '携帯番号には(-)なしで11桁の数字を入力してください' }
  end

end
