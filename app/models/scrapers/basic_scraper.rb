class Scrapers::BasicScraper < Scrapers::ScraperBase

  def self.scrape(url, funeral_home, &block)
     self.new(url, funeral_home).scrape(&block)
  end

  protected 

  def scrape_obituaries
    get_obituaries.map do |obit_element|
      obit = find_or_initialize_obit(obit_element)
      yield obit
    end
  end

  def get_obituaries
    browser.table(class: 'obitList').tbody.tr.siblings
  end

  def get_name(obit_element)
    obit_element.td(class: 'name').text
  end

  def get_link(obit_element)
    obit_element.td(class: 'name').a.href
  end

  def get_dod(obit_element)
    Time.parse(obit_element.td(class: 'dod').text)
  end

end