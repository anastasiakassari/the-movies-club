class Movie < ApplicationRecord

  belongs_to :user

  has_many :ratings, dependent: :destroy

  validates :title, 
    presence: true, 
    uniqueness: {
      case_sensitive: false
    }, 
    length: {
      minimum:4, 
      maximum:100
    }

  validates :description, 
    presence: true, 
    length: {
      minimum:10, 
      maximum:2560
    }

  def likes
    if self.ratings.any?
      self.ratings.find_all{|r| r.value == 1}.count
    else
      0
    end
  end

  def hates
    if self.ratings.any?
      self.ratings.find_all{|r| r.value == -1}.count
    else
      0
    end
  end
end