# Rotten Tomatoes Application

Hello Commerce Kitchen, I hope you enjoy what I've put together.  My general approach was to try and maintain a database as a cache filled with the top 25 box office results from the previous weekend.  With a cache of the 25 movies I had all the data I needed for every view in the app.

I wanted to minimize the number of calls to the RottenTomatoes API, in the interest of speed, and keeping below the request limits.  The app uses its local database for up to 60 minutes before purging and refreshing with data from the API.

The 60 minute setting is changeable in constants.yml, along with the API url, API key, and number of movies to store.

I used a pretty minimal UI, following the basic parameters of what you gave me, changing only where I felt it necessary.  I followed the Rotten Tomatoes Style Guide, for colors, icon sizes, link backs and typeface, which I believe covers their requirements.

Obviously feel free to send me questions.  Thanks again!

## Installation

### Install Dependencies
```$ bundle install```

### Database creation
Modify database.yml (if needed) for your dev environment, then run:
```$ rake db:create```
```$ rake db:migrate```

### Running the tests
```$ rake db:test:prepare``` (once)
```$ rake

### Start the web server
```$ rails s

## Rake Tasks

### Manual force of movie database refresh
```$ rake movies:refresh```

### Purge of movie cache and API call log
```$ rake movies:destroy_all```

## Logging
I'm writing events within the app to the standard logs.  Most of the events are around the refresh of the database which can be viewed without the other standard logging with:

```$ grep "Database Refresh" ./log/development.log```

The calls to the API are logged in the api_calls table in the database.

## Improvements

* I didn't spend much time on speed of tests, I'm sure there are more efficient ways of building up and tearing down.  The suite runs plenty fast, so I didn't optimize.

* Generally a call to an external api should be extracted to an adapter pattern.  That seemed like overkill for this project, but if there was any chance that the movie api would change from Rotten Tomatoes to something else, that would be a nice enhancement.

* In addition, API calls should be from a background queue such as Sidekiq.  Again, I felt this was overkill for a test project, especially given that I'm only making the API call once per hour by default.

* I simply used WEBrick, which obviously isn't appropriate for production, but I felt was appropriate for a test project.