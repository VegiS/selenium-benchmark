# Selenium Benchmark 0.2.11 (1/21/2014)
A simple way to benchmark Selenium WebDriver performance across various browsers

## Getting Started

__NOTE: You will need to set up your local test machine with the Selenium browser drivers in order to use all of the rake tasks (and the Selenium Standalone Server for Opera).__

1) `git clone https://github.com/tourdedave/selenium-benchmark.git`  
2) `bundle install`  
3) `rake server:init`  
4) `rake server:start`  
5) Open a new terminal window

`rake -T` to get a full list of commands  

```sh
terminal$ rake -T
rake benchmark:chrome[version]              # Chrome
rake benchmark:firefox[version]             # Firefox
rake benchmark:internet_explorer[version]   # IE
rake benchmark:opera[selenium_server_path]  # Opera (version 12.16)
rake report                                 # Generate report from benchmark data
rake server:init                            # Pull in the the-internet after initial checkout
rake server:start                           # Start the web server
```

6) Run your benchmarks against the browsers you want (one at a time)  

```sh
# The version number is important for reporting.
terminal$ rake benchmark:firefox['26']
terminal$ rake benchmark:internet_explorer['08']
terminal$ rake benchmark:internet_explorer['10']
terminal$ rake benchmark:chrome['32']
# Opera is the odd duck, requiring the full path to the Selenium standalone server
terminal$ rake benchmark:opera['C:\drivers\selenium-server-standalone-2.39.0.jar']
```

7) After running your benchmarks, type `rake report` to generate an aggregate data table  

![report output](https://raw2.github.com/tourdedave/selenium-benchmark/develop/benchmarks/output.png)
