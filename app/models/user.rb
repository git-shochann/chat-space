class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :chats
  # has_many :groups_users
  # has_many :groups, through: :groups_users

  # バリデーションを設けるには、モデルに記載する
  validates :name , presence: true, uniqueness: true  #uniqueness => 名詞
end