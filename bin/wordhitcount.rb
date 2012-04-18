#! /usr/bin/env ruby

# Generate YAML listing of website's (eg, Washington Post) refcounts to
# articles with each word in given input file.
#
# Should work with Google, Yahoo, or Bing.  Note that Google will
# blacklist you if you don't sleep plenty.


$usage = <<USAGE
Usage: wordhitcount.rb ENGINE SITE WORDFILE

Example:
  $ wordhitcount.rb bing www.washingtonpost.com gruber-3500-sorted.txt >gruber-3500-wapo-bing.yml &
  $ tail -f gruber-3500-wapo-bing.yml
USAGE

$sleep_time = 0.5

def get_cnt word
  print "#{word}: "
  $stdout.flush

  uri = $partial_uri + word
  ##puts "#{word}: #{uri}"

  agent = 'User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.6) Gecko/20091215 Ubuntu/9.10 (karmic) Firefox/3.5.6'
  agent = "Mozilla/4.0"

  html = `curl -s -A "#{agent}" '#{uri}'`
  ##puts "curl -s -A #{agent} '#{uri}'"
  #puts html
  sleep $sleep_time

  match_list = $match_re.match html

  if not match_list then
    print "NOTFOUND\n"
    return
  end
  cnt = match_list[1]
  ##puts cnt

  print "#{cnt.sub(',', '')}\n"
  $stdout.flush
end

engine, site, word_file = ARGV[0..2]

puts engine
if engine == 'bing' then
  $partial_uri = "http://www.bing.com/search?q=site:" + site + "+"
  $match_re = /<span class="sb_count" id="count">1-\d{1,2} of (\d{1,3}(,\d{3})?) results<\/span>/
elsif engine == 'yahoo' then
  $partial_uri = 'http://search.yahoo.com/search?n=10&vm=p&fl=0&vs=' + site + '&p='
  $match_re = /<strong id="resultCount">(\d{1,3}(,\d{3})?)<\/strong>/
elsif engine == 'google' then
  $partial_uri = 'http://www.google.com/search?hl=en&q=site:' + site + '+'
  $match_re = /of about <b>(\d{1,3}(,\d{3})?)<\/b>/
else
  puts 'bad ENGINE'
  exit 1
end

words = File.open(word_file)
words.each { |w| get_cnt w.chop }
