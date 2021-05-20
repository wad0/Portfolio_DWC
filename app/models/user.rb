class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comics, dependent: :destroy
  has_many :keeps, dependent: :destroy
  has_many :keep_comics, through: :keeps, source: :comic
  # keepsを経由してcomicから情報をとってくる

  validates :name, presence: true

end
