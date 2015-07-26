require 'nokogiri'
require 'open-uri'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


def fourth_ex(query, categories, range)
	if query == nil
		recent_torrents
	else
		parse_range(range).each do |page|
			doc = Nokogiri::HTML(open("https://thepiratebay.mn/search/" + query + "/" +  page.to_s + "/99/" + categories_query(categories)))
			torrents = doc.css("tr")
			unless torrents == 0 
				torrents.shift
				for torrent in torrents
					p "Name: " + torrent.css("a.detLink").attr("title").text
					p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
					p "Seeders: " + torrent.css("td")[2].text
					p "Leechers: " + torrent.css("td")[3].text
				end
			end
		end
	end
end

def parse_range(range)
	return 0..0 if range == nil

	nums = range.split("-")
	first = nums.first.to_i/30
	last = nums.last.to_i/30

	return first..last
end

def recent_torrents 
	doc = Nokogiri::HTML(open("https://thepiratebay.mn/recent"))
	torrents = doc.css("tr")
	unless torrents == 0 
		torrents.shift
		for torrent in torrents
			p "Name: " + torrent.css("a.detLink").attr("title").text
			p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
			p "Seeders: " + torrent.css("td")[2].text
			p "Leechers: " + torrent.css("td")[3].text
		end
	end
end

def categories_query(categories)
	if categories == "All" or categories == nil 
		return "100,200,300,400,500"
	end

	nums = []
	categories_hash = {"Audio" => 100, "Video" => 200, "Applications" =>  300, "Games" => 400, "Porn" => 500}
	for category in categories.split(",")
		nums.push(categories_hash[category])
	end
	query = nums.compact.join(",")
	return query
end

fourth_ex("jimi", "Audio", nil)


=begin

def fifth_ex(query, categories, range)
	nums = range.split("-")
	first = nums.first.to_i/30
	last = nums.last.to_i/30

	(first..last).each do |page|
		Thread.new do
			p page
			doc = Nokogiri::HTML(open("https://thepiratebay.mn/search/" + query + "/" +  page.to_s + "/99/" + categories_query(categories)))
			torrents = doc.css("tr")
			unless torrents == 0 
				torrents.shift
				for torrent in torrents
					p "Name: " + torrent.css("a.detLink").attr("title").text
					p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
					p "Seeders: " + torrent.css("td")[2].text
					p "Leechers: " + torrent.css("td")[3].text
				end
			end
		end
	end
end


def first_ex 
	doc = Nokogiri::HTML(open("https://thepiratebay.mn/recent"))
	torrents = doc.css("tr")
	unless torrents == 0 
		torrents.shift
		for torrent in torrents
			p "Name: " + torrent.css("a.detLink").attr("title").text
			p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
			p "Seeders: " + torrent.css("td")[2].text
			p "Leechers: " + torrent.css("td")[3].text
		end
	end
end

def second_ex(query)
	doc = Nokogiri::HTML(open("https://thepiratebay.mn/search/" + query + "/0/99/0"))
	torrents = doc.css("tr")
	unless torrents == 0 
		torrents.shift
		for torrent in torrents
			p "Name: " + torrent.css("a.detLink").attr("title").text
			p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
			p "Seeders: " + torrent.css("td")[2].text
			p "Leechers: " + torrent.css("td")[3].text
		end
	end
end

def third_ex(query, categories)
	doc = Nokogiri::HTML(open("https://thepiratebay.mn/search/" + query + "/0/99/" + categories_query(categories)))
	torrents = doc.css("tr")
	unless torrents == 0 
		torrents.shift
		for torrent in torrents
			p "Name: " + torrent.css("a.detLink").attr("title").text
			p "Link: " + torrent.css("td")[1].css("a")[1].attr("href")
			p "Seeders: " + torrent.css("td")[2].text
			p "Leechers: " + torrent.css("td")[3].text
		end
	end
end

=end





