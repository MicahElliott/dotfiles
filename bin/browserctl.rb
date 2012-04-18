# Silly target used by uzbl refresher.

puts "Starting browserctl."

tmp = ENV['TMPDIR'] || '/tmp'
pipe = "#{tmp}/refresher.fifo"
#pipe="${1?Must provide pipe}"

watch( 'source/_posts/\*.markdown' ) do |mo|
  print `noticed change to haml`

  puts "waiting for octo…"
  sleep 10
  puts "browserctl: reloading"
  #puts 'uri yahoo.com' > $pipe
  `echo 'reload' > #{pipe}`
end
