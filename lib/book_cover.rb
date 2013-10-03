# encoding: UTF-8
class BookCover
  def initialize cover_info
    @cover_info = cover_info
  end

  def generate_cover
    pdf_file = pdf_file_name
    novo_svg = novo_svg_file_name
    png_file = png_file_name

    update_svg novo_svg

    generate_pdf pdf_file, novo_svg    
    generate_png pdf_file, png_file
    update_book_cover png_file

    delete_files pdf_file, novo_svg, png_file
  end

  def generate_pdf_cover
    timestamp = DateTime.now.strftime("%m%d%H%M%S")    
    pdf_file = pdf_file_name
    novo_svg = novo_svg_file_name    
    update_svg novo_svg

    generate_pdf pdf_file, novo_svg
    pdf_file
  end
  
  private

  def file_id
    timestamp = DateTime.now.strftime("%m%d%H%M%S")
    file_id = "#{@cover_info.book.id}_#{timestamp}"    
  end

  def path
    path_ = "inksvg/tmp/"
    if !Dir.exists?(path_)
      Dir.mkdir path_
    end
    path_
  end
 
  def novo_svg_file_name
    "#{path}Capasvg_#{file_id}.svg"
  end
  
  def pdf_file_name
    "#{path}Capa_#{file_id}.pdf"
  end
  
  def png_file_name
    "#{path}Capa_#{file_id}.png"
  end

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
    cover_info = @cover_info
    #parametros
    titulo = [cover_info.titulo_linha1, cover_info.titulo_linha2, cover_info.titulo_linha3]
    organizador= @cover_info.book.organizers
    autor=cover_info.autor
    texto_na_lombada = @cover_info.book.title
    texto_quarta_capa = cover_info.texto_quarta_capa
    #atualizar o xml
    (0..2).each{|n| root.elements[7].elements[n].children = titulo[n].to_s }
    root.elements[8].elements[0].children = organizador.to_s
    root.elements[9].elements[0].children = autor.to_s
    root.elements[10].elements[0].children = texto_na_lombada.to_s
    root.css("#ConteudoTexto5aCapa").first.children = texto_quarta_capa.to_s
    root.css("#TextoTitulo5aCapa").first.children = titulo.join(" ").to_s
    if !@cover_info.book.project.nil?
      root.elements[5].attributes["absref"].value = !@cover_info.book.project.school_logo_file_name.nil? ? @cover_info.book.project.school_logo.path.to_s : "inksvg/logo.jpg"
      root.elements[5].attributes["href"].value = !@cover_info.book.project.school_logo_file_name.nil? ? @cover_info.book.project.school_logo.path.to_s : "inksvg/logo.jpg"
    end
    root.elements[4].attributes["href"].value = !cover_info.capa_imagem_file_name.nil? ? cover_info.capa_imagem.path.to_s : "inksvg/1.jpg"
    root.elements[3].attributes["absref"].value = !cover_info.capa_detalhe_file_name.nil? ? cover_info.capa_detalhe.path.to_s : "inksvg/2.jpg"
    root.elements[3].attributes["href"].value = !cover_info.capa_detalhe_file_name.nil? ? cover_info.capa_detalhe.path.to_s : "inksvg/2.jpg"
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
    @cover_info.book.cover = nil
    @cover_info.book.cover = File.open(png_file)
    @cover_info.book.save
  end

  def delete_files(pdf_file, novo_svg, png_file)
    File.delete pdf_file
    File.delete novo_svg  
    File.delete png_file
  end
end