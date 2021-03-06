require_relative "./japan/version"
require_relative './japan/cli.rb'
require_relative './japan/scraper.rb'
require 'open-uri'
require 'nokogiri'
require 'pry'

#interests: doc.css("div.interests_top_page__category_title")
#interest subcategory: doc.css("div.link_gallery__link__label")
#heading: doc.css("div.page_section__body")
#list:doc.css("spot_list__spot__main_info h1")
#info: doc.css("div.spot_list__spot__desc")
#link to next site: doc.css("div.link_gallery__links a").attribute("href").value

module JapanInfo
  class Japan
    attr_accessor :name, :description, :url
    @@all = []

    def self.new_from_index_page(city)
      self.new(
        city.css(".spot_list__spot__name").text, #city name
        "https://www.japan-guide.com#{city.css(".spot_list__spot__main_info a").attribute("href").value}", #url
        city.css("div.spot_list__spot__desc").text #description of city
        )
    end

    def initialize(name=nil, url=nil, description=nil)
      @name = name
      @url = url
      @description = description
      @@all << self
    end

    def self.all
      @@all
    end

    def self.find(input)
      self.all[input.to_i-1]
    end

    def doc
      @doc = Nokogiri::HTML(open(self.url))
    end

    def spots
      @spots = doc.css(".spot_list__spot__name").collect {|spot| spot.text}
    end

    def hours
      @schedule = doc.css(".spot_list__spot__main_info").collect do |bio|
        if bio.text.include?("Open") || bio.text.include?("Hours:")
          schedule = bio.css(".spot_meta__text_wrap")
          split_schedule = schedule.text.gsub(/(?<=[a-z])(?=[A-Z])/, "\n").gsub(/(?<=[0-9])(?=[A-Z])/, "\n").gsub(/(?<=[)])(?=[A-Z])/, "\n")
        else
          no_schedule = "We could not find any information on shop hours."
        end
      end
    end

    def info
      @info = doc.css(".spot_list__spot__desc").collect {|info| info.text}
    end

  end
end
