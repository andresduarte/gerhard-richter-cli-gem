require_relative "../lib/scraper.rb"
require_relative "../lib/artist.rb"
require_relative "../lib/subject.rb"
require_relative "../lib/painting.rb"
require 'nokogiri'
require 'pry'

class CommandLineInteface
  BASE_PATH = "https://www.gerhard-richter.com"

  def self.modes
    display_subjects
    puts "Welcome to Gerhard Richter's Catalogue"
    puts "you can search for paintings by subject, catalogue or name"
    @response = gets.strip
  end

  def run
    make_artists
    make_subjects
    make_paintings
    add_paintings_attributes
  end

  def make_artists
    attributes_hash = Scraper.scrape_artist_page("https://en.wikipedia.org/wiki/Gerhard_Richter")
    Artist.create_from_profile(attributes_hash)
  end

  def make_subjects
    subjects_array = Scraper.scrape_subjects_page(BASE_PATH + "/en/art/paintings")
    Subject.create_from_subjects(subjects_array)
  end

  def make_paintings
    Subject.all.each do |subject|
      paintings_array = Scraper.scrape_subject_page(BASE_PATH + subject.subject_url)
      Painting.create_from_subject(paintings_array)
    end
  end

  def add_paintings_attributes
    Painting.all.each do |painting|
      attributes = Scraper.scrape_painting_page(BASE_PATH + painting.painting_url)
      painting.add_painting_attributes(attributes)
      painting.artist = Artist.find_by_name("Gerhard Richter")
    end
  end

  def display_paintings
    Painting.all.each do |painting|
      puts "#{painting.name.upcase}"
      puts "  location:" + " #{painting.year}"
      puts "  size:" + " #{painting.size}"
      puts "  medium:" + " #{painting.medium}"
      puts "  price:" + " #{painting.price}"
    end
  end

  def display_subjects
    Subject.all.each_with_index {|subject, i| puts "#{i}. #{subject}"}
  end

end

aa = CommandLineInteface.new
aa.make_artists
aa.make_subjects
aa.make_paintings
aa.add_paintings_attributes
binding.pry
