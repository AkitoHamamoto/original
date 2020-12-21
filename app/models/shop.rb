class Shop < ApplicationRecord

  has_one_attached :image

  with_options presence: true do
    validates :name
    POSTAL_REGEX = /\A\d{3}-\d{4}\z/.freeze
    validates :postal_code, format: { with: POSTAL_REGEX, message: '郵便番号には(-)を含む7桁の数字を入力してください' }
    validates :address
    PHONE_REGEX = /\A\d{11}\z/.freeze
    validates :phone_number, format: { with: PHONE_REGEX, message: '携帯番号には(-)なしで11桁の数字を入力してください' }
  end

end
