# encoding: UTF-8

class HedraLatex < Kramdown::Converter::Latex
  def convert_header(el, opts)
    type = @options[:latex_headers][output_header_level(el.options[:level]) - 1]
    return "\\#{type}*{#{inner(el, opts)}}\n\n"
  end

  def convert_img(el, opts)
    if el.attr['src'] =~ /^(https?|ftps?):\/\//
      warning("Cannot include non-local image")
      ''
    elsif !el.attr['src'].empty?
      "{\\centering#{latex_link_target(el)}\\includegraphics[width=\\textwidth]{#{Rails.root.join('public')}#{el.attr['src']}}}"
    else
      warning("Cannot include image with empty path")
      ''
    end
  end
end
