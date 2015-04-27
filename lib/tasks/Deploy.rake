namespace :deploy do
 
  desc 'Restart application'
    task :restart => :environment do
         exec "echo @Kalpesh123 | sudo -S /etc/init.d/apache2 restart"
    end
 
end
