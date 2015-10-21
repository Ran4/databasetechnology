INSERT INTO Sports VALUES ('Slalom Alpine Ski');
INSERT INTO Sports VALUES ('Ice Hockey');

INSERT INTO NationalTeams VALUES ('FIN', 'Slalom Alpine Ski', 'F');
INSERT INTO NationalTeams VALUES ('SWE', 'Slalom Alpine Ski', 'F');
INSERT INTO NationalTeams VALUES ('RUS', 'Slalom Alpine Ski', 'M');
INSERT INTO NationalTeams VALUES ('SWE', 'Ice Hockey', 'M');
INSERT INTO NationalTeams VALUES ('FIN', 'Ice Hockey', 'M');
INSERT INTO NationalTeams VALUES ('USA', 'Ice Hockey', 'M');
INSERT INTO NationalTeams VALUES ('CAN', 'Ice Hockey', 'M');
INSERT INTO NationalTeams VALUES ('RUS', 'Ice Hockey', 'M');
INSERT INTO NationalTeams VALUES ('RUS', 'Ice Hockey', 'F');

INSERT INTO Contestants VALUES ('Anja Persson', 'F', 'SWE', 'Slalom Alpine Ski');
INSERT INTO Contestants VALUES ('Ajna Nossrep', 'F', 'SWE', 'Slalom Alpine Ski');
INSERT INTO Contestants VALUES ('Gunde Andersson',    'M', 'SWE', 'Ice Hockey', 'Goalie');
INSERT INTO Contestants VALUES ('Janne Juvonen',      'M', 'FIN', 'Ice Hockey', NULL);
INSERT INTO Contestants VALUES ('Zach Parise',        'M', 'USA', 'Ice Hockey', NULL);
INSERT INTO Contestants VALUES ('Bobby Hull',         'M', 'CAN', 'Ice Hockey', NULL);
INSERT INTO Contestants VALUES ('Alexander Ovechkin', 'M', 'RUS', 'Ice Hockey', NULL);
INSERT INTO Contestants VALUES ('Viacheslav Fetisov', 'M', 'RUS', 'Ice Hockey', NULL);
INSERT INTO Contestants VALUES ('Evgeni Malkin',      'M', 'RUS', 'Ice Hockey', 'Left Wing');
INSERT INTO Contestants VALUES ('Ilya Bryzgalov',     'M', 'RUS', 'Ice Hockey', 'Right wing');
INSERT INTO Contestants VALUES ('Pavel Datsyuk',      'M', 'RUS', 'Ice Hockey', 'Defensemen');
INSERT INTO Contestants VALUES ('Evgeni Nabokov',     'M', 'RUS', 'Ice Hockey', 'Goalie');
--INSERT INTO Contestants VALUES ('Anja Persson', 'F', 'ARG', 'Slalom Alpine Ski'); --Not possible, same name
INSERT INTO Contestants VALUES ('Tanja Poutiainen', 'F', 'FIN', 'Slalom Alpine Ski');

INSERT INTO Venues VALUES ('Friends Arena', 'Main Venue');
INSERT INTO Venues VALUES ('Friends Arena', 'Secondary Venue');

INSERT INTO Events VALUES (DEFAULT, 'Slalom Alpine Ski', 'One-skii', 'F'); --event 1. Maybe

INSERT INTO Competitions VALUES (DEFAULT, 1, 'first competition', 7); --competitionID 1. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 'semi-final', 7); --competitionID 2. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 1, 'final', 7); --competitionID 3. Maybe
INSERT INTO CompetesIn VALUES ('Anja Persson', 1);
INSERT INTO CompetesIn VALUES ('Anja Persson', 2);
INSERT INTO CompetesIn VALUES ('Tanja Poutiainen', 1);
INSERT INTO Schedules VALUES ('2015-10-25', 'Friends Arena', 'Main Venue', 1);
--INSERT INTO Schedules VALUES ('2015-10-25', 'Friends Arena', 'Main Venue', 2); --this will lead to double-booking


INSERT INTO Sports VALUES ('Bobsleigh');
INSERT INTO NationalTeams VALUES ('SWE', 'Bobsleigh', 'N');
INSERT INTO NationalTeams VALUES ('CHK', 'Bobsleigh', 'N');
INSERT INTO Venues VALUES ('Lillehammer Olympic Bobsleigh and Luge Track', 'Bobsleigh Track Venue');
INSERT INTO Venues VALUES ('Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue');
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Four-person', 'N'); --event 2. Maybe
INSERT INTO Events VALUES (DEFAULT, 'Bobsleigh', 'Two-man', 'M'); --event 3. Maybe
INSERT INTO Competitions VALUES (DEFAULT, 2, 'final', 7); --competitionID 4. Maybe
INSERT INTO Schedules VALUES ('2015-10-25', 'Hammarbybacken Bobsleigh Track', 'Bobsleigh Track Venue', 4);
