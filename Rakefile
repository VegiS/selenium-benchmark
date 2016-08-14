desc 'Generate report from benchmark data'
task :report do
  require_relative 'lib/table_generator'
  gen = TableGenerator.new
  gen.generate
end

namespace :benchmark do

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

  desc 'Safari'
  task :safari, :version do |t, args|
    ENV['browser'] = 'safari'
    ENV['browser_version'] = args[:version]
    launch
  end
end
