#!/usr/bin/env ruby

require 'mechanize'
require 'yaml'

CATEGORIES = %w{ hindi telugu tamil malayalam }
DOMAIN     = 'http://www.einthusan.com'
BASE_URL   = "#{DOMAIN}/index.php?lang="
MOVIE_FILE = 'movies.yml'

$scraped_movies  = {}
$existing_movies = {}
$new_movies      = {}

def write_movie_file(movies = {})
  File.open('movies.yml', 'w') do |f|
    f.write(movies.to_yaml)
  end
end

def scrape
  CATEGORIES.each do |lang|
    agent = Mechanize.new
    page = agent.get(BASE_URL + lang.to_s)

    all_movies = page.parser.xpath("//div[@class='movie-showcase-wrapper']")
    first_movie = all_movies.first
    # puts first_movie.to_html
    movie_hash = {}

    # http://stackoverflow.com/questions/17582964/mechanize-script-keeps-stopping-with-fetch-503-nethttpserviceunavailable
    sleep(1)

    movie_hash["name"]       = first_movie.css("a.movie-title").text.split('-').first.strip!
    movie_hash["link"]       = DOMAIN + first_movie.css("a.movie-title")[0]["href"]
    movie_hash["created_on"] = first_movie.css("p.movie-posted").text.gsub(/posted/i, '').strip!
    movie_hash["wiki"]       = first_movie.css("a.movie-wikipedia")[0]['href']

    $scraped_movies[lang] = movie_hash

    if $existing_movies.empty? || $existing_movies[lang]["name"] != movie_hash["name"]
      $new_movies[lang] = movie_hash
    end
  end

  write_movie_file($scraped_movies)
end

def existing_movie_file_contents
  if File.file?(MOVIE_FILE)
    $existing_movies = YAML.load_file(MOVIE_FILE)
  end
end



existing_movie_file_contents
scrape
unless $new_movies.empty?
  puts "You've been served an email!"
  puts $new_movies.to_yaml
else
  puts "nothing uploaded"
end