namespace :server do

  desc 'Pull in the the-internet after initial checkout'
  task :init do
    `git submodule update --init`
  end

  desc 'Start the web server'
  task :start do
    Dir.chdir('the-internet')
    `bundle`
    `ruby server.rb`
  end

end

desc 'Generate report from benchmark data'
task :report do
  require_relative 'lib/table_generator'
  gen = TableGenerator.new
  gen.generate
end

namespace :run do

  def launch
    `ruby lib/selenium-benchmark.rb`
  end

  desc 'Firefox'
  task :firefox, :version do |t, args|
    ENV['browser'] = 'firefox'
    ENV['browser_version'] = args[:version]
    launch
  end

  desc 'Chrome'
  task :chrome, :version do |t, args|
    ENV['browser'] = 'chrome'
    ENV['browser_version'] = args[:version]
    launch
  end

  desc 'IE'
  task :internet_explorer, :version do |t, args|
    ENV['browser'] = 'internet_explorer'
    ENV['browser_version'] = args[:version]
    launch
  end

  desc 'Opera'
  task :opera, :selenium_server_path do |t, args|
    ENV['browser'] = 'opera'
    ENV['browser_version'] = '12'
    ENV['SELENIUM_SERVER_JAR'] = args[:selenium_server_path]
    launch
  end

end
