class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true
#ternary operator keeps the lambda on one line.  
  scope :visible_to, -> (user) { user ? all : where(public: true) }
end
