require_relative 'base'
require 'benchmark'

class SmallDOM < Base

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

  attr_reader :driver

  def initialize(driver)
    @driver = driver
    go_to '/tables'
    super
  end

  # The benchmarking approach was borrowed from
  # http://rubylearning.com/blog/2013/06/19/how-do-i-benchmark-ruby-code/
  def benchmark
    Benchmark.bmbm(27) do |bm|
      LOCATORS.each do |example, data|
        data.each do |strategy, locator|
          bm.report(example.to_s + " using " + strategy.to_s) do
            begin
              ENV['iterations'].to_i.times do
                 find(strategy => locator)
              end
            rescue Selenium::WebDriver::Error::NoSuchElementError
              puts "( 0.0 )"
            end
          end
        end
      end
    end
  end

end
