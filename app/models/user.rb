class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_paper_trail
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :roles

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :encrypted_password, presence: true
end
