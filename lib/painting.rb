require_relative "../lib/subject.rb"
require_relative "../lib/artist.rb"
require 'pry'

class Painting
  ##extend Concerns::Findable
  attr_accessor :name, :medium, :year, :size, :price, :painting_url, :subject
  attr_reader :artist
  @@all = []
  @@names_all = []

  def initialize(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end


  def self.create_from_subject(paintings_array, subject = nil)
    ##paintings_array.each {|attributes_hash| attributes_hash[:subject] = subject}
    paintings_array.each do |attributes_hash|
      new_painting = Painting.new(attributes_hash)
      new_painting.subject = subject
    end

  end

  def add_painting_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    self
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    artist.add_painting(self)
  end

  def subject=(subject)
    @subject = subject
    subject.add_painting(self)
  end

  def self.display(painting)
    puts "  name: #{painting.name}"
    puts "  year: #{painting.year}"
    puts "  size: #{painting.size}"
    puts "  medium: #{painting.medium}"
    if !(painting.price == "")
      puts "  price: #{painting.price}"
    end
    puts "------------------------"
  end

  def self.names
    binding.pry
    Painting.all.each {|painting| @@names_all << painting.name}
  end

  def self.find_by_name(name)
    self.all.detect{|painting| painting.name = name}
  end

end

##BASE_PATH = "https://www.gerhard-richter.com"

##subjects_array = Scraper.scrape_subjects_page(BASE_PATH + "/en/art/paintings")
##Subject.create_from_subjects(subjects_array)

##Subject.all.each do |subject|
  ##paintings_array = Scraper.scrape_subject_page(BASE_PATH + subject.subject_url)
  ##Painting.create_from_subject(paintings_array)
##end

##Painting.all.each do |painting|
  ##attributes = Scraper.scrape_painting_page(BASE_PATH + painting.painting_url)
  ##painting.add_painting_attributes(attributes)
  ##painting.artist = Artist.find_by_name("Gerhard Richter")
##end

##binding.pry
Painting.names
