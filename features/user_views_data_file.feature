Feature: User Views Data File
  In order to view my parsed file
  As a tester at Lonely Planet
  I want to see my data file

  Background:
    Given I am on the home page
    And I attach "test.txt" to "file"
    And I press "Import"

    Scenario: Happy path
    Then I should see "header"
    And I should see "project"
    And I should see "4.5"
    And I should see "meta data"
    And I should see "correction text"
    And I should see "I meant 'moderately,' not 'tediously,' above."
    And I should see "trailer"
    And I should see "budget"
    And I should see "all out of budget."
    When I click "View All Uploads"
    Then I should see "test"