require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc=Nokogiri::HTML(open(index_url))


    link=doc.search("student-card.div.student-name").text
    name=doc.search("div.student-card.id").text
    location=doc.search("div.student-card.id").text

    student=Student.new(student_hash)

  end

  def self.scrape_profile_page(profile_url)
    # profile=Nokogiri::HTML(open(profile_url))

  end

end
