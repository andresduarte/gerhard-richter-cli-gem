require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_periods_page(periods_url)

    doc = Nokogiri::HTML(open(periods_url))

    periods = []

    doc.css("div.div-section-category div.div-section-category-mobile a").each do |period|
      title = period.attribute("title").text

      if title.include?("1960")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("1970")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("1980")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("1985")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("1990")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("1995")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("2000")
        periods << {period: title.gsub("\u201320", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      elsif title.include?("2005")
        periods << {period: title.gsub("\u201319", "-").gsub("Abstracts ", ""), link: period.attribute("href").value}
      end
    end
    periods
    binding.pry
  end

end
