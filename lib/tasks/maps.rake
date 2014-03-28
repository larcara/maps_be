namespace :maps do
  desc "Pick a random user as the winner"
  task :setup => :environment do
    Rake::Task["db:rollback"].invoke
  end
end