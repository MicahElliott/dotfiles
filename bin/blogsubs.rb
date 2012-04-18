#! /usr/bin/env ruby

# blogsubs — Parse for feeds and determine number of subscribers

require 'nokogiri'
require 'open-uri'
require 'set'

site = ARGV[0]
#puts site

doc = Nokogiri::HTML(open site)

#puts `curl http://jeffreyhill.typepad.com  |grep -i "feedburner\.com" |sed -r -e 's#.*(http://feeds\.feedburner.com[^"]+).*#\1#'`

puts "\n\n" + '-'*70

### Check for blogroll.
broll = doc.css('.blogroll a')
##doc.xpath('//h2[contains(text(), "Blogroll")]') # WORKS! but needs more thought
if !broll.empty?
  puts "## BLOGROLL\n\n"
  broll.each do |link|
    puts link.attributes['href'].value
  end
end

### Find feeds.
selectors = [
  # Site-generated
  'link[type="application/rss+xml"]',
  'link[type="application/atom+xml"]',
  # Feedburners
  'a[type="application/rss+xml"]',
  'a[title~="Subscribe"]',
]

feeds = Set.new
selectors.each do |sel|
  doc.css(sel).each { |el| feeds << el.attributes['href'].value }
end
#feeds.each {|f| puts f }

puts "\n## FEEDS"

anal_api = 'https://feedburner.google.com/api/awareness/1.0/GetFeedData?uri='
feeds.each do |f|
  sleep 3
  puts "\n" + f
  #puts "GReaders: " + `greaders.zsh #{f}`
  if f =~ /feedburner/i
    # FIXME: what about feedburner2.com ??
    name = f.sub %r{.*feedburner\.com/}, ''
    begin
      page = open(anal_api + name)
    rescue OpenURI::HTTPError
      puts "unable to access feedburner analysis api for #{name}"
      next
    end
    xml = Nokogiri::HTML(page)
    print 'Circulation: '
    puts xml.css('feed entry')[0].attributes['circulation'].value
  else
    #puts "no feedburners"
  end
end
