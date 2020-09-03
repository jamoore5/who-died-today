class ScrapeFuneralHomesJob
  @@funeral_homes = [
    {
      funeral_home: 'Carleton Funeral Home',
      url: 'http://www.carletonfuneralhome.ca/obituaries'
    },
    {
      funeral_home: 'Culberson Funeral Home',
      url: 'https://www.culbersonfuneralhome.com/obits'
    },
    {
      funeral_home: 'Scott Funeral Home',
      url: 'https://www.scottfh.com/obits'
    },
    {
      funeral_home: 'Britton Funeral Home',
      url: 'http://www.brittonfh.ca/obituaries'
    },
    {
      funeral_home: 'L R Giberson Funeral Directors',
      url: 'http://www.gibersonfuneraldirectors.ca/obituaries'
    }
  ]

  def perform
    @@funeral_homes.each do |site|
      Scrapers::FuneralHomeScraper.scrape(site[:url], site[:funeral_home])
    end
  end
end