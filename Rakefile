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
  gen.run
end
