load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

def rake_task(name, current=true)
  "rake -f #{current ? current_path : release_path}/Rakefile #{name} RAILS_ENV=production"
end

after "deploy:update_code", "deploy:post_update_rake_tasks"

namespace :deploy do

  desc "Migrate the database and install gems"
  task :post_update_rake_tasks, :roles => [:web] do
    sudo rake_task("gems:install", false) 
  end

  task :restart, :roles => [:web] do
    sudo "/etc/init.d/httpd restart"
  end
end

