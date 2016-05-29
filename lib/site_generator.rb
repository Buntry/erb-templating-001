class SiteGenerator
    def make_index!
        File.open("./_site/index.html", "w") do |f|
            f.puts "<!DOCTYPE html><html><head><title>Movies</title></head><body><ul>"
            Movie.all.each do |movie|
                f.puts '<li><a href="movies/' + "#{movie.url}" + '">' + "#{movie.title}</a></li>"
            end
            f.puts "</ul></body></html>"
            f.close
        end
    end
    
    def generate_pages!
        html = File.open('./lib/templates/movie.html.erb', 'r').read
        template = ERB.new(html)
        Movie.all.each do |movie|
            File.open("./_site/movies/#{movie.url}", "a") { |f| f.write(template.result(binding)) }
        end
    end
end