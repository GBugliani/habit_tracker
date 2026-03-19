class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 80 }
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 120 }

  has_many :habits, dependent: :destroy
end
