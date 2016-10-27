require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_periods_page(periods_url)

    doc = Nokogiri::HTML(open(profile_url))

    periods = []

    doc.css(".div-section-category-mobile a").each do |period|
      title = period.attribute("title").text

      if title.include?("1960-1969")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("1970-1979")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("1980-1984")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("1985-1989")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("1990-1994")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("1995-1999")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("2000-2004")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}
      elsif title.include?("2005")
        periods << {period: title.slice("Abstracts "), link: period.attribute("href").value}



end
