class Book < ApplicationRecord
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy
	belongs_to :user

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	def self.favorit_last_week
	  Book.joins(:favorites).where(favorites: {created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
	end
  
  def self.looks(searchs, words)
    if searchs == "perfect_match"
      @books = Book.where("title LIKE ?", "#{words}")
    elsif searchs == "partial_match"
      @books = Book.where("title LIKE ?", "%#{words}%")
    elsif searchs == "forward_match"
      @books = Book.where("title LIKE ?", "#{words}%")
    elsif searchs == "rear_match"
      @books = Book.where("title LIKE ?", "%#{words}")
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


end