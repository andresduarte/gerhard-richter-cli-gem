# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_artist_page(artist_url)
    doc = Nokogiri::HTML(open(artist_url))

    name = doc.css("span.fn").text
    age = doc.css("span.ForceAgeToShow").text.gsub(/[(age )]/, "")
    nationality = doc.css("table tr:nth-of-type(4) td.category").text
    movement = doc.css("tr td.category a").text
    edu_1 = doc.css("div#mw-content-text table tr:nth-of-type(5) td:first-of-type a.mw-redirect").text + ", "
    edu_2 = doc.css("div#mw-content-text table tr:nth-of-type(5) td:first-of-type a.mw-redirect ~ a")

    edu_2.each_with_index {|edu, i| i.between?(1, edu_2.size - 1) ? edu_1 << edu.text + ", " : edu_1 << edu.text + "."}

    artist = {name: name, age: age, nationality: nationality, movement: movement, education: edu_1, artist_url: artist_url}
    artist
  end

  def self.scrape_subjects_page(subjects_url)
    doc = Nokogiri::HTML(open(subjects_url))
    doc.encoding = 'UTF-8'

    subjects = []

    doc.css("div.div-section-category div.div-section-category-mobile a").each do |subject|
      name = subject.attribute("title").text
      case name
      when "Aeroplanes"
        subjects << {name: name, subject_url: subject.attribute("href").value}
      when "Children"
        subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Women"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Potraits & People"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Mother and Child"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Nudes"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Landscapes"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Clouds"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Everyday Life"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Families"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      ##when "Buildings"
        ##subjects << {name: name, subject_url: subject.attribute("href").value}
      when "Candles"
        subjects << {name: name, subject_url: subject.attribute("href").value}
      when "Skulls"
        subjects << {name: name, subject_url: subject.attribute("href").value}
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
      paintings << {painting_url: painting.attribute("href").value }
      ## try with one line if else, encapsulate conditional logic within hash
      if painting.css("span.span-painting-title2").text == ""
        paintings[counter][:name] = painting.css("span.span-painting-title1").text
      else
        paintings[counter][:name] = painting.css("span.span-painting-title2").text
      end
      counter += 1
    end
    paintings
  end

  def self.scrape_painting_page(painting_url)
    doc = Nokogiri::HTML(open(painting_url))

    painting = {medium: doc.css("p.p-painting-info-medium").text, year: doc.css("span.span-painting-info-year").text,
    size: doc.css("span.span-painting-info-size").text}

    if !doc.css("div.info table tr td:first-of-type").text.nil?
      painting[:price] = doc.css("div.info table tr td:first-of-type").text
    end
    painting
  end

end

##Scraper.scrape_subjects_page("https://www.gerhard-richter.com/en/art/paintings")
##Scraper.scrape_subject_page("https://www.gerhard-richter.com/en/art/paintings/photo-paintings/aeroplanes-19")
##Scraper.scrape_painting_page("https://www.gerhard-richter.com/en/art/paintings/photo-paintings/aeroplanes-19/jet-fighter-5479/?&categoryid=19&p=1&sp=32")
##Scraper.scrape_artist_page("https://en.wikipedia.org/wiki/Gerhard_Richter")
