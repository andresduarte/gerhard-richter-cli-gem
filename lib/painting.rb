class Painting

  attr_accessor :name, :medium, :year, :size, :price, :painting_url

  @@all = []

  def initialize(attributes_hash)
    add_painting_attributes(attributes_hash)
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_subject(paintings_array)
    paintings_array.each do |attributes_hash|
      new_painting = Painting.new(attributes_hash)
      attributes_hash.each do |key, value|
        new_painting.send("#{key}=", value)
      end
    end
  end

  def add_painting_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

end
