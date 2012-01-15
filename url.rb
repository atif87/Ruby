  require 'net/http'

      url = URI.parse('http://www.iana.org/domains/example/index.html')
          req = Net::HTTP::Get.new(url.path)
	    res = Net::HTTP.start(url.host, url.port) {|http|
		          http.request(req)
				      }
    puts res.body
