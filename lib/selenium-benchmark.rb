require_relative 'page-objects/small_dom'
require_relative 'page-objects/large_dom'

ENV['target'] ||= 'large'
ENV['iterations'] ||= '100'
ENV['browser'] ||= 'firefox'
ENV['browser_version'] ||= '1'
ENV['base_url'] = 'http://localhost:4567'
ENV['log_write'] = 'on'

if ENV['log_write'] == 'on'
  current_dir = File.join(File.dirname(File.expand_path(__FILE__)))
  $stdout = File.new("#{current_dir}/../benchmarks/#{ENV['browser']}_#{ENV['browser_version']}.log", 'w')
  $stdout.sync = true
end

driver = Selenium::WebDriver.for ENV['browser'].to_sym
case ENV['target']
when 'small'
  tables = SmallDOM.new(driver)
  tables.benchmark
when 'large'
  large = LargeDOM.new(driver)
  large.benchmark
end

driver.quit
