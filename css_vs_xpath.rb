require 'rubygems'
require 'selenium-webdriver'
require 'benchmark'

LOCATORS = {
  :header_id_and_class => {
    :css => "#table2 thead .dues",
    :xpath => "//table[@id='table2']//thead//*[@class='dues']"
  },
  :header_id_class_and_direct_desc => {
    :css => "#table2 > thead .dues",
    :xpath => "//table[@id='table2']/thead//*[@class='dues']"
  },
  :header_traversing => {
    :css => "#table2 thead tr th:nth-of-type(4)",
    :xpath => "//table[@id='table2']//thead//tr//th[4]"
  },
  :header_traversing_and_direct_desc => {
    :css => "#table2 > thead > tr > th:nth-of-type(4)",
    :xpath => "//table[@id='table2']/thead/tr/th[4]"
  },
  :cell_id_and_class => {
    :css => "#table2 tbody .dues",
    :xpath => "//table[@id='table2']//tbody//*[@class='dues']"
  },
  :cell_id_class_and_direct_desc => {
    :css => "#table2 > tbody .dues",
    :xpath => "//table[@id='table2']/tbody//*[@class='dues']"
  },
  :cell_traversing => {
    :css => "#table2 tbody tr td:nth-of-type(4)",
    :xpath => "//table[@id='table2']//tbody//tr//td[4]"
  },
  :cell_traversing_and_direct_desc => {
    :css => "#table2 > tbody > tr > td:nth-of-type(4)",
    :xpath => "//table[@id='table2']/tbody/tr/td[4]"
  }
}

ENV['iterations'] ||= '100'
# override the number of iterations at runtime with '`iterations=20 ruby css_vs_xpath.rb`

ENV['browser'] ||= 'firefox'
# override browser at runtime with `browser='browser_name' ruby css_vs_xpath.rb`

driver = Selenium::WebDriver.for ENV['browser'].to_sym

# Set up and start the-internet before running the test
# `cd the-internet`
# `bundle install`
# `ruby server.rb`

$stdout = File.new("benchmark_#{ENV['browser']}.log", 'w')
$stdout.sync = true

driver.get "http://localhost:4567/tables"

# The benchmarking approach was borrowed from
# http://rubylearning.com/blog/2013/06/19/how-do-i-benchmark-ruby-code/
Benchmark.bmbm(27) do |bm|
  LOCATORS.each do |example, data|
    data.each do |strategy, locator|
      bm.report(example.to_s + " using " + strategy.to_s) do
        begin
          ENV['iterations'].to_i.times do
             driver.find_element(strategy => locator)
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          puts "N/A"
        end
      end
    end
  end
end

driver.quit
