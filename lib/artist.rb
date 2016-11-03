require_relative "../lib/scraper.rb"
require 'pry'

class Artist
  ##extend Concerns::Findable
  attr_accessor :name, :age, :nationality, :movement, :education, :artist_url, :paintings
  @@all = []

  def initialize(attributes_hash)
    self.add_artist_attributes(attributes_hash)
    @paintings = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_profile(attributes_hash)
    Artist.new(attributes_hash)
  end

  def add_artist_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    self
  end

  def add_painting(painting)
    painting.artist = self unless painting.artist == self
    @paintings << painting unless @painting.include?(painting)
  end

  def subjects
    self.paintings.collect {|painting| painting.subject}.uniq
  end

  def self.find_by_name(name)
    self.all.detect{|artist| artist.name = name}
  end
end

##attributes_hash = Scraper.scrape_artist_page("https://en.wikipedia.org/wiki/Gerhard_Richter")
##Artist.create_from_profile(attributes_hash)
