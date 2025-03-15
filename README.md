# worldcup-database
This project consists of some manual SQL commands to define the relations, and some bash scripting to help with the populating the database with data and then manipulating that data.
- The created database is composed of tables for world cup games and the teams that participated.
- The `insert.sh` file loops through the provided CSV file and stores all the unique teams in the teams database, creating team_id and name.
