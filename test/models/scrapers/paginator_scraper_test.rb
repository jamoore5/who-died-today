class Scrapers::PaginatorScraperTest < ActiveSupport::TestCase
  test "scrape culberson funeral home does not raise" do
    url = 'https://www.culbersonfuneralhome.com/obits'
    funeral_home = 'Culberson Funeral Home'
    total = 0
    Scrapers::PaginatorScraper.scrape(url, funeral_home) do |obit| 
      total += 1
    end
  end
end