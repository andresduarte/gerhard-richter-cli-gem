require 'pry'

class Painting
  extend Concerns::Findable
  attr_accessor :name, :medium, :year, :size, :price, :painting_url,
  attr_reader :artist, :subject
  @@all = []

  def initialize(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end


  def self.create_from_subject(paintings_array)
    paintings_array.each {|attributes_hash| Painting.new(attributes_hash)}
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
    subject.paintings << self unless subject.songs.include?(self)
  end

end
