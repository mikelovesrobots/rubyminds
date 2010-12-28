load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

def rake_task(name, current=true)
  "rake -f #{current ? current_path : release_path}/Rakefile #{name} RAILS_ENV=production"
end

namespace :deploy do
  task :restart, :roles => [:web] do
    sudo "touch #{current_path}/tmp/restart.txt"
  end
end

