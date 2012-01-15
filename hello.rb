#!/usr/bin/ruby
#puts "Hello World!";
#test
%w(rubygems wordnik).each {|lib| require lib}

	Wordnik.configure do |config|
	    config.api_key = '26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
	    config.username = 'atif'
	    config.password = 'damienzinta'
	end
	
	
#	Wordnik.word
#
	r=Wordnik.word();
	if ARGV[0]==nil
		w=Wordnik.words.get_word_of_the_day()
		r.get_definitions(w);
		r.get_examples(w);
		r.get_related(w, :type => 'antonym');
		r.get_related(w, :type => 'synonym');
	end
	if ARGV[0]=='ant'
		x=r.get_related(ARGV[1], :type => 'antonym');
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
