require_relative 'base'
require 'benchmark'

class LargeDOM < Base

  LOCATORS = {
    nested_sibling_traversal: {
      css: "div#siblings > div:nth-of-type(1) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3) > div:nth-of-type(3)",
      xpath: "//div[@id='siblings']/div[1]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]/div[3]"
    },
    nested_sibling_traversal_by_class: {
      css: "div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1",
      xpath: "//div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]"
    },
    table_header_id_and_class: {
      css: "table#large-table thead .column-50",
      xpath: "//table[@id='large-table']//thead//*[@class='column-50']"
    },
    table_header_id_class_and_direct_desc: {
      css: "table#large-table > thead .column-50",
      xpath: "//table[@id='large-table']/thead//*[@class='column-50']"
    },
    table_header_traversing: {
      css: "table#large-table thead tr th:nth-of-type(50)",
      xpath: "//table[@id='large-table']//thead//tr//th[50]"
    },
    table_header_traversing_and_direct_desc: {
      css: "table#large-table > thead > tr > th:nth-of-type(50)",
      xpath: "//table[@id='large-table']/thead/tr/th[50]"
    },
    table_cell_id_and_class: {
      css: "table#large-table tbody .column-50",
      xpath: "//table[@id='large-table']//tbody//*[@class='column-50']"
    },
    table_cell_id_class_and_direct_desc: {
      css: "table#large-table > tbody .column-50",
      xpath: "//table[@id='large-table']/tbody//*[@class='column-50']"
    },
    table_cell_traversing: {
      css: "table#large-table tbody tr td:nth-of-type(50)",
      xpath: "//table[@id='large-table']//tbody//tr//td[50]"
    },
    table_cell_traversing_and_direct_desc: {
      css: "table#large-table > tbody > tr > td:nth-of-type(50)",
      xpath: "//table[@id='large-table']/tbody/tr/td[50]"
    }
  }

  attr_reader :driver

  def initialize(driver)
    @driver = driver
    go_to '/large'
    is_displayed?(id: 'siblings')
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
              ENV['iterations'].to_i.times do |count|
                 find(strategy => locator)
              end
            rescue Selenium::WebDriver::Error::NoSuchElementError => error
              puts "( 0.0 )"
            end
          end
        end
      end
    end
  end

end
