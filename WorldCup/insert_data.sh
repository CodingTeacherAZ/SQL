#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


# clear the database first 
$PSQL "TRUNCATE games, teams;"


count_teams=0
count_games=0


# Loop through the games.csv file; Assign comma separated data to variables: YEAR, ROUND, WINNER, OPPONENT, WINNER_GOALS & OPPONENT_GOALS
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS


do
  #If you are not reading the top line of the file, then: 
  if [[ $YEAR != year ]]
    then
      #if WINNER has a team_id, assign the team_id to WINNER_ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
# if OPPONENT has a team_id, assign the team_id to OPPONENT_ID
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")


 #if the WINNER does not have a team_id, then
if [[ -z $WINNER_ID ]]
then
# INSERT_TEAM_NAME
INSERT_MESSAGE=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")


if [[ $INSERT_MESSAGE == "INSERT 0 1" ]]
then 
  (( count_teams++ ))
fi
# Get the new team_ID as WINNER_ID
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      fi  


# if the OPPONENT does not have a team_id, then
if [[ -z $OPPONENT_ID ]]
then 
# INSERT_TEAM_NAME
INSERT_MESSAGE=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")


if [[ $INSERT_MESSAGE == "INSERT 0 1" ]]
then 
  (( count_teams++ ))
fi


# Get the new team_ID as OPPONENT_ID
       OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
fi
# populate the games table with the YEAR, ROUND, WINNNER_ID, OPPONENT_ID, WINNER_GOALS, OPPONENT_GOALS
INSERT_MESSAGE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")


if [[ $INSERT_MESSAGE == "INSERT 0 1" ]]
then  
  (( count_games++ ))
fi


fi
done


echo Teams : $count_teams
echo Games : $count_games
 
