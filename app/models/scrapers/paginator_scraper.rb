class Scrapers::PaginatorScraper < Scrapers::ScraperBase

  def self.scrape(url, funeral_home, &block)
     self.new(url, funeral_home).scrape(&block)
  end

  protected 

  attr_accessor :name, :lifespan

  def scrape_obituaries(&block)
    raise 'site does not have pagation' unless pagation?
    while true
      get_obituaries.each do |obit_element|
        begin
          next unless obit_element.class_name == 'obit-item'
          obit = find_or_initialize_obit(obit_element)
          yield obit
        end
      end

      break unless has_next_page?
      next_page
    end
  end

  def pagation?
    browser.div(class: 'pagination').exists?
  end

  def get_obituaries
    browser.div(class: 'obit-list').children
  end

  def get_name(obit_element)
    @name, @lifespan, _ = obit_element.text.split("\n").reject{|t| t == "Send Flowers"}
    name
  end

  def get_link(obit_element)
    obit_element.a.href
  end

  def get_dod(obit_element)
    Time.parse(lifespan.split('-').last)
  end

  def has_next_page?
    browser.div(class: 'pagination').a(class: 'next').exist? && !browser.div(class: 'pagination').a(class: 'next').class_name.include?('disabled')
  end

  def next_page
    browser.div(class: 'pagination').a(class: 'next').click
    sleep(1) #throttle
  end

end