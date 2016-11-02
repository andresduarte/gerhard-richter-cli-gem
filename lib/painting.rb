require 'pry'

class Painting

  attr_accessor :name, :medium, :year, :size, :price, :painting_url,
  attr_reader :artist, :subject
  @@all = []

  def initialize(name, attributes_hash, artist = nil, subject = nil)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def self.create(name, attributes_hash, artist = nil, subject = nil)
    new(name,artist,genre).tap{|new_painting| new_painting.save}
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

Painting.create_from_subject( [{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/bombers-5480/?&categoryid=19&p=1&sp=32", :name=>"Bombers"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/jet-fighter-5479/?&categoryid=19&p=1&sp=32", :name=>"Jet Fighter"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/scharzler-5484/?&categoryid=19&p=1&sp=32", :name=>"Sch\u00E4rzler"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/stukas-5485/?&categoryid=19&p=1&sp=32", :name=>"Stukas"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/airplanes-5486/?&categoryid=19&p=1&sp=32", :name=>"Airplanes"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/mustang-squadron-5141/?&categoryid=19&p=1&sp=32", :name=>"Mustang Squadron"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/xl-513-5487/?&categoryid=19&p=1&sp=32", :name=>"XL 513"},
{:painting_url=>"/en/art/paintings/photo-paintings/aeroplanes-19/phantom-interceptors-5538/?&categoryid=19&p=1&sp=32", :name=>"Phantom Interceptors"}])

##Painting.add_painting_attributes({:medium=>"\nOil on canvas", :year=>"1963", :size=>"\n130 cm x 200 cm", :price=>"\nUSD 11,241,000"})

puts Painting.all
