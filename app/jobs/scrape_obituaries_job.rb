class ScrapeObituariesJob <  Struct.new(:funeral_home, :url)
  def perform
    browser = Watir::Browser.new :firefox
    browser.goto(url)
    obituaries = scrape(browser, funeral_home)

    obituaries.map { |obit| Obituary.where(name: obit[:name], dod: obit[:dod], funeral_home: obit[:funeral_home]).first_or_create { |o| o.link = obit[:link]}}
  ensure
    browser.close if browser.present?
  end

  def scrape(browser, funeral_home)
    if browser.table(class: 'obitList').exist?
      browser.table(class: 'obitList').tbody.tr.siblings.map do |obit|
        begin
          {
            name: obit.td(class: 'name').text,
            link: obit.td(class: 'name').a.href,
            dod: Time.parse(obit.td(class: 'dod').text),
            funeral_home: funeral_home
          }
        rescue Exception => e
          Rails.logger.error{"funeral_home: #{funeral_home}, html: #{obit.html}"}
          raise e
        end
      end
    else
      obituaries = []
      
      while true
        browser.div(class: 'obit-list').children.each do |obit|
          begin
            next unless obit.class_name == 'obit-item'
            name, lifespan, _ = obit.text.split("\n").reject{|t| t == "Send Flowers"}
            link = obit.a.href
            dod = Time.parse(lifespan.split('-').last)
            obituaries << {
              name: name,
              link: link,
              dod: dod,
              funeral_home: funeral_home
            }
          rescue Exception => e
            Rails.logger.error{"funeral_home: #{funeral_home}, html: #{obit.html}"}
            raise e
          end
        end

        break if browser.div(class: 'pagination').a(class: 'next').class_name.include?('disabled')
        browser.div(class: 'pagination').a(class: 'next').click
        sleep(1)
      end

      obituaries
    end 
  end
end
