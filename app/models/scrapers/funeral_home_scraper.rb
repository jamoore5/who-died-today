class Scrapers::FuneralHomeScraper
  def self.scrape(url, funeral_home)
    ActiveRecord::Base.transaction do
      scrape_obituaries(url, funeral_home) do |obit|
        break unless obit.new_record?
        obit.save!
      end
    end
  end

  def self.scrape_obituaries(url, funeral_home, &block)
    if use_basic_scraper?(url)
      Scrapers::BasicScraper.scrape(url, funeral_home, &block)
    else
      Scrapers::PaginatorScraper.scrape(url, funeral_home, &block)
    end
  end

  def self.use_basic_scraper?(url)
    url.ends_with?('/obituaries')
  end
end