Feature: User Uploads Data File
  In order to parse my data file
  As a tester at Lonely Planet
  I want to upload a my data file

  Scenario: User Views File Upload
    When I go to the home page
    Then I should see "Upload Your File"
    When I attach "test.txt" to "file"
    And I press "Import"
    Then I should see "File imported."