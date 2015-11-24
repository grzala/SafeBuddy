class News < ActiveRecord::Base
	
	def self.scrape
		
		if last_updated = LastUpdated.first.time
			time_dif = ((Time.now - last_updated).to_i / 3600)# in hours
			puts time_dif
			
			return if time_dif < 24
		end
		
		newest = Time.now
		short = false
		if News.all.length < 4
			short = true
			newest = DateTime.new(2000, 10, 31, 2, 2, 2, "+02:00")
		else 
			newest = News.all.order(:date => :desc).first.date
		end
		
		articles = []

		#bbc
		page = Nokogiri::HTML(open("http://www.bbc.co.uk/search?q=scotland+crime&filter=news&suggid="))
		page.css(".media-text").each do |article|
			
			
			title = article.css("h1 a")
			url = title.attribute("href").value
			date = DateTime.parse(article.css("time").attribute("datetime").value)
			
			puts url
			
			break if date <= newest
			articles.push({})
			
			paragraph = Nokogiri::HTML(open(url)).at_css(".story-body__introduction").text

			articles.last[:title] = (title.text)
			articles.last[:url] = (url)
			articles.last[:date] = (date)
			articles.last[:paragraph] = (paragraph)
			articles.last[:src] = ("BBC")
			
			newest = date if !short
			
		end

		
		#the daily record
		page = Nokogiri::HTML(open("http://www.dailyrecord.co.uk/search/simple.do?destinationSectionId=3156&publicationName=dailyrecord&sortString=publishdate&sortOrder=desc&sectionId=3151&articleTypes=+news+opinion+advice&pageNumber=1&pageLength=5&searchString=crime+scotland"))
		page.css(".article").each do |article|
			
			
			title = article.css("h3 a")
			url = title.attribute("href").value
			date = DateTime.parse(article.css("time").attribute("datetime").value)
			
			puts url
			
			break if date <= newest
			articles.push({})
			
			paragraph = Nokogiri::HTML(open(url)).at_css("h2").text

			articles.last[:title] = (title.text)
			articles.last[:url] = (url)
			articles.last[:date] = (date)
			articles.last[:paragraph] = (paragraph)
			articles.last[:src] = ("The daily record")
			
			newest = date if !short
			
		end
	

		#the mirror
		page = Nokogiri::HTML(open("http://www.mirror.co.uk/search/simple.do?destinationSectionId=219&publicationName=mirror&sortString=publishdate&sortOrder=desc&sectionId=69&articleTypes=+news+opinion+advice&pageNumber=1&pageLength=5&searchString=crime+scotland"))
		page.css(".article").each do |article|
			
			title = article.css("h3 a")
			url = title.attribute("href").value
			date = DateTime.parse(article.css("time").attribute("datetime").value)
			
			puts url
			
			break if date <= newest
			articles.push({})
			
			paragraph = Nokogiri::HTML(open(url)).at_css("h2").text

			articles.last[:title] = (title.text)
			articles.last[:url] = (url)
			articles.last[:date] = (date)
			articles.last[:paragraph] = (paragraph)
			articles.last[:src] = ("The mirror")
			
			newest = date if !short
			
		end	
		
		#the scotsman
		page = Nokogiri::HTML(open("http://www.scotsman.com/search?query=crime&p=header"))
		page.css(".search-result-item").each do |article|
			
			title = article.at_css("a")
			url = title.attribute("href").value
			
			next if !Nokogiri::HTML(open(url)).at_css("span.timestamp__date")
			
			date = DateTime.parse(Nokogiri::HTML(open(url)).at_css("span.timestamp__date").text)
			
			puts url
			
			break if date <= newest
			articles.push({})	
			
			paragraph = Nokogiri::HTML(open(url)).at_css(".article__lead").text

			articles.last[:title] = (title.text)
			articles.last[:url] = (url)
			articles.last[:date] = (date)
			articles.last[:paragraph] = (paragraph)
			articles.last[:src] = ("The scotsman")
			
			newest = date if !short
			
		end
		
		articles.each do |article|
			news = News.new(article)
			news.save
		end
		
		last_updated = LastUpdated.first
		last_updated.time = Time.now
		last_updated.save
		
	end

end
