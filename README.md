# Selenium Benchmark 0.2.9 (1/21/2014)
A simple way to benchmark Selenium WebDriver across your various browsers

## Getting Started

1. `git clone https://github.com/tourdedave/selenium-benchmark.git`
2. `bundle install`
3. `rake server:init`
4. `rake server:start`
5. In another terminal, run your tests (see `rake -T` for a command listing)
6. After running the browsers you care about, type `rake report` to generate a benchmark data table

__NOTE: You will need to set up your local test machine with the various Selenium browser drivers in order to use all of the rake tasks.__
