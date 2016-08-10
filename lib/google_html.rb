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
    content.css('head').first.remove
    content
  end

  def self.convert_footnotes(doc)
    contents = doc.css('a').select {
      |a| footnote_content?(a)
    }

    body = doc.css('body').first
    doc.css('a').each do |a|
      if footnote?(a)
        ftntc = contents.select { |ftntc| footnote_ref(a) == footnote_content_ref(ftntc) }

        a['class'] = 'sdfootnoteanc'
        a['data-id'] = footnote_ref(a)
        a.content = ''
        a.attributes['href'].remove
        a.attributes['id'].remove

        sup = Nokogiri::XML::Node.new 'sup', a
        sup.content = '*'
        sup.parent = a

        sup = a.parent
        sup.add_next_sibling(a)
        sup.remove

        div = ftntc.first.parent.parent
        div['class'] = 'sdfootnotesym'
        div['data-id'] = footnote_content_ref(ftntc.first)

        p_text = ftntc.first.parent
        content = footnote_content(ftntc)
        p_text.children.each { |c| c.remove }
        p_text.content = content
      end
    end
    doc
  end

  def self.footnote_content?(a)
    a.attributes['href'].value.include?('ftnt_ref') && a.parent.name == 'p' if a.attributes['href'].present?
  end

  def self.footnote?(a)
    a.attributes['id'].value.include?('ftnt_ref') && a.parent.name == 'sup' if a.attributes['id'].present?
  end

  def self.footnote_ref(a)
    a.attributes['href'].value.delete('#') if a.attributes['href'].present?
  end

  def self.footnote_content_ref(ftnt_content)
    ftnt_content.attributes['id'].value if ftnt_content.attributes['id'].present?
  end

  def self.footnote_content(ftnt_content)
    ftnt_content.first.parent.children.last.text.gsub(/\u00a0/, '').strip
  end
end
