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
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.livrodaclasse.com.br 'cd ~/apps/livrodaclasse/current/; rake ts:rebuild'")
  end
end

namespace :sletras do
  desc "connect to remote server"
  task :connect do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@tipografiadigital.com.br")
  end

  desc "tail 7letras log"
  task :log do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@tipografiadigital.com.br 'tail -f ~/apps/livrodaclasse/current/log/sletras.log'")
  end

  desc "returns a 7letras console"
  task :console do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@tipografiadigital.com.br  'cd ~/apps/livrodaclasse/current/; bundle exec rails c sletras'")
  end

  desc "updates XML sitemap"
  task :sitemap do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@tipografiadigital.com.br 'cd ~/apps/livrodaclasse/current/; rake sitemap:refresh'")
  end

  desc "remakes search index and restarts Sphinx"
  task :search_rebuild do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@tipografiadigital.com.br 'cd ~/apps/livrodaclasse/current/; rake ts:rebuild'")
  end
end

namespace :tipostaging do
  desc "connect to remote server"
  task :connect do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.tipografiadigital.com.br")
  end

  desc "tail tipostaging log"
  task :log do
    Kernel.system("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.tipografiadigital.com.br 'tail -f ~/apps/tipografia_staging/current/log/tipostaging.log'")
  end

  desc "returns a tipostaging console"
  task :console do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.tipografiadigital.com.br  'cd ~/apps/tipografia_staging/current/; bundle exec rails c tipostaging'")
  end

  desc "updates XML sitemap"
  task :sitemap do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.tipografiadigital.com.br 'cd ~/apps/tipografia_staging/current/; rake sitemap:refresh'")
  end

  desc "remakes search index and restarts Sphinx"
  task :search_rebuild do
    Kernel.exec("ssh -i ~/.ssh/livrodaclasse_rsa deploy@staging.tipografiadigital.com.br 'cd ~/apps/tipografia_staging/current/; rake ts:rebuild'")
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
