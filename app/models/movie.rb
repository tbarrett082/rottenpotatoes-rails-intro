class Movie < ActiveRecord::Base
  def self.defineRatings
    return self.uniq.pluck(:rating) 
  end   
end
