

World Cup Database



Part 1: Create the database
psql --username=freecodecamp --dbname=postgres

CREATE DATABASE worldcup;

\c worldcup



CREATE TABLE teams(
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE games(
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR(25) NOT NULL,
  winner_id INT NOT NULL,
  opponent_id INT NOT NULL,
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL,
  FOREIGN KEY (winner_id) REFERENCES teams(team_id),
  FOREIGN KEY (opponent_id) REFERENCES teams(team_id)
);



Part 2: Insert the data
chmod +x insert_data.sh
chmod +x queries.sh

—---- insert_data.sh —----
#! /bin/bash


if [[ $1 == "test" ]]
then
 PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
 PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi


#Do not change code above this line. Use the PSQL variable above to query your database.




#clear the database first
$PSQL "TRUNCATE games, teams;"




#Loop through the games.csv file; Assign comma separated data to variables: YEAR, ROUND, WINNER, OPPONENT, WINNER_GOALS & OPPONENT_GOALS
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS




do
 #If you are not reading the top line of the file, then:
 if [[ $YEAR != year ]]
   then
     #if WINNER has a team_id, assign the team_id to WINNER_ID
     WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
#if OPPONENT has a team_id, assign the team_id to OPPONENT_ID
     OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")




#if the WINNER does not have a team_id, then
if [[ -z $WINNER_ID ]]
then
#INSERT_TEAM_NAME
INSERT_MESSAGE=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")




if [[ $INSERT_MESSAGE == "INSERT 0 1" ]]
then
 (( count_teams++ ))
fi
#Get the new team_ID as WINNER_ID
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
     fi 




#if the OPPONENT does not have a team_id, then
if [[ -z $OPPONENT_ID ]]
then
#INSERT_TEAM_NAME
INSERT_MESSAGE=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")


#Get the new team_ID as OPPONENT_ID
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
fi
#populate the games table with the YEAR, ROUND, WINNNER_ID, OPPONENT_ID, WINNER_GOALS, OPPONENT_GOALS
INSERT_MESSAGE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")






fi




fi
done./insert_data.sh






Part 3: Query the database


#! /bin/bash


PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"


#Do not change code above this line. Use the PSQL variable above to query your database.
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games;")"




echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games;")"




echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"




echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(AVG(winner_goals),2) FROM games;")"




echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;")"




echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"




echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(winner_goals) FROM games WHERE winner_goals > 2;")"




echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games FULL JOIN teams ON games.winner_id = teams.team_id WHERE games.year = 2018 AND games.round = 'Final';")"




echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM games LEFT JOIN teams ON games.winner_id =teams.team_id WHERE year=2014 AND round='Eighth-Final' UNION SELECT name FROM games  LEFT JOIN teams ON games.opponent_id = teams.team_id WHERE year=2014 AND round='Eighth-Final' ORDER BY name;")"


echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM games LEFT JOIN teams ON games.winner_id = teams.team_id ORDER BY name;")"


echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM games FULL JOIN teams ON games.winner_id = teams.team_id WHERE games.round = 'Final' ORDER BY year")"


echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%';")"




Notes:
If you leave your virtual machine, your database may not be saved. You can make a dump of it by entering pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql in a bash terminal (not the psql one). It will save the commands to rebuild your database in worldcup.sql. The file will be located where the command was entered. If it's anything inside the project folder, the file will be saved in the VM. You can rebuild the database by entering psql -U postgres < worldcup.sql in a terminal where the .sql file is.
If you are saving your progress on freeCodeCamp.org, after getting all the tests to pass, follow the instructions above to save a dump of your database. Save the worldcup.sql file, as well as the final version of your insert_data.sh and queries.sh files, in a public repository and submit the URL to it on freeCodeCamp.org.

