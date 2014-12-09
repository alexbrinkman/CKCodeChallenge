class ProjectionEngine

  def self.project(movie_list)
    projection = {}
    projection[:weeks] = get_projection_dates
    projection[:movies] = project_rankings(movie_list)
    projection
  end

  def self.get_projection_dates
    weeks = []
    4.times do |i|
      saturday = (Date.today.beginning_of_week + 5.days + (i * 7).days)
      weeks << saturday.strftime('%-m/%-d')
    end
    weeks
  end

  def self.project_rankings(movie_list)
    return_list = []
    week2 = random_ranking_array
    week3 = random_ranking_array
    week4 = random_ranking_array

    movie_list.each_with_index do |m, index|
      movie = {}
      movie[:title] = m
      movie[:week1] = index + 1
      movie[:week2] = week2[index]
      movie[:week3] = week3[index]
      movie[:week4] = week4[index]
      return_list << movie
    end

    return_list
  end

  def self.random_ranking_array
    [*1..20].sample(5)
  end

end