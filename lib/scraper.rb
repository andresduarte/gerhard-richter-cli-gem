# encoding: UTF-8

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_subjects_page(subjects_url)
    doc = Nokogiri::HTML(open(subjects_url))

    subjects = []

    doc.css("div.div-section-category div.div-section-category-mobile a").each do |subject|
      name = subject.attribute("title").text

      case name
      when "Aeroplanes"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Children"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Women"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Potraits & People"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Mother and Child"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Nudes"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Landscapes"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Clouds"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Everyday Life"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Families"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Buildings"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Candles"
        subjects << {subject: name, link: subject.attribute("href").value}
      when "Skulls"
        subjects << {subject: name, link: subject.attribute("href").value}
      else
      end
    end
    subjects
  end

  def self.scrape_subject_page(subject_url)
    doc = Nokogiri::HTML(open(subject_url))
    doc.encoding = 'UTF-8'

    paintings = []
    counter = 0

    doc.css(".a-thumb-link").each do |painting|
      paintings << {link: painting.attribute("href").value }
      if painting.css("span.span-painting-title2").text == ""
        paintings[counter][:name] = painting.css("span.span-painting-title1").text
      else
        paintings[counter][:name] = painting.css("span.span-painting-title2").text
      end
      counter += 1
    end
    puts paintings
  end

end



##Scraper.scrape_subjects_page("https://www.gerhard-richter.com/en/art/paintings")
##Scraper.scrape_subject_page("https://www.gerhard-richter.com/en/art/paintings/photo-paintings/aeroplanes-19")
