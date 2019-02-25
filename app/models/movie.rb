class Movie < ActiveRecord::Base
  def self.defineRatings
    return self.pluck(:ratings) 
  end   
end
