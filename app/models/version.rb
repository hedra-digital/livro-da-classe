class Version

  def self.commit_file directory, text, user_profile, user_name, message
    text.to_file
    message = ":: #{message}" unless message.blank?
    filename = File.join(Rails.root, text.filename)
    system "cd #{directory}/ && git pull origin master && git add . && git commit -a -m \"#{user_profile} (#{user_name}) #{message}\""
  end

  def self.push_to_repository directory
    system "cd #{directory}/ && git push origin master"
  end
end