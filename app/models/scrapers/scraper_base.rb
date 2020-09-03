class Scrapers::ScraperBase
  def scrape(&block)
    @browser = get_browser
    browser.goto(url)
    scrape_obituaries(&block)
  ensure
    browser.close if browser.present?
  end

  protected 

  attr_accessor :url, :funeral_home, :browser

  def initialize(url, funeral_home)
    @url = url
    @funeral_home = funeral_home
  end

  def get_browser
    return Watir::Browser.new(:firefox) unless Rails.env.production?

    args = %w[--disable-infobars --headless window-size=1600,1200 --no-sandbox --disable-gpu]
    options = {
       binary: ENV['GOOGLE_CHROME_BIN'],
       prefs: { password_manager_enable: false, credentials_enable_service: false },
       args:  args
    }    
    Watir::Browser.new(:chrome, options: options)
  end

  def find_or_initialize_obit(obit_element)
    obit = Obituary.find_or_initialize_by(name: get_name(obit_element), 
      dod: get_dod(obit_element)) 
    obit.link = get_link(obit_element)
    obit.funeral_home = funeral_home
    obit
  end
end