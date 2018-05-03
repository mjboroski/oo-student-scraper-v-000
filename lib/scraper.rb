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
        students << {profile_url: link, location: location, name: name}
      end

    end

    students

  end

  def self.scrape_profile_page(profile_url)

    profile=Nokogiri::HTML(open(profile_url))

    student={}

    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")
    social = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    social.each do |s|
      case s 
        when s.include?("linkedin")
          student[:linkedin] = s
        when s.include?("github")
          student[:github] = s
        when s.include?("twitter")
          student[:twitter] = s
        else
          student[:blog] = s
      end
    end

    student
  end

end
