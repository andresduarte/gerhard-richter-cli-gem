class Artist

  attr_accessor :name, :age, :nationality, :movement, :education
  @@all = []

  def initialize(attributes_hash)
    add_artist_attributes(attributes_hash)
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_profile(attributes_hash)
    new_artist = Artist.new(attributes_hash)
  end


  def add_artist_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    self
  end

end
