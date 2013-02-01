#!/usr/bin/env rake

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec

require "bundler/gem_tasks"
require 'bundler'
Bundler.require

begin
  require "midwire_common/rake_tasks"
rescue Exception => e
  puts ">>> You have to run that under 'bundle exec'"
  exit
end

desc "Generate a ~/.crape/config.yml configuration file."
task :init do
  FileUtils.mkdir_p(Craigslist::Scraper::CRAPEDIR) unless File.exists?(Craigslist::Scraper::CRAPEDIR)
  unless File.exists?(Craigslist::Scraper::CONFIG_FILE)
    File.open(Craigslist::Scraper::CONFIG_FILE, 'w') do |f|
      f.write <<-stop.here_with_pipe(true)
        |mail:
        |  from: <from-email-address>
        |  to: <to-email-address>
        |  subject: 'CRGLST'
        |
      stop
    end
  else
    puts(">>> #{Craigslist::Scraper::CONFIG_FILE} already exists.")
  end
  unless File.exists?(Craigslist::Scraper::DATA_FILE)
    File.open(Craigslist::Scraper::DATA_FILE, 'w') {|f| f.write('')}
  else
    puts(">>> #{Craigslist::Scraper::DATA_FILE} already exists.")
  end
end
