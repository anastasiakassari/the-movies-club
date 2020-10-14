class Movie < ApplicationRecord
  belongs_to :user
  validates :title, 
    presence: true, 
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
end