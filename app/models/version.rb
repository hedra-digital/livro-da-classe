class Version

  def self.commit_directory directory, user_profile, directory_name
    system "curl --user tipografiadigital:hedra21 https://api.bitbucket.org/1.0/repositories/ --data name=#{directory_name}"
    system "cd #{directory}/ && git init && git remote add origin #{CONFIG[Rails.env.to_sym]["git_url"]}/#{directory_name}.git && git add . && git commit -a -m \"#{user_profile}\" && git push origin master"
  end

  def self.commit_file directory, text, user_profile, message
    text.to_file
    message = "(#{message})" unless message.blank?
    system "cd #{directory}/ && git pull origin master && git add #{text.filename} && git commit -a -m \"#{user_profile} #{message}\" && git push origin master"
  end
end