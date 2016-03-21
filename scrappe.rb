require 'rubygems'
require 'selenium-webdriver'
require 'pry'
require 'csv'
 
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

# Parse results and write to CSV
result_table = browser.find_elements(:css, "table#providerResults>tbody>tr.odd,table#providerResults>tbody>tr.even")
CSV.open("accountable_health_partners.csv", "w") do |csv|
	result_table.each do |row|
		columns = row.find_elements(:css, "td.textResultsData")
		csv << [columns[0].text, columns[1].text]
	end
end

browser.quit