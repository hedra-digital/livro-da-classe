# encoding: UTF-8
class BookCover

  PRIMARY_DEFAULT = '#3483aa'
  SECUNDARY_DEFAULT = '#72abcc'

  TAMANHOS_TITULO = {
    :curto => { :capa1 => "36px", :capa5 => "17px", :lombada => "16px" },
    :medio => { :capa1 => "30px", :capa5 => "17px", :lombada => "14px" },
    :comprido => { :capa1 => "24px", :capa5 => "17px", :lombada => "12px" }
  }

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
    @file = File.read('inksvg/CodigoCapa0921svg.svg')
    troca_cor @cover_info.cor_primaria, @cover_info.cor_secundaria
    troca_fonte @cover_info.book.title
    define_dimensoes_logo
    xml = Nokogiri::XML(@file)
    xml
  end

  def troca_fonte titulo
    tamanho = TAMANHOS_TITULO[:comprido]
    if titulo.length <= 18
      tamanho = TAMANHOS_TITULO[:curto]
    elsif titulo.length <= 36
      tamanho = TAMANHOS_TITULO[:medio]
    end

    @file = @file.gsub("{{Titulo1aCorpo}}", tamanho[:capa1])
    @file = @file.gsub("{{Titulo5aCorpo}}", tamanho[:capa5])
    @file = @file.gsub("{{LombadaCorpo}}", tamanho[:lombada])
  end

  def troca_cor primaria, secundaria
    @file = @file.gsub(PRIMARY_DEFAULT, "##{primaria}") if !primaria.nil?
    @file = @file.gsub(SECUNDARY_DEFAULT, "##{secundaria}") if !secundaria.nil?
  end

  def define_dimensoes_logo
    if !@cover_info.book.project.nil?
      if !@cover_info.book.project.school_logo_file_name.nil?
        width = @cover_info.book.project.school_logo_geometry.width
        height = @cover_info.book.project.school_logo_geometry.height
        if width > height
          height = height / width * 40
          width = 40
        else
          width = width / height * 55
          height = 55
        end
        @file = @file.gsub("{{LogoWidth}}", "#{width}")
        @file = @file.gsub("{{LogoHeight}}", "#{height}")
      else
        @file = @file.gsub("{{LogoWidth}}", "40")
        @file = @file.gsub("{{LogoHeight}}", "40")
      end
    end
  end

  def atualiza_titulo titulo
    @root.css("#TextoTitulo1aCapa").first.children = titulo.to_s
    @root.css("#TextoTitulo5aCapa").first.children = titulo.to_s
  end

  def atualiza_organizador organizador
    @root.elements[8].elements[0].children = organizador.to_s
  end
  
  def atualiza_autor autor
    @root.elements[9].elements[0].children = autor.to_s
  end

  def atualiza_texto_lombada texto_na_lombada
    #@root.elements[10].elements[0].children = texto_na_lombada.to_s
  end
  
  def atualiza_texto_quarta_capa texto_quarta_capa
    @root.css("#ConteudoTexto5aCapa").first.children = texto_quarta_capa.to_s
  end

  def atualiza_logo
    if !@cover_info.book.project.nil?
      @root.elements[5].attributes["absref"].value = !@cover_info.book.project.school_logo_file_name.nil? ? @cover_info.book.project.school_logo.path(:normal).to_s : "inksvg/logo.png"
      @root.elements[5].attributes["href"].value = !@cover_info.book.project.school_logo_file_name.nil? ? @cover_info.book.project.school_logo.path(:normal).to_s : "inksvg/logo.png"
    end
  end

  def atualiza_imagem_capa
    @root.elements[4].attributes["href"].value = !@cover_info.capa_imagem_file_name.nil? ? @cover_info.capa_imagem.path(:small).to_s : "inksvg/1.jpg"
  end

  def atualiza_detalhe_capa
    @root.elements[3].attributes["absref"].value = !@cover_info.capa_detalhe_file_name.nil? ? @cover_info.capa_detalhe.path(:small).to_s : "inksvg/2.jpg"
    @root.elements[3].attributes["href"].value = !@cover_info.capa_detalhe_file_name.nil? ? @cover_info.capa_detalhe.path(:small).to_s : "inksvg/2.jpg"
  end
  
  def atualiza_dados_svg
    #textos
    atualiza_titulo @cover_info.book.title
    atualiza_organizador @cover_info.book.organizers
    atualiza_autor @cover_info.autor
    atualiza_texto_lombada @cover_info.book.title
    atualiza_texto_quarta_capa @cover_info.texto_quarta_capa
    #crop das imagens
    #crop_logo
    crop_capa
    crop_detalhe
    #imagens
    atualiza_logo
    atualiza_imagem_capa
    atualiza_detalhe_capa
  end

  def update_svg novo_svg
    xml = xml()
    @root  = xml.root
    atualiza_dados_svg 
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
    system "inkscape #{pdf_file} --export-area=600:20:1255:900 --export-png=#{png_file}"
    system "convert #{png_file} -background white -flatten #{png_file}"
  end

  def crop_logo
    if !@cover_info.book.project.school_logo_file_name.nil? and @cover_info.cropping_logo?
      file = @cover_info.book.project.school_logo.path(:normal).to_s
      out_file = @cover_info.book.project.school_logo.path(:small).to_s
      dimensions = "#{@cover_info.logo_w}x#{@cover_info.logo_h}+#{@cover_info.logo_x1}+#{@cover_info.logo_y1}"
      crop file, out_file, dimensions
    end
  end

  def crop_capa
    if !@cover_info.capa_imagem_file_name.nil? and @cover_info.cropping_capa?
      file = @cover_info.capa_imagem.path(:normal).to_s
      out_file = @cover_info.capa_imagem.path(:small).to_s
      dimensions = "#{@cover_info.capa_imagem_w}x#{@cover_info.capa_imagem_h}+#{@cover_info.capa_imagem_x1}+#{@cover_info.capa_imagem_y1}"
      crop file, out_file, dimensions
    end
  end

  def crop_detalhe
    if !@cover_info.capa_detalhe_file_name.nil? and @cover_info.cropping_detalhe?
      file = @cover_info.capa_detalhe.path(:normal).to_s
      out_file = @cover_info.capa_detalhe.path(:small).to_s
      dimensions = "#{@cover_info.capa_detalhe_w}x#{@cover_info.capa_detalhe_h}+#{@cover_info.capa_detalhe_x1}+#{@cover_info.capa_detalhe_y1}"
      crop file, out_file, dimensions
    end
  end

  def crop(in_file, out_file, dimensions)
    system "gm convert -crop #{dimensions} #{in_file} #{out_file}"
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