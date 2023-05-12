# Player selection

## IMPORTANT NOTE FOR REQUIREMENT MODIFICATION:
   
  * In order to follow the best practice on ROR we have a modification for API Description:
    * List Player: API URL should be GET http://localhost:3000/api/players
    * Create Player: API URL should be POST http://localhost:3000/api/players
    * Update Player: API URL should be PUT http://localhost:3000/api/players/[player_id]
    * Delete Player: API URL should be DELETE http://localhost:3000/api/players/[player_id]

  * Response should be in JSON format and [snake_case] 
  ```
  {
    "id": player_id,
    "name": "player name",
    "position": "midfielder",
    "player_skills": [
      {
        "id": "player_skill_id",
        "skill": "defense",
        "value": 60,
        "player_id": player_id
      },
      {
        "id": "player_skill_id",
        "skill": "speed",
        "value": 80,
        "player_id": player_id
      }
    ]
  }
  ```
  
  * Request should be also in JSON format and [snake_case]
  ```
  {
    "name": "player name",
    "position": "midfielder",
    "player_skills": [
      {
        "id": "player_skill_id",
        "skill": "defense",
        "value": 60,
        "player_id": player_id
      }
    ]
  }
  ```

  OR in team request API:
  ```
  [
    {
      "position": "midfielder",
      "main_skill": "speed",
      "number_of_players": 1
    },
    {
      "position": "defender",
        "main_skill": "strength",
        "number_of_players": 2
    }
  ]   
  ```
  
  * Files under `spec` directory provide example test cases. You should read them to figure out how to properly implement the solution and throw exceptions.

  * Other requirements should be the same a Challenge Details link (team url, rule,..)

  * Team Selection:
    * Same as challenge detail, in case of errors, the body should return the correct error message following this pattern (snake case for the invalid request parameter key):
        { "message": "Invalid value for [position/main_skill]: [invalid_request_value]" }
    
## Build the solution

This solution requires Ruby version: ruby-3.1.0 and SQLite 3 installed.

  * Configuration:
  `bundle` to install library in GEMFILE 

  * Database creation 
  ```shell
    rake db:create
  ```

  * Database initialization:
  ```shell
    rake db:migrate
    rake db:test:prepare
  ```

## Run solution locally
  * Start server
  ```shell
    rails server
  ```

  * Run the test suite:
  ```shell
    rspec spec
  ```
