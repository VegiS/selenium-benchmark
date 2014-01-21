require_relative 'base'
require 'benchmark'

class LargeDOM < Base

  LOCATORS = {
    sibling_traversal: {
      css: "div#siblings > div:nth-of-type(1) > div:nth-of-type(1) > div:nth-of-type(1)",
      xpath: "//div[contains(@id, 'siblings')]/div[1]/div[1]/div[1]"
    }#,
#    sibling_traversal_by_class: {
#      css: "div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1 > div.item-1",
#      xpath: "//div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]/div[contains(@class, 'item-1')]"
#    }
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
              puts error
            end
          end
        end
      end
    end
  end

end
