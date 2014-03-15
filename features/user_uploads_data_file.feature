Feature: User Uploads Data File
  In order to parse my data file
  As a tester at Lonely Planet
  I want to upload my data file

  Background:
    Given I am on the home page

  Scenario: Happy Path
    Then I should see "Lonely Planet File Uploader"
    When I attach "test.txt" to "file"
    And I press "Import"
    Then I should see "Your Parsed File"
    And I should not see "Please add a file to import."
    And I should not see "Something went wrong. Please try again."

  Scenario: No File to Upload
    When I press "Import"
    Then I should see "Please add a file to upload."

  Scenario: Wrong File Type
    When I attach "test.jpg" to "file"
    And I press "Import"
    Then I should see "Please upload a .txt or .rtf file."

  Scenario: Wrong Text Format
    When I attach "blank.rtf" to "file"
    And I press "Import"
    Then I should see "Please upload a properly formatted text file."

