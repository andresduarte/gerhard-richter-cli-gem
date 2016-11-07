require 'pry'

class Year

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@all
  end

  def self.create(name)
    new_year = Year.new(name)
    @@all << new_year
    new_year
  end

  def self.find_by_name(name)
    self.all.detect{|obj| obj.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

end
