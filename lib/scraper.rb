require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc=Nokogiri::HTML(open(index_url))

    student_hash={:link,:name,:location}

    student_hash.link=doc.search("student-card.div.student-name").text
    student_hash.name=doc.search("div.student-card.id").text
    student_hash.location=doc.search("div.student-card.id").text

    student=Student.new(student_hash)

  end

  def self.scrape_profile_page(profile_url)
    # profile=Nokogiri::HTML(open(profile_url))

  end

end
