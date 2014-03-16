@javascript
Feature: User Deletes Data File
  In order to destroy my data file
  As a tester at Lonely Planet
  I want to delete my data file

  Background:
    Given I am on the home page
    And I attach "test.txt" to "file"
    And I press "Import"

  Scenario: Happy Path
    When I click "Delete"
    And I confirm the dialogue
    Then I should not see "test.txt"