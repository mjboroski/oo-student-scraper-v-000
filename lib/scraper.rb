require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc=Nokogiri::HTML(open(index_url))

    students=[]

    doc.css("div.roster-cards-container").each do |card|

      card.css(".student-card a").each do |student|
        link = "#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << {name: name, location: location, profile_url: link}
      end

    end

    students

  end

  def self.scrape_profile_page(profile_url)
    # 
    # profile=Nokogiri::HTML(open(profile_url))
    # 
    # student={}
    # 
    # student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    # student[:bio] = profile.css("div.description-holder p").text if profile.css("div.description-holder p")
    # social = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    # 
    # social.each do |s|
    # 
    #   case s
    #     when s.include?("linkedin")
    #       student[:linkedin] = s
    #     when s.include?("github")
    #       student[:github] = s
    #     when s.include?("twitter")
    #       student[:twitter] = s
    #     else
    #       student[:blog] = s
    #   end
    # 
    # end
    # 
    # student
    student = {}
     profile_page = Nokogiri::HTML(open(profile_url))
     links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
     links.each do |link|
       if link.include?("linkedin")
         student[:linkedin] = link
       elsif link.include?("github")
         student[:github] = link
       elsif link.include?("twitter")
         student[:twitter] = link
       else
         student[:blog] = link
       end
     end
     # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
     # # if profile_page.css(".social-icon-container").children.css("a")[0]
     # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
     # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
     # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
     student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
     student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
 
     student
  end

end
