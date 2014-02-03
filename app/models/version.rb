class Version
  def self.commit_directory directory, user_profile
    system "cd #{directory}/ && git pull app master && git add #{directory} && git commit -a -m \"#{user_profile}\" && git push app master"
  end

  def self.commit_file text, user_profile, message
    directory = CONFIG[Rails.env.to_sym]["books_path"]
    text.to_file
    message = "(#{message})" unless message.blank?
    system "cd #{directory}/ && git pull app master && git add #{text.filename} && git commit -a -m \"#{user_profile} #{message}\" && git push app master"
  end
end