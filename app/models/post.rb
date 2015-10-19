class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  
  
  after_create :create_favorite
  after_create :create_vote #this will automatically give your own post an upvote
  after_create :send_new_post

  default_scope { order('rank DESC') } # most recent will be shown first, changed to 'rank' to show the highest ranked on top.
  scope :visible_to, -> (user) { user ? all :joins(:topic).where('topics.public' => true) }
  
  def up_votes
    votes.where(value: 1).count
  end 

  def down_votes
    votes.where(value: -1).count
  end 

  def points
    votes.sum(:value)
  end 

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end 

  private
  def create_vote
    user.votes.create(value: 1, post: self)
  end 

  def create_favorite
    user.favorites.create(post: self)
  end 

  def send_new_post
    favorites.each do |favorite|
      FavoriteMailer.new_post(favorite.user, self).deliver_now
    end 
  end 

end
