class ProjectionEngine

  def self.project(movie_list)
    projection = {}
    projection[:weeks] = get_projection_dates
    projection[:movies] = get_movies(movie_list)
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

  def self.get_movies(movie_list)
    return_list = []
    movie_list.each_with_index do |m, index|
      movie = {}
      movie[:title] = m
      movie[:week1] = index + 1
      movie[:week2] = index
      movie[:week3] = index
      movie[:week4] = index
      return_list << movie
    end

    # movie1 = { title: 'Movie1', week1: 1, week2: 20, week3: 30, week4: 40 }
    # movie2 = { title: 'Movie2', week1: 2, week2: 21, week3: 31, week4: 41 }
    # movie3 = { title: 'Movie3', week1: 3, week2: 22, week3: 32, week4: 42 }
    # movie4 = { title: 'Movie4', week1: 4, week2: 23, week3: 33, week4: 43 }
    # movie5 = { title: 'Movie5', week1: 5, week2: 24, week3: 34, week4: 44 }
    # [ movie1, movie2, movie3, movie4, movie5 ]
    return_list
  end

end