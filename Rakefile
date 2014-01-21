namespace :server do

  desc 'Pull in the the-internet after initial checkout'
  task :init do
    `git submodule update --init`
  end

  desc 'Pull in the latest from the-internet'
  task :update do
    `git submodule update`
  end

  desc 'Start the web server'
  task :start do
    # Set up and start the-internet before running the test
    # `cd the-internet`
    # `bundle install`
    # `ruby server.rb`
  end

  desc 'Stop the web server'
  task :stop do
    # tbd
  end

end

desc 'Generate report from benchmark data'
task :report do
  require_relative 'lib/table_generator'
  gen = TableGenerator.new
  gen.generate
end

namespace :run do

  desc 'Firefox'
  task :firefox, :version do |t, args|
    system("browser='firefox' browser_version=#{'26' unless args[:version]} ruby lib/selenium-benchmark.rb")
  end

  desc 'Chrome'
  task :chrome, :version do |t, args|
    system("browser='chrome' browser_version=#{'32' unless args[:version]} ruby lib/selenium-benchmark.rb")
  end

  desc 'IE'
  task :internet_explorer, :version do |t, args|
    system("browser='internet_explorer' browser_version=#{'8' unless args[:version]} ruby lib/selenium-benchmark.rb")
  end

  desc 'Opera'
  task :opera do
    `browser='chrome' browser_version=12.16 ruby lib/selenium-benchmark.rb`
  end

end
