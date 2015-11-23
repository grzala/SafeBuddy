require 'anemone'

class News < ActiveRecord::Base


	def self.scrape
	
		#bbc
		titles = []
		Anemone.crawl("http://www.bbc.co.uk/search?q=scotland+crime&filter=news&suggid=") do |anemone|
		  anemone.on_every_page { |page| titles.push page.doc.at('a').inner_html rescue nil }
		end
		puts titles
	end
end
