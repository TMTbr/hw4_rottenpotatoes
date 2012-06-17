Feature: create and destroy movies

  As a moviegoer
  So that I can maintain an update list of movies
  I want to be able to add and destroy movies

  Background: movies have been added to database

    Given the following movies exist:
      | title                   | rating | release_date |
      | Aladdin                 | G      | 25-Nov-1992  |

    And  I am on the RottenPotatoes home page

  Scenario: Add a new movie
    When I follow "Add new movie"
    And fill in "Title" with "My Movie"
    And select "G" from "Rating"
    And press "Save Changes"
    Then I should see "My Movie was successfully created."
