class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'user_id', dependent: :destroy
  has_many :comments, foreign_key: 'user_id', dependent: :destroy
  has_many :likes, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true, length: { minimum: 5, maximum: 180 }

  def admin?
    role == 'admin'
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
