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
		returnstrin=[]
		while i[j]!='relationshipType' && j<i.size()
			if i[j]!=',' and i[j]!='],'
#				puts i[j]
				returnstring=[returnstring,i[j]]
			end
			j=j+1;
		end
		return returnstring

	end
	def synonym(word)
	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/related?type=synonym&api_key='+api_key
		body=content(ur)
		i=body.split("\"");
		returnstrin=[]
		j=3
		while i[j]!='relationshipType' && j<i.size()
			if i[j]!=',' and i[j]!='],'
#puts i[j]
				returnstring=[returnstring,i[j]]
			end
			j=j+1;
		end
		return returnstring

	end
	def definitions(word)
	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/definitions?includeRelated=false&includeTags=false&useCanonical=false&api_key='+api_key
		body=content(ur);
		i=body.split("\"text\":");
		j=1;
		returnstrin=[]
		while j<i.size
			b=i[j].split("\"score\":")
			if !b[0].index('}')
#	puts b[0]
				returnstring=[returnstring,b[0]]
			end
			j=j+1;
		end
		return returnstring
	end
	def example(word)
		api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
		ur='http://api.wordnik.com/v4/word.json/'+word+'/definitions?includeRelated=true&includeTags=false&useCanonical=false&api_key='+api_key
		body=content(ur)
		i=body.split("\"text\":");
#		puts body
		j=1;
		returnstrin=[]
		while j<i.size
			b=i[j].split("\"score\":")
#			puts b[0].index('}')
			
			if !b[0].index('}')
				returnstring=[returnstring,b[0]]
#				puts b[0]
			end
#			puts b[0]
			j=j+1;
		end
		return returnstring

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
		puts antonym(string)
		puts 'Example'
		puts example(string)
		puts 'Synonym'
		puts synonym(string)
		puts 'Definitions'
		puts definitions(string)
	end
	def play(word)
		d=definitions(word)
		s=synonym(word)
		a=antonym(word)
#		puts d.size
		j=d.size
		if a
			puts a.size
			j=j+a.size
		end
		if s
			puts s.size
			j=j+s.size
		end
		puts j
		d_count=2;
		a_count=1;
		s_count=1;
		count =0;
		puts 'Definition:'
		puts d[1]
		puts 'Your Guess'
		list=3;
		while count<j
			input=STDIN.gets
			if input==word
				puts 'You Win'
			end	
			i=0;
			if s
				while(i< (s.size))
					if s[i]==input
						puts 'You Win'
						return
					end
					i=i+1;
				end
			end
			if input =='quit'
				puts word
			end
			if count%3==1 and d_count<d.size
				puts 'Definitions:'
				puts d[d_count]
				d_count=d_count+1;
			end
			
			if a and count%3==2 and a_count<a.size
				puts 'Antonym:'
				puts a[a_count]
				a_count=a_count+1;
			end
			if s and count%3==3 and s_count<s.size
				puts 'Synonym:'
				puts s[s_count]
				s_count=s_count+1;
			end
			count=count+1
#		puts count
		end
		puts 'The word is:'+word
		puts 'You Lose'
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
		puts antonym(ARGV[1])
	end
	if ARGV[0]=='def'
		puts definitions(ARGV[1])
		url='http://api.wordnik.com/v4/words.json/search?caseSensitive=true&limit=10&query='+ARGV[1]+'&skip=0&api_key='+api_key
		h=Hash.new(0)
		
		body=content(url)
#puts body
		hist= body.split('},{')
		k=0;
		sugg=[];
		while k<hist.size
			str=hist[k].split('wordstring')
			x= str[1].delete "\""
			y=str[0].split("count")
			height=y[1].delete "\""
			h[(x.delete ":").delete "}]"]=((height.delete ",").delete ":").to_i
			if h[(x.delete ":").delete "}]"]>h[ARGV[1]]
				sugg=[sugg,((x.delete ":").delete "}]")]
			end
			k=k+1;
		end
		puts 'do you mean'
		puts sugg
	end
	if ARGV[0]=='ex'
		puts example(ARGV[1])
	end
	if ARGV[0]=='syn'
		puts synonym(ARGV[1])
	end
	if ARGV[0]==nil
		getwordoftheday()
	end
	if ARGV[0]=='dict'
		puts 'Example'
		puts example(ARGV[1]);
		a=STDIN.gets
		puts 'Definitions'
		puts definitions(ARGV[1]);
		a=STDIN.gets
		puts 'Synonym'
		puts synonym(ARGV[1]);
		a=STDIN.gets
		puts 'Antonym'
		puts antonym(ARGV[1]);
	end
	if ARGV[0]=='play'
		url='http://api.wordnik.com/v4/words.json/randomWord?hasDictionaryDef=true&api_key='+api_key
		body=content(url)
		a= body.split("\"word\":")
		play((a[1].delete('}')).delete('\"'))
	end
