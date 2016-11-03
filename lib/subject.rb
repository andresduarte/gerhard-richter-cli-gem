require_relative "../lib/scraper.rb"
require 'pry'

class Subject
  ##extend Concerns::Findable
  attr_accessor :name, :subject_url, :songs
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_subjects(subjects_array)
    subjects_array.each do |subject_hash|
      new_subject = Subject.new
      subject_hash.each do |key, value|
        new_subject.send("#{key}=", value)
      end
    end
  end

  def artist
    self.paintings.collect {|painting| painting.artist}.uniq
  end

end

##BASE_PATH = "https://www.gerhard-richter.com"

##subjects_array = Scraper.scrape_subjects_page(BASE_PATH + "/en/art/paintings")
##Subject.create_from_subjects(subjects_array)

##Subject.all.each do |e|
  ##puts "name: #{e.name}"
  ##puts "url: #{e.subject_url}"
##end
