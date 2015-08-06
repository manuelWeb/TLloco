require 'slim'
require 'premailer'
require 'htmlbeautifier'
Slim::Engine.set_options pretty: true
project="TH13-ete"

class Slimed
  attr_accessor :src, :out, :path
  def initialize(src,out,path)
    @src = src
    @out = out
    @path = path
  end
  
  def tohtml
    # puts path+src # puts out # puts s2h.render
    srcfile = File.open(path+src, "rb").read
    s2h = Slim::Template.new{srcfile}
    htmlrender = s2h.render  
    
    # ecriture du fichier out = Slimed.new(src,**out**)
    File.open(path+out, "w") do |go|
      go.puts htmlrender
    end

    # init class Premailer > ouverure out en ecriture > traitement premailer+beautify > eciture dans out
    premailer = Premailer.new(path+out)
    File.open(path+out, "w") do |file|
      premailer = premailer.to_inline_css
      beautiful = HtmlBeautifier.beautify(premailer, tab_stops: 2)
      file.puts beautiful
    end
  
  end
end

bf = Slimed.new(project+'.slim', project+'.html', 'BF/')
bv = Slimed.new(project+'.slim', project+'.html', 'BV/')
de = Slimed.new(project+'.slim', project+'.html', 'DE/')
fr = Slimed.new(project+'.slim', project+'.html', 'FR/')
nl = Slimed.new(project+'.slim', project+'.html', 'NL/')
uk = Slimed.new(project+'.slim', project+'.html', 'UK/')
# puts fr.out
bf.tohtml
bv.tohtml
de.tohtml
fr.tohtml
nl.tohtml
uk.tohtml

# online
# source = File.read(project+".html").gsub('src="images/','src="http://www.webdesignord.fr/domoti/img/images/')
# dest = File.open(project+"_online.html", "w")
# dest << source
# dest.close