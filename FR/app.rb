require 'rubygems' # optional for Ruby 1.9 or above.
require 'slim' # compil before do premailer
require 'premailer'
require 'htmlbeautifier'
project="TH13-ete"
Slim::Engine.set_options pretty: true

class Slimed
  attr_accessor :src, :out
  def initialize(src,out)
    @src = src
    @out = out
  end
  
  def tohtml
    # puts src # puts out # puts s2h.render
    srcfile = File.open(src, "rb").read
    s2h = Slim::Template.new{srcfile}
    htmlrender = s2h.render  
    # ecriture du fichier out = Slimed.new(src,**out**)
    File.open(out, "w") do |go|
      go.puts htmlrender
    end
    # init class Premailer > ouverure out en ecriture > traitement premailer+beautify > eciture dans out
    premailer = Premailer.new(out)
    File.open(out, "w") do |file|
      premailer = premailer.to_inline_css
      beautiful = HtmlBeautifier.beautify(premailer, tab_stops: 2)
      file.puts beautiful
    end

  end
end

fr = Slimed.new(project+'.slim', project+'.html')
# puts fr.src
fr.tohtml

# slim
# srcfile = File.open(project+".slim", "rb").read
# outfile = Slim::Template.new{srcfile}
# compil = File.open(project+".html", "w")
# compil.puts outfile.render
# compil.close

# premailer
# premailer = Premailer.new(project+'.html')
# File.open(project+".html", "w") do |go|
#   go.puts premailer.to_inline_css
# end

# HtmlBeautifier
# dirty_file = File.read(project+".html")
# dest = File.open(project+".html", "w")
# beautiful = HtmlBeautifier.beautify(dirty_file, tab_stops: 2)
# dest.puts beautiful
# dest.close

# online
# source = File.read(project+".html").gsub('src="images/','src="http://www.webdesignord.fr/domoti/img/images/')
# dest = File.open(project+"_online.html", "w")
# dest << source
# dest.close