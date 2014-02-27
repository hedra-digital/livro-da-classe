class Version

  def self.commit_directory directory, user_profile, directory_name
    system "curl --user tipografiadigital:hedra21 https://api.bitbucket.org/1.0/repositories/ --data name=#{directory_name}"
    system "cd #{directory}/ && git init && git remote add origin #{CONFIG[Rails.env.to_sym]["git"]}/#{directory_name}.git && git add . && git commit -a -m \"#{user_profile}\" && git push origin master"
    system "cd #{directory}/ && git init && git remote add origin #{CONFIG[Rails.env.to_sym]["git"]}/#{directory_name}.git && git add . && git commit -a -m \"#{user_profile}\" && git push origin master"
    Version.add_to_submodule directory_name
  end

  def self.commit_file directory, text, user_profile, user_name, message
    text.to_file
    message = ":: #{message}" unless message.blank?
    filename = File.join(Rails.root, text.filename)
    system "cd #{directory}/ && git pull origin master && git add #{filename} && git commit -a -m \"#{user_profile} (#{user_name}) #{message}\" && git push origin master"
  end

  def self.add_to_submodule directory_name
    submodule_directory = CONFIG[Rails.env.to_sym]["books_submodule_path"]
    git_repo = "#{CONFIG[Rails.env.to_sym]["git"]}/#{directory_name}.git"
    system "cd #{submodule_directory}/ && git submodule add #{git_repo} && git add . && git commit -a -m \"New Book -> #{directory_name}\" && git push origin master"
  end
end