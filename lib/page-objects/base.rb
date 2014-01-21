require 'selenium-webdriver'

class Base

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def find(locator)
    driver.find_element locator
  end

  def go_to(url)
    driver.get ENV['base_url'] + url
  end

  def is_displayed?(locator)
    find(locator).displayed?
  end

end
