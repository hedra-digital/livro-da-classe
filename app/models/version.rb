class Version
  def self.commit_directory directory, message
    system "cd #{directory}/ && git add #{directory} && git commit -a -m \"#{message}\" && git push app master"
  end

  def self.commit_file filename, message
    directory = CONFIG[Rails.env.to_sym]["books_path"]
    system "cd #{directory}/ && git add #{filename} && git commit -a -m \"#{message}\" && git push app master"
  end
end