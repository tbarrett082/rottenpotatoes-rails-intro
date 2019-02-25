class Movie < ActiveRecord::Base
  def self.ratings
    ratingsList = []
    self.all do |p|
      ratingsList << p.rating
    end
    ratingsList = Set[ratingsList]
    return ratingsList
    
end
