require 'selenium-webdriver'

class Base

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def find(locator)
    driver.find_element locator
  end

  def load(url)
    driver.get ENV['base_url'] + url
  end

end
