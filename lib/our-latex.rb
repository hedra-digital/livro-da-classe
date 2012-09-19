# encoding: UTF-8

class OurLatex < Kramdown::Converter::Latex

  def convert_header(el, opts)
    type = @options[:latex_headers][output_header_level(el.options[:level]) - 1]
    return "\\#{type}*{#{inner(el, opts)}}\n\n"
  end

end