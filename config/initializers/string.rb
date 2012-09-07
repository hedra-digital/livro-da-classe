class String

  def br_titleize(word)
    humanize(underscore(word)).gsub(/(?!de|da|do\b)\b\w+/) { $1.capitalize }
  end

  def titular(word)
    humanize(underscore(word)).gsub(/\b('?[a-z])/) { $1.capitalize }
  end

end