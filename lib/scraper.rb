require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc=Nokogiri::HTML(open(index_url))

    students=[]

    doc.css("div.roster-cards-container").each do |card|

      card.css(".student-card a").each do |student|
        link = "./fixtures/student-site/#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << {name: name, location: location, profile_url: link}
      end

    end

    students

  end

  def self.scrape_profile_page(profile_url)
    student={}
    profile=Nokogiri::HTML(open(profile_url))

  end

end
