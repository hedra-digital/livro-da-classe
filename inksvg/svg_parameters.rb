require 'net/http'
require 'rubygems'
require 'nokogiri'

# read and parse the old file
file = File.read('CodigoCapa0921svg.svg')
xml = Nokogiri::XML(file)
root = xml.root

#parametros
titulo = ["Heleno", "Botafogo", "Brasil"]
organizador="Jeff"
autor="Jeff escritor"
texto_na_lombada = "1948"

#atualizar o xml
(0..2).each{|n| root.elements[7].elements[n].children = titulo[n] }
root.elements[8].elements[0].children = organizador
root.elements[9].elements[0].children = autor
root.elements[10].elements[0].children = texto_na_lombada

#write
File.open("CodigoCapa0921svg_new.svg", "w") do |f|
  f.write xml.to_xml
end