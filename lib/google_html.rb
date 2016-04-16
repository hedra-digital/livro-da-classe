class GoogleHtml

  def self.validate_google_html(content)
    doc = Nokogiri::HTML(content)
    doc = remove_head(doc)
    doc = replace_ol_h1(doc)
    doc = convert_footnotes(doc)
    doc.to_html
  end

  def self.replace_ol_h1(doc)
    doc.css('ol').each do |ol|
      ol.attributes.each do |att|
        if att[0] == 'class' && att[1].value.include?('_1-0')
          text = ol.content
          li = ol.css('li').remove
          ol.name = 'h1'
          ol.content = text
        end
      end
    end
    doc
  end

  def self.remove_head(content)
    content.css('head').remove
    content
  end

  def self.convert_footnotes(doc)
    contents = doc.css('a').select {
      |a| footnote_content?(a)
    }

    doc.css('a').each do |a|
      if footnote?(a)
        ftntc = contents.select { |ftntc| footnote_ref(a) == footnote_content_ref(ftntc) }
        new_a = create_footnote(a)

        sup = Nokogiri::XML::Node.new 'sup', new_a
        sup.content = '*'
        sup.parent = new_a

        div = Nokogiri::XML::Node.new 'div', new_a
        div['class'] = 'sdfootnotesym'
        div['data-id'] = footnote_content_ref(ftntc.first)
        new_a.add_next_sibling(div)

        p_text = Nokogiri::XML::Node.new 'p', div
        p_text.content = footnote_content(ftntc)
        p_text.parent = div

        a_sup = a.parent
        a.parent = a_sup.parent
        a = new_a
      end
    end
    contents.each { |c| c.parent.remove }
    doc
  end

  def self.footnote_content?(a)
    a.attributes['href'].value.include?('ftnt_ref') && a.parent.name == 'p'
  end

  def self.footnote?(a)
    a.attributes['id'].value.include?('ftnt_ref') && a.parent.name == 'sup'
  end

  def self.footnote_ref(a)
    a.attributes['href'].value.delete('#')
  end

  def self.footnote_content_ref(ftnt_content)
    ftnt_content.attributes['id'].value
  end

  def self.footnote_content(ftnt_content)
    ftnt_content.first.parent.children.last.text.gsub(/\u00a0/, '').strip
  end

  def self.create_footnote(a)
    a['class'] = 'sdfootnoteanc'
    a['data-id'] = footnote_ref(a)
    a.attributes['href'].remove
    a.children.remove
    a.attributes['id'].remove
    a
  end
end
