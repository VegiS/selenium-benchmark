require 'rubygems'
require 'selenium-webdriver'
require 'benchmark'
require 'benchmark/ips'
require 'pry'

LOCATORS = {
  :dues_header_id_and_class => {
    :css => "#table2 thead .dues",
    :xpath => "//table[@id='table2']//thead//*[@class='dues']"
  },
  :dues_header_id_class_and_direct_desc => {
    :css => "#table2 > thead .dues",
    :xpath => "//table[@id='table2']/thead//*[@class='dues']"
  },
  :dues_header_traversing => {
    :css => "#table2 thead tr th:nth-of-type(4)",
    :xpath => "//table[@id='table2']//thead//tr//th[4]"
  },
  :dues_header_traversing_and_direct_desc => {
    :css => "#table2 > thead > tr > th:nth-of-type(4)",
    :xpath => "//table[@id='table2']/thead/tr/th[4]"
  },
  :dues_cell_id_and_class => {
    :css => "#table2 tbody .dues",
    :xpath => "//table[@id='table2']//tbody//*[@class='dues']"
  },
  :dues_cell_id_class_and_direct_desc => {
    :css => "#table2 > tbody .dues",
    :xpath => "//table[@id='table2']/tbody//*[@class='dues']"
  },
  :dues_cell_traversing => {
    :css => "#table2 tbody tr td:nth-of-type(4)",
    :xpath => "//table[@id='table2']//tbody//tr//td[4]"
  },
  :dues_cell_traversing_and_direct_desc => {
    :css => "#table2 > tbody > tr > td:nth-of-type(4)",
    :xpath => "//table[@id='table2']/tbody/tr/td[4]"
  }
}

browser = Selenium::WebDriver.for :firefox # replace :firefox with the browser you're having trouble with

begin
  browser.get "http://the-internet.herokuapp.com/tables"

  Benchmark.ips(10) do |x|
    LOCATORS.each do |example, data|
      data.each do |strategy, locator|
        # binding.pry
        x.report(example.to_s + " using " + strategy.to_s) { browser.find_element(strategy => locator) }
      end
    end
  end

  ensure
    browser.quit
end
