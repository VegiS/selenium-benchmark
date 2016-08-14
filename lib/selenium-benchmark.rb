require_relative 'page-objects/small_dom'
require_relative 'page-objects/large_dom'
require 'rest-client'

ENV['iterations'] ||= '100'
ENV['browser'] ||= 'firefox'
raise 'No browser version specified' unless ENV['browser_version']
ENV['base_url'] = 'http://localhost:4567'
TARGETS = [ 'large', 'small' ]
begin
  server_up = RestClient.head(ENV['base_url']).code == 200
rescue Errno::ECONNREFUSED
  raise 'Server not running! Make sure you have a local copy of https://github.com/tourdedave/the-internet running.' unless server_up
end

if ENV['browser'] == 'chrome'
  Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'vendor/chromedriver/2.23/chromedriver') 
end

if ENV['browser'] == 'internet_explorer'
  ENV['PATH'] = ENV['PATH'] + ":" + File.join(Dir.pwd, 'vendor/iedriver/2.53')
end

current_dir = File.join(File.dirname(File.expand_path(__FILE__)))

TARGETS.each do |target|
  driver = Selenium::WebDriver.for ENV['browser'].to_sym
  $stdout = File.new(
              "#{current_dir}/../benchmarks/#{ENV['browser']}_#{ENV['browser_version']}_#{target}.log",
              'w')
  $stdout.sync = true
  if target == 'small'
    page = SmallDOM.new(driver)
  else
    page = LargeDOM.new(driver)
  end
  page.benchmark
  driver.quit
end
