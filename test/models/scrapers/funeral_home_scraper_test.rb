class Scrapers::FuneralHomeScraperTest < ActiveSupport::TestCase
  test "scrape carleton funeral home does not raise" do
    url = 'http://www.carletonfuneralhome.ca/obituaries'
    funeral_home = 'Carleton Funeral Home'
    Scrapers::FuneralHomeScraper.scrape(url, funeral_home)
  end

  test "scrape culberson funeral home does not raise" do
    url = 'https://www.culbersonfuneralhome.com/obits'
    funeral_home = 'Culberson Funeral Home'
    Scrapers::FuneralHomeScraper.scrape(url, funeral_home)
  end
end