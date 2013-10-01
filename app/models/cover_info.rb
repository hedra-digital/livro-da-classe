class CoverInfo < ActiveRecord::Base
  belongs_to :book
  attr_accessible :texto_quarta_capa, :autor, :book_id, :organizador, :texto_na_lombada, :titulo_linha1, :titulo_linha2, :titulo_linha3
  
  attr_accessible :capa_imagem
  has_attached_file :capa_imagem, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  attr_accessible :capa_detalhe
  has_attached_file :capa_detalhe, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  after_save :generate_cover


   def generate_cover

    timestamp = DateTime.now.strftime("%m%d%H%M%S")    
    pdf_file = "inksvg/Capa_#{self.book.id}_#{timestamp}.pdf"
    novo_svg = "inksvg/CodigoCapa0921svg_#{self.book.id}_#{timestamp}.svg"
    png_file = "inksvg/Capa_#{self.book.id}_#{timestamp}.png"

    update_svg novo_svg

    generate_pdf pdf_file, novo_svg    
    generate_png pdf_file, png_file
    update_book_cover png_file

    #delete_files
    
  end

  private

  def xml
    require 'net/http'
    require 'rubygems'
    require 'nokogiri'

    # read and parse the old file
    file = File.read('inksvg/CodigoCapa0921svg.svg')
    xml = Nokogiri::XML(file)
    xml
  end

  def atualiza_dados_svg(root)
    cover_info = self
    #parametros
    titulo = [cover_info.titulo_linha1, cover_info.titulo_linha2, cover_info.titulo_linha3]
    organizador= self.book.organizers
    autor=cover_info.autor
    texto_na_lombada = self.book.title
    texto_quarta_capa = cover_info.texto_quarta_capa

    #atualizar o xml
    (0..2).each{|n| root.elements[7].elements[n].children = titulo[n].to_s }
    root.elements[8].elements[0].children = organizador.to_s
    root.elements[9].elements[0].children = autor.to_s
    root.elements[10].elements[0].children = texto_na_lombada.to_s
    root.css("#ConteudoTexto5aCapa").first.children = texto_quarta_capa.to_s
    root.css("#TextoTitulo5aCapa").first.children = titulo.join(" ").to_s
    if !self.book.project.nil?
      root.elements[5].attributes["absref"].value = self.book.project.school_logo.path.to_s if !self.book.project.school_logo.nil?
      root.elements[5].attributes["href"].value = self.book.project.school_logo.path.to_s if !self.book.project.school_logo.nil?
    end
    root.elements[4].attributes["href"].value = cover_info.capa_imagem.path.to_s
    root.elements[3].attributes["absref"].value = cover_info.capa_detalhe.path.to_s
    root.elements[3].attributes["href"].value = cover_info.capa_detalhe.path.to_s
  end

  def update_svg novo_svg
    xml = xml()
    atualiza_dados_svg xml.root
    write_svg xml, novo_svg
  end
  def write_svg xml, novo_svg
    #write
    File.open(novo_svg, "w") do |f|
      f.write xml.to_xml
    end
  end

  def generate_pdf(pdf_file, novo_svg)
    system "inkscape --export-pdf=#{pdf_file} --file=#{novo_svg}"
  end

  def generate_png(pdf_file, png_file)
    system "inkscape #{pdf_file} --export-area=525:26:986:700 --export-png=#{png_file}"
    system "convert #{png_file} -background white -flatten #{png_file}"
  end

  def update_book_cover(png_file)
    self.book.cover = nil
    self.book.cover = File.open(png_file)
    self.book.save
  end

  def delete_files(pdf_file, novo_svg, png_file)
    File.delete pdf_file
    File.delete novo_svg  
    File.delete png_file
  end
end