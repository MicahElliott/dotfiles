Pry.editor = 'vim'

#Pry.prompt = [ proc { "ENTER INPUT> " }, proc { "MORE INPUT REQUIRED!*" }] 

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end
