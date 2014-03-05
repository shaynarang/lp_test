Feature: User Uploads Data File
  In order to parse my data file
  As a tester at Lonely Planet
  I want to upload my data file

  Background:
  	Given I am on the home page

  Scenario: Happy Path
    Then I should see "Upload Your File"
    When I attach "test.txt" to "file"
    And I press "Import"
    Then I should see "File imported."

  Scenario: No File to Upload
  	When I press "Import"
  	Then I should see "Please add a file to import."

