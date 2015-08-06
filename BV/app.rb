require 'rubygems' # optional for Ruby 1.9 or above.
require 'slim' # compil before do premailer
require 'premailer'
require 'htmlbeautifier'
project="TH12-bv_BBQ"
# slim
Slim::Engine.set_options pretty: true
srcfile = File.open(project+".slim", "rb").read
outfile = Slim::Template.new{srcfile}
compil = File.open(project+".html", "w")
compil.puts outfile.render
compil.close

# premailer
premailer = Premailer.new(project+'.html')
File.open(project+".html", "w") do |go|
  go.puts premailer.to_inline_css
end

# HtmlBeautifier
dirty_file = File.read(project+".html")
dest = File.open(project+".html", "w")
beautiful = HtmlBeautifier.beautify(dirty_file, tab_stops: 2)
dest.puts beautiful
dest.close

# online
source = File.read(project+".html").gsub('src="images/','src="http://www.webdesignord.fr/domoti/img/images/')
dest = File.open(project+"_online.html", "w")
dest << source
dest.close