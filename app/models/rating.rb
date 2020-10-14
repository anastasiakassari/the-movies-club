class Rating < ApplicationRecord
  
  belongs_to :user

  belongs_to :movie

  validates :value,
    inclusion: { in: [1, -1] }
end