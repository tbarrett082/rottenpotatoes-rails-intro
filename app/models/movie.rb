class Movie < ActiveRecord::Base
  def self.defineRatings
    rateList = []
    self.all do |p|
      rateList << p.rating
    end
    rateList = Set[rateList]
    return rateList 
  end   
end
