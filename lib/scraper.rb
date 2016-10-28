require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_subjects_page(periods_url)
    doc = Nokogiri::HTML(open(periods_url))

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
    binding.pry
  end

  def self.scrape_period_page(period_url)
    doc = Nokogiri::HTML(open(period_url))

    paintings = []

    doc.css(".a-thumb-link").each do |painting|
      paintings << {name: painting.css("span.span-painting-title2").text, link: painting.attribute("href").value }
    end
    paintings
    binding.pry
  end

end

Scraper.scrape_subjects_page("https://www.gerhard-richter.com/en/art/paintings")
