require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc=Nokogiri::HTML(open(index_url))

    student_hash={}

    student_hash[:name]=doc.search("div.student-name").text
    student_hash[:location]=doc.search("div.student-location").text
    student_hash[:profile_url]=doc.search("div.student-card.a.href")

    Student.all<<student_hash
    Student.all
  end

  def self.scrape_profile_page(profile_url)
    # profile=Nokogiri::HTML(open(profile_url))

  end

end
