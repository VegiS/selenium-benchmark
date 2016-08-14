require 'selenium-webdriver'

class Base

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def visit(url)
    if url.start_with? 'http'
      driver.get url
    else
      driver.get ENV['base_url'] + url
    end
  end

  def find(locator)
    driver.find_element locator
  end

  def is_displayed?(locator)
    find(locator).displayed?
  end

end
