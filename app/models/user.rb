class User < ApplicationRecord
  has_secure_password
  
  belongs_to :city
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: "sender_id"
  has_and_belongs_to_many :received_messages, class_name: "PrivateMessage"
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end