Database and Table Creation

CREATE DATABASE universe;

\c universe

Galaxy Table:
	•	galaxy_id (Primary Key, INT, Auto Increment)
	•	name (VARCHAR, UNIQUE, Not NULL)
	•	type (VARCHAR, Not NULL)
	•	size (NUMERIC)
	•	is_active (BOOLEAN, Not NULL)

CREATE TABLE galaxy(
galaxy_id SERIAL PRIMARY KEY, 
name VARCHAR(30) UNIQUE NOT NULL,
type VARCHAR(30) NOT NULL,
size NUMERIC,
is_active BOOLEAN NOT NULL);

 
Star Table:
	•	star_id (Primary Key, INT, Auto Increment)
	•	name (VARCHAR, UNIQUE, Not NULL)
	•	galaxy_id (Foreign Key referencing galaxy.galaxy_id, INT, Not NULL)
	•	luminosity (NUMERIC)
	•	is_visited (BOOLEAN, Not NULL)
	•	distance_from_Arrakis (INT, Not NULL)

CREATE TABLE star(
star_id SERIAL PRIMARY KEY,
name VARCHAR(30) UNIQUE NOT NULL,
galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
luminosity NUMERIC, 
is_visited BOOLEAN NOT NULL,
distance_from_earth INT NOT NULL);

Planet Table:
	•	planet_id (Primary Key, INT, Auto Increment)
	•	name (VARCHAR, UNIQUE, Not NULL)
	•	star_id (Foreign Key referencing star.star_id, INT, Not NULL)
	•	radius (NUMERIC)
	•	temperature (INT)
planet_type (VARCHAR, e.g., 'gas giant', 'rocky', 'greenbelt', etc.)
has_moons (BOOLEAN, Not NULL) - This column could help define if the planet has any moons (enabling you to omit moons from planets without any).

CREATE TABLE planet (
planet_id SERIAL PRIMARY KEY,
name VARCHAR(30) UNIQUE NOT NULL,
radius NUMERIC,
star_id INT NOT NULL REFERENCES star(star_id),
planet_type VARCHAR(15),
has_moons BOOLEAN NOT NULL
);

Moon Table:
	•	moon_id (Primary Key, INT, Auto Increment)
	•	name (VARCHAR, UNIQUE, Not NULL)
	•	planet_id (Foreign Key referencing planet.planet_id, INT, Not NULL)
	•	diameter (NUMERIC)
	•	has_water (BOOLEAN, Not NULL)
has_atmosphere (BOOLEAN, Not NULL)

CREATE TABLE moon();

ALTER TABLE moon 
ADD COLUMN moon_id SERIAL PRIMARY KEY,
ADD COLUMN name VARCHAR(30) UNIQUE NOT NULL,
ADD COLUMN planet_id INT NOT NULL REFERENCES planet(planet_id),
ADD COLUMN diameter NUMERIC,
ADD COLUMN has_water BOOLEAN NOT NULL,
ADD COLUMN has_atmosphere BOOLEAN NOT NULL;




Blackhole Table (Extra Table for Bonus):
blackhole_id (Primary Key, INT, Auto Increment)
name (VARCHAR, UNIQUE, Not NULL)
galaxy_id (Foreign Key referencing galaxy.galaxy_id, INT)
mass (NUMERIC)
event_horizon_radius (NUMERIC)
is_active (BOOLEAN)

CREATE TABLE blackhole();

ALTER TABLE blackhole
ADD COLUMN blackhole_id SERIAL PRIMARY KEY,
ADD COLUMN name VARCHAR(25) UNIQUE NOT NULL,
ADD COLUMN galaxy_id INT NOT NULL,
ADD COLUMN mass INT,
ADD COLUMN event_horizon_radius NUMERIC,
ADD COLUMN is_active BOOLEAN;




Galaxy Table: At least 6 rows

INSERT INTO galaxy(name, type, size, is_active)
VALUES
('Milky Way', 'Barred Spiral', 150000, FALSE),
('Andromeda', 'Spiral', 220000, FALSE),
('Sombrero', 'Spiral', 50000, FALSE),
('Triangulum', 'Spiral', 60000, FALSE),
('Whirlpool', 'Spiral', 76000, TRUE),
('Large Magellanic Cloud', 'Dwarf Irregular', 14000, TRUE)



Star Table: At least 6 rows
INSERT INTO star (name, galaxy_id, luminosity, is_visited, distance_from_earth)
VALUES 
('Sun', 1, 1.0, TRUE, 0),
('Alpha Centauri', 1, 1.519, FALSE, 4.37),
('Betelgeuse', 1, 120000, FALSE, 642.5),
('Cygnus Nova', 2, 2500, FALSE, 2500000),
('Andromeda Prime', 3, 5000, FALSE, 2550000),
('Triangulum Alpha', 3, 8000, TRUE, 3000000);

Planet Table: At least 12 rows
INSERT INTO planet(name, star_id, radius, temperature, planet_type, has_moons)
VALUES
('Earth', 1, 6378, 288, 'Greenbelt', TRUE),
('Arrakis', 3, 5000, 310, 'Sand', TRUE),
('Caladan', 5, 6500, 290, 'Oceanic', TRUE),
('Giedi Prime', 6, 4500, 350,'Rocky', FALSE),
('Lankiveil', 4, 6000, 340, 'Gaseous', TRUE),
('Salusa Secundus', 3, 5500, 330, 'Rocky', FALSE),
('Bela Tegeuse', 2, 7200, 420, 'Gaseous', TRUE),
('Richese', 3, 5200, 310, 'Rocky', TRUE),
('Ix' , 6, 6800, 320, 'Greenbelt', TRUE),
('Tleilax' , 4, 5500, 340, 'Rocky', FALSE),
('Chusuk', 5, 5900, 280,'Rocky', TRUE),
('Corrin' ,3, 6000, 325, 'Oceanic', TRUE),
('Poritrin', 2, 6400, 420, 'Gaseous', FALSE);

Moon Table: At least 20 rows
INSERT INTO moon(name, planet_id, diameter, has_water, has_atmosphere)
VALUES 
('Luna', 1, 3475, TRUE, FALSE),
('Europa', 8, 3122, TRUE, FALSE),
('Io', 9, 3643, FALSE, TRUE),
('Ganymede', 7, 5268, TRUE, TRUE),
('Callisto', 7, 4822, TRUE, FALSE),
('Titan', 11, 5152, TRUE, TRUE),
('Rhea', 5, 1528, TRUE, FALSE),
('Enceladus', 3, 504, TRUE, FALSE),
('Mimas', 12, 396, TRUE, FALSE),
('Triton', 5, 2710, TRUE, TRUE),
('Charon', 11, 1212, TRUE, FALSE), 
('Phobos', 9, 22, FALSE, FALSE),
('Deimos', 2, 12, FALSE,FALSE),
('Miranda', 12, 472, TRUE, FALSE),
('Ariel', 5, 1159, TRUE, FALSE),
('Umbriel', 7, 1169, TRUE, FALSE),
('Titania', 12, 1579, TRUE, FALSE),
('Oberon', 2, 1523, TRUE, FALSE),
('Iepetus', 11, 1472, TRUE, FALSE),
('Ceres', 7, 940, TRUE, FALSE);


Black hole table
INSERT INTO blackhole(name, galaxy_id, mass, event_horizon_radius, is_active)
VALUES
('Sagittarius A*', 1, 4000000, 12000000, TRUE), 
('Cygnus X-1', 1, 15000000, 45000000000, 	TRUE), 
('GRO J1655-40', 1,7000000, 21000000000,TRUE), 
('LMC X-3', 6,10000000, 30000000000,	TRUE), 
('M87*', 2,  1000000000, 3000000000,TRUE), 
('M51*'	, 5, 30000000,	90000000, TRUE);



 Planet_Moon Table (for Many:Many Relationship)
CREATE TABLE planet_moon();

ALTER TABLE planet_moon
ADD COLUMN planet_moon_id SERIAL PRIMARY KEY,
ADD COLUMN name VARCHAR(30),
ADD COLUMN planet_id INT NOT NULL REFERENCES planet(planet_id),
ADD COLUMN moon_id INT NOT NULL REFERENCES moon(moon_id),
ADD COLUMN moon_name TEXT UNIQUE;

Planet Moon table populate
planet_id (Foreign Key referencing planet.planet_id, INT)
moon_id (Foreign Key referencing moon.moon_id, INT)


INSERT INTO planet_moon (name, planet_id, moon_id, moon_name) 
VALUES 
('Earth',1,1, 'Eluna'),
('Arrakis', 2, 14, 'Aphobos'),
('Arrakis', 2, 19,'Atitania'),
('Caladan' , 3, 8, 'Cenceladus'), 
('Lankiveil', 5, 7,'Larhea' ), 
('Lankiveil', 5, 12, 'Latriton'),
('Lankiveil', 5, 16, 'Lamiranda'),
('Bela Tegeuse', 7, 4, 'Beteganymede'), 
('Bela Tegeuse', 7, 5, 'Betecallisto'), 
('Bela Tegeuse', 7, 18, 'Betumbriel'), 
('Bela Tegeuse', 7, 21,'Betiepetus'),
('Richese',8, 2, 'Reuropa'),
('Richese',9, 3, 'Rio'),
('Richese',9, 13, 'Richaron'),
('Chusuk', 11, 6, 'Chutitan'), 
('Chusuk', 11, 22, 'Chuceres'), 
('Chusuk', 11, 20, 'Choberon'),
('Corrin', 12, 9, 'Comimas'), 
('Corrin', 12,15, 'Codeimos'),
('Corrin', 12, 17, 'Cariel');




CREATE TABLE blackhole_galaxy(
blackhole_galaxy SERIAL PRIMARY KEY,
ADD COLUMN 
name VARCHAR(30) UNIQUE
blackhole_id INT NOT NULL REFERENCES blackhole(blackhole_id), 
galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),

INSERT INTO blackhole_galaxy 
VALUES
('Cygnus X-1',1, 1),
('GRO J1655-40', 2, 1),
('LMC X-3', 3, 1),
('M87*',4, 6),
('M51*'	,5,2 ),
('M87*', 6, 5);



