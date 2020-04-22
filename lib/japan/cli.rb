module JapanInfo
  class CLI

    def start
      main_menu
    end

  def main_menu
    JapanInfo::Japan.kanto
    puts "Welcome to JapanInfo! I will be your travel guide today."
    sleep 1
    puts "Which onsens are you most curious about in the Kanto region (nearby Tokyo)?"
    puts ""
    sleep 1
    JapanInfo::Japan.kanto_reader
    puts ""
    puts "Please input a number."

    choice = gets.strip
    case choice
    when "1"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.kusatsu_page)
    when "2"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.manza_page)
    when "3"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.hakone_page)
    when "4"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.minakami_page)
    when "5"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.nasu_page)
    when "6"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.nikko_page)
    when "7"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.ikaho_page)
    when "8"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.kinugawa_page)
    when "9"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.shiobara_page)
    when "10"
      puts "You chose #{choice}."
      pick(JapanInfo::Scraper.shima_page)
    end
  end


  def pick(scraper_webpage)
    puts ""
    puts ""
    sleep 2
    JapanInfo::Japan.info(scraper_webpage)
    puts ""
    puts "Would you like to explore nearby community bath houses?"
    JapanInfo::Japan.spots(scraper_webpage)
    JapanInfo::Japan.spots_reader

    choice = gets.strip
    case choice
    when "#{choice}"
      puts "You chose #{choice}."
      JapanInfo::Japan.nearby_schedule(scraper_webpage,choice.to_i-1)
      # JapanInfo::Japan.nearby_schedule_reader(choice.to_i-1)
    end
  end

end
end
