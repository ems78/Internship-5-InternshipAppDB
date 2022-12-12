CREATE TABLE Towns (
	TownID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Genders (
	GenderID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

ALTER TABLE Genders	
	ADD COLUMN Abbreviation VARCHAR(1) NOT NULL UNIQUE;

CREATE TABLE InternshipStatuses (
	StatusID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

ALTER TABLE InternshipStatuses
	ADD CONSTRAINT Name CHECK(Name in ('prep phase', 'ongoing', 'finished'));

CREATE TABLE Members (
	MemberID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Surname VARCHAR(30) NOT NULL,
	OIB VARCHAR(11) UNIQUE CHECK(LENGTH(OIB) = 11),
	BirthDate TIMESTAMP,
	GenderID INT REFERENCES Genders(GenderID),
	TownID INT REFERENCES Towns(TownID)
);

CREATE TABLE Internships (
	InternshipID SERIAL PRIMARY KEY,
	PlannedStart TIMESTAMP NOT NULL,
	PlannedEnd TIMESTAMP,
	StatusID INT REFERENCES InternshipStatuses(StatusID),
	LeaderID INT REFERENCES Members(MemberID)
);

CREATE TABLE Fields (
	FieldID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE InternshipFields (
	InternshipFieldID SERIAL PRIMARY KEY,
	InternshipID INT REFERENCES Internships(InternshipID),
	FieldID INT REFERENCES Fields(FieldID),
	LeaderID INT REFERENCES Members(MemberID)
);

CREATE TABLE MemberFields (
	MemberID INT REFERENCES Members(MemberID),
	FieldID INT REFERENCES Fields(FieldID),
	PRIMARY KEY(MemberID, FieldID)
);

CREATE TABLE Interns (
	InternID SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Surname VARCHAR(30) NOT NULL,
	OIB VARCHAR(11) UNIQUE CHECK(LENGTH(OIB) = 11),
	BirthDate TIMESTAMP NOT NULL,
	GenderID INT REFERENCES Genders(GenderID),
	TownID INT REFERENCES Towns(TownID)
);

ALTER TABLE Interns
	ADD CONSTRAINT BirthDate CHECK(date_part('year',AGE(BirthDate)) BETWEEN 16 and 24);

CREATE TABLE InternStatuses (
	StatusID SERIAL PRIMARY KEY,
	Meaning varchar(30) NOT NULL UNIQUE
);

/*
ALTER TABLE InternStatuses
	ADD CONSTRAINT Meaning CHECK(Meaning in ('Currnet intern', 'Kicked out', 'Completed internship'));
*/

CREATE TABLE InternFields (
	InternFieldID SERIAL PRIMARY KEY,
	InternID INT REFERENCES Interns(InternID),
	InternshipFieldID INT REFERENCES InternshipFields(InternshipFieldID),
	StatusID INT REFERENCES InternStatuses(StatusID)
);

ALTER TABLE InternFields
	ADD CONSTRAINT UniqueStudentPerField UNIQUE (InternID, InternshipFieldID);

CREATE TABLE Marks (
	MarkID SERIAL PRIMARY KEY,
	Label INT CHECK(Label BETWEEN 1 AND 5)
);

CREATE TABLE InternMarks (
	InternMarkID SERIAL PRIMARY KEY,
	InternFieldID INT REFERENCES InternFields(InternFieldID),
	MarkID INT REFERENCES Marks(MarkID),
	CorrectorID INT REFERENCES Members(MemberID)
);






--------------------
/* data insertion */
--------------------


INSERT INTO Genders(Name, Abbreviation) VALUES
	('Male', 'M'),
	('Female', 'F');
	
INSERT INTO Towns(Name) VALUES
	('Split'),
	('Trogir'),
	('Solin'),
	('Zagreb'),
	('Karlovac'),
	('Dubrovnik'),
	('Sisak'),
	('Makarska');
	
SELECT * FROM Towns
	
INSERT INTO Members(Name, Surname, OIB, BirthDate, GenderID, TownID) VALUES
	('Muffin', 'Sulter', 16995253004, '1995-09-17', 1, 1),
	('Alick', 'Brito', 47705828367, '2000-09-16', 1, 2),
	('Norton', 'Caldera', 45857081446, '2003-02-24', 1, 3),
	('Ashlee', 'Bowness', 55298201150, '2002-10-29', 2, 7),
	('Timmie', 'Wodeland', 48164961228, '1999-03-28', 1, 6),
	('Jo-anne', 'Saunderson', 93606008166, '1998-02-04', 2, 4),
	('Elspeth', 'Alman', 37056703571, '1997-06-18', 1, 4),
	('Marco', 'Heigho', 60290281512, '2000-12-03', 1, 4),
	('Jake', 'Ducker', 12094108998, '1998-12-04', 1, 3),
	('Vanni', 'Bullivent', 24910631845, '2001-07-20', 2, 4),
	('Hunter', 'Wastell', 19859945718, '2002-07-11', 2, 3),
	('Kial', 'Santos', 20355722858, '1993-04-13', 1, 6),
	('Nollie', 'Treffry', 83559444473, '1999-10-30', 1, 2),
	('Leona', 'Henden', 34549945447, '2000-12-20', 2, 6),
	('Carlye', 'Muncie', 32057055009, '2001-04-29', 2, 8),
	('Benoit', 'Chanders', 31818202000, '1995-03-16', 1, 7),
	('Irina', 'Woolsey', 52369962134, '1995-03-30', 2, 4),
	('Maynord', 'Brunet', 82901789897, '1994-08-14', 1, 7),
	('Romonda', 'Travers', 42291317433, '2002-02-07', 2, 3),
	('Cymbre', 'Bredbury', 57059697137, '1995-04-27', 1, 2),
	('Kaitlyn', 'Linnard', 51866196812, '2002-10-16', 2, 7),
	('Janet', 'Ledes', 29178358578, '2002-10-22', 2, 8),
	('Derron', 'Gourdon', 19359946677, '1996-08-07', 1, 6),
	('Brigit', 'Spleving', 14442855341, '2001-06-13', 2, 7),
	('Ashlen', 'Sacher', 71068730309, '1998-03-22', 2, 3),
	('Forbes', 'Shorten', 26821780228, '1998-09-09', 1, 2),
	('Abra', 'Clute', 52251679132, '2001-12-01', 1, 8),
	('Lisetta', 'Burness', 81316230264, '1997-02-11', 2, 7),
	('Hyman', 'Molfino', 81560911630, '2000-03-23', 1, 4),
	('Roberta', 'Longega', 26423135485, '1999-07-16', 2, 1),
	('Eldridge', 'Lawee', 94677388955, '2000-06-09', 1, 4),
	('Ker', 'Earwicker', 46661221331, '1998-02-11', 1, 4),
	('Aubert', 'Bowler', 73635882389, '1997-04-11', 1, 1),
	('Andree', 'Catcheside', 76067603375, '1998-02-10', 1, 6),
	('Kittie', 'Lilleyman', 73383555640, '1994-08-15', 2, 1)

SELECT * FROM Members

INSERT INTO InternshipStatuses(Name) VALUES
	('prep phase'),
	('ongoing'),
	('finished');
	
SELECT * FROM InternshipStatuses

INSERT INTO Internships(PlannedStart, PlannedEnd, StatusID, LeaderID) VALUES
	('2018-11-2', '2019-4-2', 3, 2),
	('2019-11-15', '2020-4-12', 3, 12),
	('2020-11-10', '2021-4-10', 3, 8),
	('2021-11-7', '2022-4-20', 3, 7),
	('2023-11-11', '2024-4-11', 1, 5),
	('2022-11-05', '2023-04-15', 2, 17);
	
	
INSERT INTO Fields(Name) VALUES
	('programiranje'),
	('multimedija'),
	('dizajn'),
	('marketing')

SELECT * FROM Fields

SELECT * FROM Members
	
insert into MemberFields (MemberID, FieldID) values (1, 1);
insert into MemberFields (MemberID, FieldID) values (2, 2);
insert into MemberFields (MemberID, FieldID) values (3, 4);
insert into MemberFields (MemberID, FieldID) values (4, 3);
insert into MemberFields (MemberID, FieldID) values (5, 1);
insert into MemberFields (MemberID, FieldID) values (6, 2);
insert into MemberFields (MemberID, FieldID) values (7, 4);
insert into MemberFields (MemberID, FieldID) values (8, 3);
insert into MemberFields (MemberID, FieldID) values (9, 1);
insert into MemberFields (MemberID, FieldID) values (10, 2);
insert into MemberFields (MemberID, FieldID) values (11, 3);
insert into MemberFields (MemberID, FieldID) values (12, 4);
insert into MemberFields (MemberID, FieldID) values (13, 1);
insert into MemberFields (MemberID, FieldID) values (14, 2);
insert into MemberFields (MemberID, FieldID) values (15, 3);
insert into MemberFields (MemberID, FieldID) values (16, 4);
insert into MemberFields (MemberID, FieldID) values (17, 1);
insert into MemberFields (MemberID, FieldID) values (18, 2);
insert into MemberFields (MemberID, FieldID) values (19, 3);
insert into MemberFields (MemberID, FieldID) values (20, 4);
insert into MemberFields (MemberID, FieldID) values (21, 1);
insert into MemberFields (MemberID, FieldID) values (22, 2);
insert into MemberFields (MemberID, FieldID) values (23, 3);
insert into MemberFields (MemberID, FieldID) values (24, 4);
insert into MemberFields (MemberID, FieldID) values (25, 1);
insert into MemberFields (MemberID, FieldID) values (26, 2);
insert into MemberFields (MemberID, FieldID) values (27, 3);
insert into MemberFields (MemberID, FieldID) values (28, 4);
insert into MemberFields (MemberID, FieldID) values (29, 1);
insert into MemberFields (MemberID, FieldID) values (30, 2);
insert into MemberFields (MemberID, FieldID) values (31, 3);
insert into MemberFields (MemberID, FieldID) values (32, 4);
insert into MemberFields (MemberID, FieldID) values (33, 1);
insert into MemberFields (MemberID, FieldID) values (34, 2);
insert into MemberFields (MemberID, FieldID) values (35, 3);
insert into MemberFields (MemberID, FieldID) values (11, 1);
insert into MemberFields (MemberID, FieldID) values (17, 4);


INSERT INTO InternStatuses(Meaning) VALUES
	('current intern'),
	('kicked out'),
	('completed internship');
	
INSERT INTO Marks(Label) VALUES
	(1),
	(2),
	(3),
	(4),
	(5);
	
INSERT INTO Interns(Name, Surname, OIB, BirthDate, GenderID, TownID) VALUES
('Munroe', 'Kiffe', 97575078540, '1999-12-26', 1, 2),
('Anthony', 'Reeken', 99179017433, '1999-03-04', 1, 5),
('Floris', 'McCully', 28652117988, '2002-08-06', 1, 2),
('Thomasine', 'Boyall', 70792557980, '2001-11-02', 1, 2),
('Abbey', 'Moralee', 10360906114, '2004-08-25', 2, 3),
('Monah', 'Scourge', 12309043245, '2006-09-05', 2, 2),
('Terencio', 'Tabart', 32848566718, '2005-03-29', 1, 3),
('Winfred', 'Ephgrave', 98909974092, '2005-07-25', 1, 1),
('Georas', 'Learmount', 37763010520, '2002-11-19', 1, 2),
('Eleni', 'Pruckner', 93192786329, '1999-06-15', 2, 2),
('Ermengarde', 'Fitzsymonds', 59719558481, '2006-09-24', 2, 1),
('Edeline', 'Pykerman', 45689519452, '2003-11-18', 2, 1),
('Meg', 'Ausiello', 49003295459, '1999-11-03', 2, 1),
('Vlad', 'Choulerton', 75780375294, '2001-05-27', 1, 2),
('Tulley', 'Lente', 91731745910, '2003-03-14', 1, 3),   
('Corabella', 'Rolfe', 11897739350, '2003-03-07', 2, 6),
('Libbey', 'Reid', 59290798378, '2005-09-09', 2, 5),
('Jordan', 'Bunney', 58591076052, '2005-03-06', 1, 4),  
('Virgilio', 'Maunders', 50091719251, '2004-08-14', 1, 6),
('Gizela', 'Caillou', 45453626861, '2000-05-04', 2, 4),
('Silvester', 'Marchington', 47931308440, '2002-12-15', 1, 2),
('Margareta', 'Colebourn', 64224280414, '2006-04-07', 2, 1),
('Cristabel', 'Ellgood', 90068340679, '2005-10-29', 2, 5),
('Montgomery', 'Matyukon', 35721928972, '1998-12-21', 1, 2),
('Perla', 'Ficken', 22576256781, '2004-12-06', 2, 5),
('Dukey', 'Welbeck', 31091247593, '2005-03-21', 1, 5),
('Carolann', 'Bryer', 38830457390, '2006-02-28', 1, 2),
('Odette', 'Forster', 38142262128, '2005-01-15', 2, 5),
('Gav', 'Hamberston', 23361115735, '2005-03-17', 1, 2),
('Vassily', 'Battle', 98527077331, '2006-10-25', 1, 7),
('Pier', 'Barbie', 49113780959, '1999-11-05', 1, 2),
('Hardy', 'Farrall', 92209508130, '2002-09-03', 1, 1),
('Lawrence', 'Flag', 35972323864, '2000-06-12', 1, 4),
('Karoly', 'Roomes', 19487391158, '2006-03-04', 1, 1),
('Bathsheba', 'Rosenbusch', 81664131895, '2002-10-05', 2, 2),
('Patrizio', 'Narramore', 49940728120, '2000-11-12', 1, 1),
('Sheila-kathryn', 'Bevan', 12147006078, '2005-04-24', 2, 5),
('Mathilde', 'Gussin', 82021770243, '2005-11-02', 2, 2),
('Reynold', 'Sainsbury', 25706249282, '2006-12-08', 1, 2),
('Cristionna', 'Trustram', 63262261889, '2001-08-10', 2, 3),
('Worthington', 'Manicom', 32142088483, '2003-01-24', 1, 1),
('Sax', 'Biasioli', 27392671335, '1999-11-25', 1, 2),
('Abby', 'Lambshine', 73375822625, '2004-05-14', 2, 3),
('Giordano', 'Ranking', 48475907568, '2006-02-25', 1, 7),
('Cassey', 'Fowler', 68286502779, '2000-02-25', 2, 6),
('Jarred', 'Timby', 71347400149, '2001-07-27', 1, 3),
('Marrissa', 'Dorkin', 38575231075, '2004-07-17', 2, 1),
('Lexis', 'Van der Beken', 93067383072, '2006-04-11', 1, 8),
('Raine', 'Eseler', 58065939881, '2006-05-05', 1, 2),
('Jayme', 'McCloch', 57847450172, '2006-07-21', 1, 4),
('Heidi', 'Jendas', 20818695294, '2004-12-11', 2, 4),
('Haleigh', 'Gladding', 88105966794, '2001-09-27', 2, 2),
('Gretta', 'Lewzey', 60583064143, '2004-07-08', 2, 1),
('Marnie', 'Fearneley', 63622087955, '2006-10-04', 2, 1),
('Roland', 'Goede', 70989980243, '1999-05-21', 1, 4),
('Dimitry', 'Burgisi', 85725911306, '2004-10-02', 1, 1),
('Shina', 'Caspell', 64587609835, '2004-03-26', 2, 6),
('Madalena', 'Harg', 84896873471, '1999-12-01', 2, 6),
('Latrina', 'Whitebread', 77207639861, '1999-06-26', 2, 2),
('Dalia', 'Ableson', 98932174362, '2005-09-17', 2, 3),
('Antony', 'Caldaro', 39699097590, '2000-08-19', 1, 7),
('Gus', 'Canadine', 31631382146, '1999-06-10', 1, 2),
('Klara', 'Batting', 67617939394, '2006-04-07', 2, 3),
('Bobine', 'Filby', 48255257261, '2004-06-27', 1, 2),
('Marge', 'Nerney', 48803146105, '2003-08-06', 2, 8),
('Benjy', 'Phibb', 60230612875, '2003-04-17', 1, 4),
('Mathilde', 'Gatherer', 35020208945, '2002-11-08', 2, 5),
('Tammara', 'Sarra', 49773593315, '2003-10-05', 2, 4),
('Amber', 'Beatens', 18719998681, '2001-06-09', 2, 1),
('Dermot', 'Bytheway', 36088372769, '2005-09-11', 1, 7);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Jewel', 'Bougen', 47999263275, '2001-11-18', 1, 7);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Bronny', 'Emmerson', 70888668581, '1999-02-11', 1, 1);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Shannah', 'Coyish', 77593355791, '2001-09-19', 2, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Roselle', 'Scutt', 18658871004, '2001-07-20', 2, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Daffi', 'Demkowicz', 44714829538, '2001-06-07', 2, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Patric', 'Willshire', 29655561143, '2002-10-10', 1, 6);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Lory', 'Stops', 54187202453, '2004-06-29', 2, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Bernetta', 'Gounard', 65746770007, '2004-03-28', 2, 7);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Emlyn', 'Harroll', 78312616107, '2000-12-18', 2, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Billi', 'Benezet', 90584002491, '2002-01-13', 1, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Artie', 'Rockhill', 69102991520, '2001-07-19', 1, 6);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Ramon', 'Cripwell', 86100392577, '2002-03-08', 1, 5);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Chelsae', 'Gerhartz', 69507376698, '2003-11-19', 2, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Waly', 'Ogglebie', 19762764350, '2004-12-04', 2, 8);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Lurline', 'Levy', 21818280433, '2002-02-17', 1, 6);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Minnnie', 'Scandrite', 70660999969, '2003-07-05', 2, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Gaven', 'Prangnell', 51012466483, '2002-06-02', 1, 1);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Sheryl', 'Hurdman', 93651286916, '2002-04-26', 2, 4);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Nataline', 'Woolager', 21050199543, '2002-05-16', 2, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Susy', 'Lightbowne', 60523972284, '2001-08-08', 2, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Glad', 'Tooth', 13596264057, '2002-09-10', 1, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Vallie', 'Ashbridge', 62612214198, '2003-07-16', 1, 6);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Dulcie', 'Bowie', 10523726884, '2002-07-17', 2, 4);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Malissia', 'Frensche', 70050345759, '2000-12-30', 2, 4);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Dagmar', 'Teck', 75898270838, '2000-03-16', 1, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Breena', 'Sparke', 64338502958, '2002-08-12', 2, 3);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Spenser', 'Synan', 63545101895, '1998-12-25', 1, 2);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Allis', 'Eydel', 62987572784, '1999-07-03', 2, 4);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Lilllie', 'Wetherald', 62053249982, '2003-03-22', 2, 8);
insert into Interns (Name, Surname, OIB, BirthDate, GenderID, TownID) values ('Yule', 'Bridger', 44901565988, '1999-12-03', 1, 2);

SELECT * FROM Interns

SELECT * FROM InternStatuses

select * from internshipfields

select * from internships

INSERT INTO InternshipFields(InternshipID, FieldID, LeaderID) VALUES
	(1, 1, 1),
	(1, 2, 11),
	(1, 3, 13),
	(1, 4, 6),
	(2, 1, 2),
	(2, 2, 10),
	(2, 3, 7),
	(2, 4, 5),
	(3, 1, 12),
	(3, 2, 17),
	(3, 3, 20),
	(3, 4, 22),
	(4, 1, 27),
	(4, 2, 6),
	(4, 3, 5),
	(4, 4, 8),
	(5, 1, 9),
	(5, 2, 27),
	(5, 3, 30),
	(5, 4, 31),
	(6, 1, 2),
	(6, 2, 35),
	(6, 3, 16),
	(6, 4, 22);
	
select * from internshipfields
	select * from interns
	
INSERT INTO InternFields(InternID, InternshipFieldID, StatusID) VALUES
	(13, 21, 1),
	(69, 21, 1),
	(1, 20, 1),
	(2, 1, 1),
	(3, 1, 1),
	(4, 1, 1),
	(5, 24, 1),
	(6, 2, 1),
	(7, 2, 1),
	(8, 2, 1),
	(9, 2, 1),
	(10, 20, 1),
	(11, 3, 1),
	(12, 3, 2),
	(13, 3, 2),
	(14, 3, 3),
	(15, 21, 3),
	(16, 4, 3),
	(17, 4, 3),
	(18, 4, 1),
	(19, 4, 1),
	(20, 5, 1),
	(21, 5, 1),
	(22, 5, 1),
	(23, 5, 1),
	(24, 5, 1),
	(25, 21, 1),
	(26, 23, 1),
	(27, 6, 2),
	(28, 6, 2),
	(29, 6, 3),
	(30, 7, 3),
	(31, 7, 3),
	(32, 7, 3),
	(33, 7, 1),
	(34, 7, 1),
	(35, 8, 1),
	(36, 8, 1),
	(37, 8, 1),
	(38, 9, 1),
	(39, 23, 1),
	(40, 9, 1),
	(41, 9, 1),
	(42, 21, 1),
	(43, 10, 1),
	(44, 24, 1),
	(45, 10, 1),
	(46, 10, 1),
	(47, 11, 1),
	(48, 11, 1),
	(49, 11, 2),
	(50, 18, 2),
	(51, 11, 3),
	(52, 11, 3),
	(53, 22, 3),
	(54, 22, 3),
	(55, 12, 1),
	(56, 19, 1),
	(57, 12, 1),
	(58, 12, 1),
	(59, 13, 1),
	(60, 13, 1),
	(61, 13, 1),
	(62, 22, 1),
	(63, 14, 1),
	(64, 14, 1),
	(65, 15, 2),
	(66, 16, 2),
	(67, 16, 3),
	(68, 17, 3),
	(69, 18, 3),
	(70, 19, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (80, 2, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (82, 19, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (99, 11, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (77, 21, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (92, 20, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (94, 23, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (81, 24, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (71, 24, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (84, 22, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (90, 20, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (71, 19, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (94, 18, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (97, 17, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (88, 16, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (73, 15, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (73, 14, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (85, 5, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (99, 4, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (79, 11, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (74, 4, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (97, 3, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (96, 6, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (97, 15, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (98, 22, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (99, 21, 3);
insert into InternFields (InternID, InternshipFieldID, StatusID) values (100, 11, 3);
	
select * from InternFields

select * from members

insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (151, 1, 5);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (200, 2, 21);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (175, 2, 8);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (207, 2, 8);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (155, 1, 8);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (225, 4, 6);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (165, 5, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (166, 5, 14);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (143, 3, 34);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (162, 4, 11);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (149, 5, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (164, 3, 35);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (229, 2, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (216, 4, 21);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (164, 5, 32);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (166, 3, 32);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (233, 3, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (203, 5, 3);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (210, 1, 20);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (145, 4, 1);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (181, 2, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (191, 1, 17);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (202, 3, 5);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (197, 3, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (234, 3, 27);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (222, 2, 1);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (198, 4, 6);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (196, 5, 13);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (188, 2, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (172, 2, 26);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (176, 4, 18);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (189, 3, 21);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (169, 4, 28);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (151, 3, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (198, 5, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (199, 2, 18);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (173, 5, 5);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (169, 2, 27);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (204, 5, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (218, 4, 3);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (198, 5, 8);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (204, 3, 7);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (224, 1, 26);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (225, 3, 34);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (203, 2, 4);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (214, 4, 24);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (200, 2, 1);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (171, 5, 31);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (188, 5, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (157, 1, 6);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (170, 5, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (155, 2, 19);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (143, 2, 12);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (175, 4, 27);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (218, 4, 20);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (223, 2, 35);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (189, 5, 11);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (170, 5, 21);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (168, 4, 13);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (154, 5, 4);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (193, 1, 29);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (168, 4, 28);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (227, 2, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (219, 5, 13);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (213, 1, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (215, 2, 33);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (212, 3, 15);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (159, 1, 11);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (186, 4, 25);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (142, 1, 16);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (155, 5, 30);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (177, 2, 11);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (180, 5, 26);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (232, 1, 29);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (163, 4, 32);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (186, 4, 3);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (185, 1, 24);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (226, 4, 1);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (150, 5, 9);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (210, 3, 17);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (204, 3, 29);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (189, 1, 27);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (230, 3, 26);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (201, 5, 15);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (162, 3, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (199, 2, 19);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (197, 1, 32);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (205, 4, 23);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (147, 5, 20);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (194, 5, 7);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (156, 4, 27);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (171, 5, 3);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (231, 4, 34);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (227, 4, 33);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (212, 2, 5);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (179, 2, 11);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (163, 4, 33);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (151, 1, 21);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (181, 4, 6);
insert into InternMarks (InternFieldID, MarkID, CorrectorID) values (210, 4, 7);





-------------
/* queries */
-------------


-- ispišite ime i prezime članova koji žive izvan Splita

SELECT Name, Surname
FROM Members
WHERE TownID not in (SELECT TownID FROM Towns WHERE Name like 'Split')






-- ispišite datum početka i kraja svakog Internshipa, sortiranih po datumu početka od novijeg prema starom

SELECT PlannedStart, PlannedEnd
FROM Internships
ORDER BY PlannedStart DESC






-- ispišite ime i prezime svih interna 2021./2022.

SELECT Interns.Name, Interns.Surname
FROM Interns
INNER JOIN InternFields ON Interns.InternID = InternFields.InternID
INNER JOIN InternshipFields ON InternFields.InternshipFieldID = InternshipFields.InternshipFieldID 
INNER JOIN Internships ON InternshipFields.InternshipID = Internships.InternshipID 
WHERE Internships.PlannedStart > '2021-01-01'  AND  Internships.PlannedStart < '2021-12-12'






-- ispišite broj pripravnica na ovogodišnjem dev Internshipu 

SELECT COUNT(*) AS BrojPripravnica
FROM Interns
INNER JOIN InternFields ON Interns.InternID = InternFields.InternID
INNER JOIN InternshipFields ON InternFields.InternshipFieldID = InternshipFields.InternshipFieldID
INNER JOIN Fields ON InternshipFields.FieldID = Fields.FieldID
INNER JOIN Internships ON InternshipFields.InternshipID = Internships.InternshipID
WHERE Interns.GenderID = 2
	  AND Fields.Name like 'programiranje'
	  AND (Internships.PlannedStart > '2021-01-01' AND Internships.PlannedStart < '2021-12-12') 
	   




	   
-- svim članovima čije prezime završava na -in promijenite mjesto stanovanja u Moskvu

INSERT INTO Towns(Name) VALUES ('Moskva')

SELECT * FROM Towns

SELECT * FROM Interns WHERE Surname like '%in'

UPDATE Interns
SET TownID = (SELECT TownID FROM Towns WHERE Name like 'Moskva')
WHERE Surname like '%in'





-- izbrišite sve članove starije od 25 godina

DELETE FROM Interns
WHERE date_part('year', AGE(BirthDate)) > 25





-- izbacite sve pripravnike s prosjekom ocjena manjim od 2.4 na tom području

SELECT COUNT(*) FROM InternFields
WHERE StatusID = 1


UPDATE InternFields
SET StatusID = (SELECT StatusID FROM InternStatuses WHERE Meaning like 'kicked out')
WHERE InternFields.StatusID = (SELECT StatusID FROM InternStatuses WHERE Meaning like 'current intern') 
HAVING (SELECT ROUND(AVG(ma.label), 2) as AverageMark FROM InternMarks im
		INNER JOIN Marks ma ON ma.markid = im.markid
		INNER JOIN internfields inf ON inf.internfieldid = im.internfieldid
		GROUP BY im.internfieldid) < 2.4


UPDATE InternFields
SET StatusID = (SELECT StatusID FROM InternStatuses WHERE Meaning like 'kicked out')
WHERE InternFields.StatusID = (SELECT StatusID FROM InternStatuses WHERE Meaning like 'current intern') 
AND (ROUND(AVG(ma.label), 2) as AverageMark FROM InternMarks im
		INNER JOIN Marks ma ON ma.markid = im.markid
		INNER JOIN internfields inf ON inf.internfieldid = im.internfieldid
		GROUP BY im.internfieldid)
		HAVING ROUND(AVG(ma.label), 2) < 2.4
		
		
SELECT inf.internid FROM internfields inf
WHERE (SELECT ROUND(AVG(ma.label), 2) FROM internmarks im
			INNER JOIN marks ma ON ma.markid = im.markid
			INNER JOIN internfields inf on inf.internfieldid = im.internfieldid
			GROUP BY im.internfieldid) < 2.4
				

   -- izlistane valjda prosjecne ocjene svih koji su za izbacit.
SELECT ROUND(AVG(ma.label), 2) as AverageMark FROM InternMarks im
INNER JOIN Marks ma ON ma.markid = im.markid
INNER JOIN internfields inf ON inf.internfieldid = im.internfieldid
GROUP BY im.internfieldid
HAVING ROUND(AVG(ma.label), 2) < 2.4




SELECT inf.internid, (SELECT ROUND(AVG(ma.label), 2) as AverageMark FROM InternMarks im
						INNER JOIN Marks ma ON ma.markid = im.markid
						INNER JOIN internfields inf ON inf.internfieldid = im.internfieldid
					    WHERE im.internfieldid = inf.internfieldid
						GROUP BY im.internfieldid
						HAVING ROUND(AVG(ma.label), 2) < 2.4)
FROM internfields inf





