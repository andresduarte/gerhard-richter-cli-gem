require_relative "../lib/scraper.rb"
require_relative "../lib/artist.rb"
require_relative "../lib/subject.rb"
require_relative "../lib/painting.rb"
require_relative "../lib/year.rb"
require 'nokogiri'
require 'pry'
require 'colorize'

class CommandLineInteface
  BASE_PATH = "https://www.gerhard-richter.com"

  def modes
    puts "Welcome to Gerhard Richter's Catalogue"
    puts "Would you like to search the Catalogue by subject or name?"
    input_1 = gets.strip
    case input_1
    when "subject"
      self.subject_display
    when "name"
      self.name_display
    end
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
      Painting.create_from_subject(paintings_array, subject)
    end
  end

  def add_paintings_attributes
    Painting.all.each do |painting|
      attributes = Scraper.scrape_painting_page(BASE_PATH + painting.painting_url)
      painting.add_painting_attributes(attributes)
      painting.artist = Artist.find_by_name("Gerhard Richter")
    end
  end

  def display_subjects
    Subject.all.each_with_index {|subject, i| puts "  #{i + 1}. #{subject.name}"}
  end

  def subject_display
    display_subjects
    puts "Select subject by number or name"
    input_2 = gets.strip
    case input_2
    when "1", "aeroplanes", "Aeroplanes"
      subject_aeroplane = Subject.find_by_name("Aeroplanes")
      subject_aeroplane.paintings.each {|painting| Painting.display(painting)}
      subject_display

    when "2", "Mother and Child", "mother and child", "Mother and child"
      subject_mother_child = Subject.find_by_name("Mother and Child")
      subject_mother_child.paintings.each {|painting| Painting.display(painting)}
      subject_display

    when "3", "Children", "children"
      subject_children = Subject.find_by_name("Children")
      subject_children.paintings.each {|painting| Painting.display(painting)}
      subject_display

    when "4", "Skulls", "skulls"
      subject_skulls = Subject.find_by_name("Skulls")
      subject_skulls.paintings.each {|painting| Painting.display(painting)}
      subject_display

    else
    end
  end

  def name_display
    puts "type name"
    input_2 = gets.strip
    names_all = []
    Painting.all.each {|painting| names_all << painting.name}
    names_all = painting_names_all.uniq
    if names_all.include?(input_2)
      puts "BEGIN"
      Painting.find_by_name(input_2).each {|painting_match| Painting.display(painting_match)}
      puts "END"
    else
      "Painting not found, type in a different name"
      name_display
    end
  end
end

##aa = CommandLineInteface.new
##aa.make_artists
##aa.make_subjects
##aa.make_paintings
##aa.add_paintings_attributes

##aa.subject_display




##Subject.all.each do |subject|
  ##subject.paintings.each do |painting|
    ##puts "  name : #{painting.name}"
    ##puts "  year: #{painting.year.name}"
    ##puts "  size: #{painting.size}"
    ##puts "  medium: #{painting.medium}"
    ##if !(painting.price == "")
      ##puts "  price: #{painting.price}"
    ##end

    ##puts "------------------------"
  ##end
##end
