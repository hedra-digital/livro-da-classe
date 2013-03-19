# encoding: UTF-8

module ProjectHelper
  def remaining_label(project)
    days = project.remaining_days
    return "" unless days
    klass = case
    when days > 14
      'label'
    when days > 7 && days <=14
      'label label-warning'
    when days <= 7
      'label label-important'
    end
    klass << ' has-tipsy'
    content_tag :span, pluralize(project.remaining_days, 'dia', 'dias'), :class => klass, :title => 'Tempo restante até a data de entrega do projeto'
  end
end
