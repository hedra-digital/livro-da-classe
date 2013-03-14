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
    content_tag :span, pluralize(project.remaining_days, 'dia', 'dias'), :class => klass
  end
end
