class ProjectionEngine

  def self.project(movie_list)
    projection = {}
    projection[:weeks] = ['11/22', '11/29', '12/6', '12/13']
    movie1 = { title: 'Movie1', week1: 10, week2: 20, week3: 30, week4: 40 }
    movie2 = { title: 'Movie2', week1: 11, week2: 21, week3: 31, week4: 41 }
    movie3 = { title: 'Movie3', week1: 12, week2: 22, week3: 32, week4: 42 }
    movie4 = { title: 'Movie4', week1: 13, week2: 23, week3: 33, week4: 43 }
    projection[:movies] = [movie1, movie2, movie3, movie4]
    debugger
    projection
  end

end