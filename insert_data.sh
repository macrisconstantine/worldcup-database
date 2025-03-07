#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

TRUNCATE="$($PSQL "TRUNCATE games, teams")"
RESET="$($PSQL "ALTER SEQUENCE games_game_id_seq RESTART")"
RESET="$($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WINNER_GOALS OPP_GOALS

# Loop through and store unique team entries
do
  if [[ $YEAR != 'year' ]]
  then
    TEAM_SELECT_RESULT="$($PSQL "SELECT name FROM teams WHERE name ='$WINNER'")"
    if [[ -z $TEAM_SELECT_RESULT ]]
    then
      TEAM_INSERT_RESULT="$($PSQL "INSERT INTO teams(name) values('$WINNER')")"
    fi
    OPP_SELECT_RESULT="$($PSQL "SELECT name FROM teams WHERE name ='$OPP'")"
    if [[ -z $OPP_SELECT_RESULT ]]
    then
      OPP_INSERT_RESULT="$($PSQL "INSERT INTO teams(name) values('$OPP')")"
    fi
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WINNER_GOALS OPP_GOALS

do
  if [[ $YEAR != 'year' ]]
  then
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$WINNER'")"
    OPP_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$OPP'")"
    GAME_INSERT_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id,
    opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', 
    $WINNER_ID, $OPP_ID, $WINNER_GOALS, $OPP_GOALS)")"
  fi
done