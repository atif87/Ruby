#!/usr/bin/ruby
%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
    config.api_key = '26878d3b045c48a34970c008e2806530a3909c4a072354f3e'
end

# Definitions
Wordnik.word.get_definitions('hysterical')
Wordnik.word.get_definitions('lemurs', :use_canonical => true)
Wordnik.word.get_definitions('fish', :part_of_speech => 'verb,noun')
Wordnik.word.get_definitions('scoundrel', :limit => 20, :source_dictionaries => "ahd,wiktionary,wordnet")

# Examples
Wordnik.word.get_examples('slovenly')
Wordnik.word.get_examples('wrangle', :limit => 10, :skip => 10) # pagination

# Related Words
#Wordnik.word.get_related_words('sad', :type => 'synonym')
#Wordnik.word.get_related_words('bowls', :type => 'hypernym', :use_canonical => true)

# Search
Wordnik.words.search_words(:query => 'dog')
Wordnik.words.search_words(:query => 'cal*', :min_dictionary_count => 3)
Wordnik.words.search_words(:query => '*tin*', :include_part_of_speech => 'verb', :min_length => 5, :max_length => 20)

