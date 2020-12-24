class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  has_one_attached :image

  with_options presence: true do
    PRICE_REGEX = /\A[0-9]+\z/.freeze
    validates :number,  uniqueness: true, format: { with: PRICE_REGEX, message: 'テキストナンバーは半角数字のみ保存可能です' }
    validates :title
    validates :text
    validates :video
  end

  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)',"%#{search}%")
    else
      Post.all
    end
  end

end
