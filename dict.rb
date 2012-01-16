#!/usr/bin/env ruby
#puts "Hello World!";
require 'net/http'
require 'net/http'

	proxy_addr = 'proxy.iiit.ac.in'
	proxy_port = 8080
	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
	def content(url)
		proxy_addr = 'proxy.iiit.ac.in'
		proxy_port = 8080
		ur=url
		uri = URI(ur)
		res=Net::HTTP::Proxy(proxy_addr, proxy_port)::Get.new(uri.request_uri) # => String
		res['User-Agent']='Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16'
		req = Net::HTTP::Proxy(proxy_addr, proxy_port).start(uri.hostname, uri.port) {|http|
		http.request(res)
		}
		return req.body
	end
	def antonym(word)
		api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/related?type=antonym&api_key='+api_key
		body=content(ur)
		j=3	
		i=body.split("\"");

		while i[j]!='relationshipType' && j<i.size()
			if i[j]!=',' and i[j]!='],'
				puts i[j]
			end
			j=j+1;
		end

	end
	def synonym(word)
	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/related?type=synonym&api_key='+api_key
		body=content(ur)
		i=body.split("\"");
		j=3
		while i[j]!='relationshipType' && j<i.size()
			if i[j]!=',' and i[j]!='],'
				puts i[j]
			end
			j=j+1;
		end

	end
	def definitions(word)
	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/definitions?includeRelated=false&includeTags=false&useCanonical=false&api_key='+api_key
		body=content(ur);
		i=body.split("\"text\":");
		j=1;
		while j<i.size
			b=i[j].split("\"score\":")
			if !b[0].index('}')
				puts b[0]
			end
			j=j+1;
		end
	end
	def example(word)
		api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/definitions?includeRelated=true&includeTags=false&useCanonical=false&api_key='+api_key
		body=content(ur)
		i=body.split("\"text\":");
#		puts body
		j=1;
		while j<i.size
			b=i[j].split("\"score\":")
#			puts b[0].index('}')
			if !b[0].index('}')
				puts b[0]
			end
#			puts b[0]
			j=j+1;
		end

	end
	def getwordoftheday()
		api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		time=Time.new
		a=time.year;
		b=time.month
		c=time.day
		today= a.to_s+'-'+b.to_s+'-'+c.to_s
		ur='http://api.wordnik.com/v4/words.json/wordOfTheDay?date='+today+'&api_key='+api_key
		body=content(ur)
		i=body.split("\"word\":")
		str=i[1].split(',');
		string=str[0].delete "\""
		puts string
		puts 'Antonym'
		antonym(string)
		puts 'Example'
		example(string)
		puts 'Synonym'
		synonym(string)
		puts 'Definitions'
		definitions(string)
	end



#         uri = URI('http://www.google.com/')
#          res=Net::HTTP::Proxy(proxy_addr, proxy_port)::Get.new(uri.request_uri) # => String
#         res['User-Agent']='Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16'
#          req = Net::HTTP::Proxy(proxy_addr, proxy_port).start(uri.hostname, uri.port) {|http|
#                   http.request(res)
#                    }

#  puts res.body


	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
	if ARGV[0]=='ant'
		antonym(ARGV[1])
	end
	if ARGV[0]=='def'
		definitions(ARGV[1])
	end
	if ARGV[0]=='ex'
		example(ARGV[1])
	end
	if ARGV[0]=='syn'
		synonym(ARGV[1])
	end
	if ARGV[0]==nil
		getwordoftheday()
	end
	if ARGV[0]=='dict'
		puts 'Example'
		example(ARGV[1]);
		a=STDIN.gets
		puts 'Definitions'
		definitions(ARGV[1]);
		a=STDIN.gets
		puts 'Synonym'
		synonym(ARGV[1]);
		a=STDIN.gets
		puts 'Antonym'
		antonym(ARGV[1]);
	end
	if ARGV[0]=='play'
#		setofwords=['easy','hysterical']
	end
