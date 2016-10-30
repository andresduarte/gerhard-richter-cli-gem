require_relative "../lib/scraper.rb"
require_relative "../lib/scraper.rb"
require 'nokogiri'

class CommandLineInteface

  def self.modes
    display_subjects
    puts "Welcome to Gerhard Richters Catalogue"
    puts "you can search for paintings by subject, catalogue or name"
    @response = gets.strip
  end

  def run
    make_artists
    make_subjects
    make_paintings
    display_subjects
  end

  def make_artists
    Artist.create_from_profile(Scraper.scrape_artist_page(""https://en.wikipedia.org/wiki/Gerhard_Richter""))
  end

  def make_subjects
    subjects_array = Scraper.scrape_subjects_page("https://www.gerhard-richter.com/en/art/paintings")
    Subject.create_from_subjects(subjects_array)
  end

  def make_paintings
    Subject.all.each do |subject|
      paintings_array = Scrape.scrape_subject_page(subject.subject_url)
      Painting.create_from_subject(paintings_array)
    end
  end

  def add_paintings_attributes
    Painting.all.each do |painting|
      attributes = Scrape.scrape_painting_page(painting.painting_url)
      painting.add_paintings_attributes(attributes)
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

  def display_subjects
    Subject.all.each_with_index {|subject, i| puts "#{i}. #{subject}"}
  end

end
