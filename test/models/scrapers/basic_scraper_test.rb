# class Scrapers::BasicScraperTest < ActiveSupport::TestCase
#   test "scrape carleton funeral home does not raise" do
#     url = 'http://www.carletonfuneralhome.ca/obituaries'
#     funeral_home = 'Carleton Funeral Home'
#     total = 0
#     Scrapers::BasicScraper.scrape(url, funeral_home) do |obit| 
#       total += 1
#     end
#   end
# end