When(/^I click on "(.*?)"$/) do |link|
  click_link link
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content content
end

Then /^I should not see "([^"]*)"$/ do |content|
  page.should have_no_content(content)
end

When /^I (?:click|press) "([^"]*)"$/ do |selector|
  click_link_or_button(selector)
end

When(/^I attach "(.*?)" to "(.*?)"$/) do |file, target|
  path = File.join(::Rails.root, 'features', 'support', 'files', file)
  attach_file(target, path)
end

Then(/^I should see the file input "(.*?)"$/) do |field_id|
  page.should have_css("input[type='file'][id='#{field_id}']")
end