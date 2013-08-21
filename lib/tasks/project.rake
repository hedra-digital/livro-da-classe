namespace :demo do
  desc "connect to remote server"
  task :connect do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@demo.livrodaclasse.com.br")
  end

  desc "tail staging log"
  task :log do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@demo.livrodaclasse.com.br 'tail -f ~/apps/livrodaclasse/current/log/staging.log'")
  end

  desc "returns a staging console"
  task :console do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@demo.livrodaclasse.com.br  'cd ~/apps/livrodaclasse/current/; bundle exec rails c staging'")
  end

  desc "updates XML sitemap"
  task :sitemap do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@demo.livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake sitemap:refresh'")
  end

  desc "remakes search index and restarts Sphinx"
  task :search_rebuild do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@demo.livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake ts:rebuild'")
  end
end

namespace :staging do
  desc "connect to remote server"
  task :connect do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.livrodaclasse.com.br")
  end

  desc "tail staging log"
  task :log do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.livrodaclasse.com.br 'tail -f ~/apps/livrodaclasse/current/log/staging.log'")
  end

  desc "returns a staging console"
  task :console do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.livrodaclasse.com.br  'cd ~/apps/livrodaclasse/current/; bundle exec rails c staging'")
  end

  desc "updates XML sitemap"
  task :sitemap do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake sitemap:refresh'")
  end

  desc "remakes search index and restarts Sphinx"
  task :search_rebuild do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake ts:rebuild'")
  end
end

namespace :production do
  desc "connect to remote server"
  task :connect do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br")
  end

  desc "tail staging log"
  task :log do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br 'tail -f ~/apps/livrodaclasse/current/log/staging.log'")
  end

  desc "returns a staging console"
  task :console do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br  'cd ~/apps/livrodaclasse/current/; bundle exec rails c staging'")
  end

  desc "updates XML sitemap"
  task :sitemap do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake sitemap:refresh'")
  end

  desc "remakes search index and restarts Sphinx"
  task :search_rebuild do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake ts:rebuild'")
  end
end
