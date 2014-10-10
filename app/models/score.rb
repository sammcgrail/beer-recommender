module Score
  @dictionary = Dictionary.last.payload
  @all_beers = Beer.all
  class << self

    def dictionary
      @dictionary
    end

    def simpearson(o_user_id, c_user_id)
    #calculates similarity score between two users; o_user is the other user hash; c_user is the current user hash
      o_user_id = o_user_id.to_s
      c_user_id = c_user_id.to_s
      mutual = []
      @dictionary[o_user_id].each do |o_beer, o_taste|
        @dictionary[c_user_id].each do |c_beer, c_taste|
          mutual << [o_taste, c_taste] if o_beer == c_beer
        end
      end
      n = mutual.length
      return 0 if n == 0
      o_sum = 0
      c_sum = 0
      o_sum_squared = 0
      c_sum_squared = 0
      psum = 0
      mutual.each do |ratings|
        o_sum += ratings.first
        c_sum += ratings.last
        o_sum_squared += ratings.first * ratings.first
        c_sum_squared += ratings.last * ratings.last
        psum += ratings.first * ratings.last
      end
      numerator = psum - (o_sum * c_sum / n)
      denominator = Math.sqrt((o_sum_squared - (o_sum)**2/n) * (c_sum_squared - (c_sum)**2/n))
      if denominator == 0
        return 0
      else
        numerator/denominator
      end
    end

    def top_matches(c_user_id)
    # returns top 10 users with similar tastes as another user
      c_user_id = c_user_id.to_s
      scores = []
      @dictionary.each do |o_user_id, ratings|
        scores << [simpearson(o_user_id, c_user_id), o_user_id]
      end
      scores = scores.sort.reverse
      scores.take(11)
    end

    def recommendations(c_user_id)
      totals = Hash.new
      sim_sums = Hash.new

      User.all.each do |person|
        if person.id == c_user_id
          next
        end

        sim = simpearson(c_user_id, person.id)

        if sim == nil || sim <= 0.5
          next
        end

        person_ratings = User.where(id: person.id).first.reviews
        user_ratings = User.find(c_user_id).reviews

        person_ratings.each do |rating|
          if !user_ratings.include?(rating)
            totals.default = 0
            totals[rating.beer_id] += rating.taste * sim
            sim_sums.default = 0
            sim_sums[rating.beer_id] += sim
          end
        end
      end

      rankings = Hash.new
      totals.each do |beer_id, sim_score|
          rankings[beer_id] = sim_score / sim_sums[beer_id]
      end

      rankings.sort_by{|beer_id, taste| -taste}
    end
  end
end
