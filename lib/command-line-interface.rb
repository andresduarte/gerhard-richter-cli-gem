require_relative "../lib/scraper.rb"
require_relative "../lib/scraper.rb"
require 'nokogiri'

class CommandLineInteface

  def make_subjects
    subjects_array = Scraper.scrape_subjects_page("https://www.gerhard-richter.com/en/art/paintings")
    Subject.create_from_subjects(subjects_array)
  end

  def create_paintings
    Subject.all.each do |subject|
      paintings_array = Scrape.scrape_subject_page(subject.subject_url)
      Painting.create_from_subject(paintings_array)
    end
  end

  def add_paintings_attributes
    Painting.all.each do |painting|
      attributes = Scrape.scrape_painting_page(painting.painting_url)
      painting.add_paintings_attributes(attributes)
    end
  end

  def display_paintings
    Painting.all.each do |painting|
      
  end

  def display_subjects

  end

end
