#!/usr/bin/ruby
#puts "Hello World!";
require 'net/http'
require 'net/http'

	proxy_addr = 'proxy.iiit.ac.in'
	proxy_port = 8080

          uri = URI('http://www.google.com/')
          res=Net::HTTP::Proxy(proxy_addr, proxy_port)::Get.new(uri.request_uri) # => String
          res['User-Agent']='Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16'
          req = Net::HTTP::Proxy(proxy_addr, proxy_port).start(uri.hostname, uri.port) {|http|
                    http.request(res)
                    }

          puts res.body

%w(rubygems wordnik).each {|lib| require lib}

	api_key='26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
	Wordnik.configure do |config|
	    config.api_key = '26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
	    config.username = 'atif'
	    config.password = 'damienzinta'
	end
	
	
#	Wordnik.word
	if ARGV[0]=='ant'
		ur='http://api.wordnik.com/v4/word.json/'+ARGV[1]+'/related?type=antonym&api_key='+api_key
		uri = URI(ur)
		res=Net::HTTP::Proxy(proxy_addr, proxy_port)::Get.new(uri.request_uri) # => String
		res['User-Agent']='Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16'
		req = Net::HTTP::Proxy(proxy_addr, proxy_port).start(uri.hostname, uri.port) {|http|
			http.request(res)
		}
#		puts req.body
		i=req.body.split("\"");
		j=3
		while i[j]!='relationshipType' && j<i.size()
			if i[j]!=',' and i[j]!='],'
				puts i[j]
			end
			j=j+1;
		end
	end
	if ARGV[0]=='def'
		r.get_definitions(ARGV[1]);
	end
	if ARGV[0]=='ex'
		r.get_examples(ARGV[1]);
	end	
	if ARGV[0]=='syn'
		r.get_related(ARGV[1], :type => 'synonym');
	end
	if ARGV[0]=='dict'
		r.get_definitions(ARGV[1]);
		r.get_examples(ARGV[1]);
		r.get_related(ARGV[1], :type => 'antonym');
		r.get_related(ARGV[1], :type => 'synonym');
	end
