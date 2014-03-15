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