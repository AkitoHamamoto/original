class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :posts
  has_many :boards
  has_many :plans

  has_one_attached :avatar


  with_options presence: true do
    validates :nickname
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :email, uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX, message: 'には@のつくアドレスを入力してください' }
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, length: { minimum: 6 }, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
    validates :birth_date
  
  end

end
