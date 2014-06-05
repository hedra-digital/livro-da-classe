namespace :repo do
  desc "clone all repos in bitbucket"
  desc "how to run: bundle exec rake repo:clone_all"
  task :clone_all => :environment do
    bitbucket = BitBucket.new basic_auth: CONFIG[Rails.env.to_sym]["git_user_pass"]

    repo_dir = "repos_#{Date.today}"
    `mkdir #{repo_dir}`

    bitbucket.repos.all do |repo|
      next if repo.slug.start_with?("development")
      `mkdir #{repo_dir}/#{repo.owner}` unless File.exist?("#{repo_dir}/#{repo.owner}")
      `cd #{repo_dir}/#{repo.owner}
      git clone #{CONFIG[Rails.env.to_sym]["bitbucket_url"]}/#{repo.owner}/#{repo.slug}.git`
    end
  end

end