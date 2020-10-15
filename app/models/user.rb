class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :movies, dependent: :destroy

  has_many :ratings, dependent: :destroy
  
  before_save { self.email = email.downcase }

  validates :username, 
    presence: true, 
    uniqueness: {
      case_sensitive: false
    }, 
    length: {
      minimum: 8, 
      maximum: 25
    }
    
  validates :email, 
    presence: true, 
    uniqueness: {
      case_sensitive: false
    }, 
    format: { 
      with: VALID_EMAIL_REGEX
    }
  
  has_secure_password

  def hasRated(movie)
    ratings = self.ratings
    if ratings.any? && movie != nil
      ratings.find_by(movie_id: movie.id)
    end
  end

  def likes(movie)
    rating = hasRated(movie)
    rating.value == 1 if rating != nil
  end

  def hates(movie)
    rating = hasRated(movie)
    rating.value == -1 if rating != nil
  end
end