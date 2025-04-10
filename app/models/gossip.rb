class Gossip < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_and_belongs_to_many :tags
  
  validates :title, presence: true, length: { minimum: 3, maximum: 14 }
  validates :content, presence: true
end


 