Feature: User Edits Data File
  In order to update my data file
  As a tester at Lonely Planet
  I want to edit my data file

  Background:
    Given I am on the home page
    And I attach "test.txt" to "file"
    And I press "Import"

  Scenario: Happy Path
    When I click "Edit"
    Then I should see "Section"
    And I should see "Key"
    And I should see "Value"
    When I fill in "Section One" for "upload_sections_attributes_0_title"
    And I fill in "Key 12.5!!!" for "upload_sections_attributes_1_keys_attributes_1_title"
    And I fill in "Value 3" for "upload_sections_attributes_2_keys_attributes_0_values_attributes_0_content"
    And I press "Update"
    Then I should see "Section One"
    And I should see "Key 12.5!!!"
    And I should see "Value 3"
    And I should not see "header"
    And I should not see "correction text"
    And I should not see "all out of budget."
