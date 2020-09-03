desc "scape new obituaries from funeral homes"
task scrape_funeral_homes: :environment do
  puts "Starting to scrape funeral homes"
  job = ScrapeFuneralHomesJob.new
  job.perform
  puts "Scrape finish succussfully"
end