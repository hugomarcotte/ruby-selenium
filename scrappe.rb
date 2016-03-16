require 'rubygems'
require 'selenium-webdriver'
 
browser = Selenium::WebDriver.for :firefox
browser.get 'https://www.excellusbcbs.com/wps/portal/xl/mbr/fnd/doctor/upstateny/'
 
# Timeout = 15 sec
wait = Selenium::WebDriver::Wait.new(:timeout => 15)

#### Interact with the drop down box
select_list = wait.until {
    element = browser.find_element(:name, "healthPlan")
    element if element.displayed?
}
# select_list.clear

#### Extract all options from the select box
options=select_list.find_elements(:tag_name => "option")

#### Select the option
options.each do |g|
  if g.text == "Accountable Health Partners"
  g.click
  break
  end
end

# Click search button
link = wait.until {
    element = browser.find_element(:xpath, "//input[@src='/webcontent/images/buttons/search.gif']")
    element if element.displayed?
} 
link.click

# Find text on the page by regexp
# puts "Test Passed: Page 1 Validated" if wait.until {
#     /Testing Web Applications with Ruby and Selenium WebDriver/.match(browser.page_source)
# }
 
browser.quit