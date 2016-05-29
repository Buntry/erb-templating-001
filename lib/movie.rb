require 'cgi'

class Movie
    attr_accessor :title, :release_date, :director, :summary
    @@movies = []
    
    def initialize(title, release_date, director, summary)
        @title = title
        @release_date = release_date
        @director = director
        @summary = summary
        @@movies << self
    end
    
    def url
        CGI::escape(@title.downcase.gsub(' ', '_').gsub('\'', '')) + ".html"
    end
    
    def self.all
        @@movies
    end
    
    def self.reset_movies!
        @@movies.clear
    end
    
    def self.make_movies!
        file = File.open("./spec/fixtures/movies.txt", "r")
        file.each_line do |line|
            movie_arr = line.split(" - ")
            movie_arr[1] = movie_arr[1].to_i
            Movie.new(*movie_arr)
        end
        file.close
    end
    
    def self.recent
        @@movies.select {|movie| movie.release_date >= 2012}
    end
end