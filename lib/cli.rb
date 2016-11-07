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
    puts "Would you like to search the Catalogue by subject, year or name?"
    input_mode = gets.strip
    case input_mode
    when "subject"
      self.subject_display
    when "name"
      self.name_display
    when "year"
      self.year_display
    when "exit"
    else
      puts "Your input was invalid, try again"
      modes
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

  def display_years
    Year.all.each {|year, i| puts " - #{year.name}"}
  end

  def subject_display
    display_subjects
    puts "Select subject by number or name"
    input_subject = gets.strip
    case input_subject
    when "1", "aeroplanes", "Aeroplanes"
      subject_aeroplane = Subject.find_by_name("Aeroplanes")
      subject_aeroplane.paintings.each {|painting| Painting.display(painting)}
      modes
    when "2", "Mother and Child", "mother and child", "Mother and child"
      subject_mother_child = Subject.find_by_name("Mother and Child")
      subject_mother_child.paintings.each {|painting| Painting.display(painting)}
      modes
    when "3", "Children", "children"
      subject_children = Subject.find_by_name("Children")
      subject_children.paintings.each {|painting| Painting.display(painting)}
      modes
    when "4", "Skulls", "skulls"
      subject_skulls = Subject.find_by_name("Skulls")
      subject_skulls.paintings.each {|painting| Painting.display(painting)}
      modes
    when "back"
    else
      puts "Your input is invalid, try again"
      subject_display
    end
  end

  def name_display
    puts "type name"
    input_name = gets.strip.capitalize
    names_all = []
    Painting.all.each {|painting| names_all << painting.name}
    if names_all.uniq.include?(input_name)
      Painting.find_by_name(input_name).each {|painting_match| Painting.display(painting_match)}
      modes
    elsif input_name == "back"
    else
      "Painting not found, type in a different name"
      name_display
    end
  end

  def year_display
    display_years
    puts "type year"
    input_year = gets.strip
    if !Year.find_by_name(input_year).nil?
      selected_year = Year.find_by_name(input_year)
      selected_year.paintings.each {|painting| Painting.display(painting)}
      modes
    elsif input_year == "back"
    else
      puts "No painting found for selected year please select another year"
      year_display
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


##Year.all.each do |year|
  ##puts "#{year.name}"
  ##year.paintings.each do |painting|
    ##puts "  #{painting.name}"
  ##end
##end
