-- Codice per la Creazione ed il Popolamento delle tabelle del DataBade "ExoPlanetDB"
-- Queries e Index a fondo pagina

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Astronomo;
DROP TABLE IF EXISTS Manutentore;
DROP TABLE IF EXISTS Osservatorio;
DROP TABLE IF EXISTS Telescopio;
DROP TABLE IF EXISTS CorpoCeleste;
DROP TABLE IF EXISTS Pianeta;
DROP TABLE IF EXISTS Campionatura;
DROP TABLE IF EXISTS Documentazione;
DROP TABLE IF EXISTS DocumentazioneSistema;
DROP TABLE IF EXISTS DocumentazionePianeta;
DROP TABLE IF EXISTS ElementoAtmosfera;
DROP TABLE IF EXISTS Scrittura;

-- Creazione Tabelle

CREATE TABLE Astronomo (
 CP char(9) NOT NULL,
 Nome varchar(20) NOT NULL,
 Cognome varchar(20) NOT NULL,
 Età tinyint NOT NULL,
 Pos_Classifica int NOT NULL,
 Ufficio varchar(50) NOT NULL,
 PRIMARY KEY (CP),
 FOREIGN KEY (Ufficio) REFERENCES Osservatorio (Nome)
					ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Osservatorio (
 Nome varchar(50) NOT NULL,
 Via varchar(30) NOT NULL,
 Città varchar(30) NOT NULL,
 Nazione varchar(20) NOT NULL,
 PRIMARY KEY (Nome)
) ENGINE=InnoDB;


CREATE TABLE Telescopio (
 Nome varchar(30) NOT NULL,
 Osservatorio_Appartenenza varchar(50) NOT NULL,
 Risoluzione real NOT NULL,
 PRIMARY KEY (Nome),
 FOREIGN KEY (Osservatorio_Appartenenza) REFERENCES Osservatorio (Nome)
								ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Manutentore (
 CP char(9) NOT NULL,
 Nome varchar(20)NOT NULL,
 Cognome varchar(20) NOT NULL,
 Età tinyint NOT NULL,
 Telescopio_Assegnato varchar(30) NOT NULL,
 PRIMARY KEY (CP),
 FOREIGN KEY (Telescopio_Assegnato) REFERENCES Telescopio (Nome)
ON DELETE NO ACTION
) ENGINE=InnoDB;


CREATE TABLE CorpoCeleste (
 Nome varchar(20) NOT NULL,
 Tipo enum('P','S') NOT NULL,
 Posizione real NOT NULL,
 Documento_Migliore integer(10) default NULL,
 PRIMARY KEY (Nome),
 FOREIGN KEY (Documento_Migliore) REFERENCES Documentazione (ID)
							ON DELETE NO ACTION
)ENGINE=InnoDB;


CREATE TABLE Pianeta (
 Nome varchar(20) NOT NULL,
 DataOra_Scoperta datetime NOT NULL,
 Nome_Sistema varchar(20) NOT NULL,
 Doc_Scoperta integer(10) default NULL,
 PRIMARY KEY (Nome),
 FOREIGN KEY (Nome) REFERENCES CorpoCeleste (Nome)
				ON DELETE CASCADE,
 FOREIGN KEY (Nome_Sistema) REFERENCES CorpoCeleste (Nome)
				ON DELETE NO ACTION,
 FOREIGN KEY (Doc_Scoperta) REFERENCES Documentazione (ID)
				ON DELETE NO ACTION
)ENGINE=InnoDB;


CREATE TABLE Campionatura (
 DataOrario datetime NOT NULL,
 Strumentazione varchar(30) NOT NULL,
 Spettro char(20) default NULL,
 Ricercatore char(9) NOT NULL,
 Stella_Target varchar(20) NOT NULL,
 Corrispondenza varchar(20) default NULL,
 PRIMARY KEY (DataOrario, Strumentazione),
 FOREIGN KEY (Ricercatore) REFERENCES Astronomo (CP)
					ON DELETE NO ACTION,
 FOREIGN KEY (Strumentazione) REFERENCES Telescopio (Nome)
					ON DELETE NO ACTION,
 FOREIGN KEY (Stella_Target) REFERENCES CorpoCeleste (Nome)
					ON DELETE NO ACTION,
 FOREIGN KEY (Corrispondenza) REFERENCES CorpoCeleste (Nome)
					ON DELETE SET NULL
)ENGINE=InnoDB;


CREATE TABLE Documentazione (
 ID integer(10) NOT NULL,
 Rating tinyint NOT NULL,
 Data_Pubblicazione datetime NOT NULL,
 Oggetto varchar(20) NOT NULL,
 PRIMARY KEY (ID),
 FOREIGN KEY (Oggetto) REFERENCES CorpoCeleste (Nome)
					ON DELETE NO ACTION
) ENGINE=InnoDB;


CREATE TABLE DocumentazioneSistema (
 ID_doc integer(10) NOT NULL,
 Massa real NOT NULL,
 Temperatura real NOT NULL,
 Inizio_FA real NOT NULL,
 Fine_FA real NOT NULL,
 Spettro_Base char(20) NOT NULL,
 PRIMARY KEY (ID_doc),
 FOREIGN KEY (ID_doc) REFERENCES Documentazione (ID)
					ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE DocumentazionePianeta (
 ID_doc integer(10) NOT NULL,
 Massa real NOT NULL,
 Raggio_Orbita real NOT NULL,
 SuperPeriodo real NOT NULL,
 PRIMARY KEY (ID_doc),
 FOREIGN KEY (ID_doc) REFERENCES Documentazione (ID)
					ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE ElementoAtmosfera (
 ID_doc integer(10) NOT NULL,
 Simbolo varchar(3) NOT NULL,
 Nome varchar(20) NOT NULL,
 Percentuale tinyint NOT NULL,
 PRIMARY KEY (ID_doc, Simbolo),
 FOREIGN KEY (ID_doc) REFERENCES DocumentazionePianeta (ID_doc)
					ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Scrittura (
 ID_doc integer(10) NOT NULL,
 Ricercatore char(9) NOT NULL,
 PRIMARY KEY (ID_doc, Ricercatore),
 FOREIGN KEY (ID_doc) REFERENCES DocumentazionePianeta (ID_doc)
					ON DELETE CASCADE,
 FOREIGN KEY (Ricercatore) REFERENCES Astronomo (CP)
					ON DELETE CASCADE
) ENGINE=InnoDB;


-- Popolamento Tabelle

INSERT INTO
Astronomo (CP,Nome,Cognome,Età,Pos_Classifica,Ufficio) VALUES
('MRCCST001','Marco','Castoldi',55,011,'Osservatorio G.Piazzi'),
('NDRFMG002','Andrea','Fumagalli',46,015,'Osservatorio G.Piazzi'),
('STFBLS001','Stefano','Belisari',70,006,'Osservatorio AstroPlanet'),
('NCLFSN002','Nicola','Fasani',35,008,'Osservatorio AstroPlanet'),
('CRSMRE003','Christian','Meyer',43,005,'Osservatorio AstroPlanet'),
('NTNGZZ004','Antonello','Aguzzi',29,013,'Osservatorio AstroPlanet'),
('MTTMRC001','Matthew','Mercer',40,024,'SETI Lab'),
('LRABLA002','Laura','Bailey',36,022,'SETI Lab'),
('SHLJHN003','Ashley','Johnson',42,004,'SETI Lab'),
('DNACRR004','Dany','Carr',34,002,'SETI Lab'),
('DRRSDD001','Darroh','Sudderth',37,026,'Outer Worlds Observatory'),
('CLFCMP002','Cliff','Campbell',37,016,'Outer Worlds Observatory'),
('MTTLNG003','Matt','Langley',41,003,'Outer Worlds Observatory'),
('RNYCLL004','Ryan','Collier',57,009,'Outer Worlds Observatory'),
('LGNKNN005','Logan','Kennedy',60,021,'Outer Worlds Observatory'),
('VLNHGG001','Evelina','Hagglund',33,012,'Rymdobservatorium'),
('MRCSJB002','Marcus','Sjoberg',39,018,'Rymdobservatorium'),
('DVDZND003','David','Zanden',49,014,'Rymdobservatorium'),
('XNJMLK001','Xenja','Malkovich',27,007,'Kosmicheskaya Observatoriya'),
('KZJMLK002','Kuzja','Malkovich',64,017,'Kosmicheskaya Observatoriya'),
('WTKJNS001','Watkin','Jones',50,020,'Southern Observatory'),
('MRTKNN001','Martha','Kennedy',53,001,'Sydney Astrolab'),
('JRMLSP002','Jeremy','Alsop',23,023,'Sydney Astrolab'),
('CLNHMA003','Colin','Ham',57,019,'Sydney Astrolab'),
('STPHDL004','Stephen','Hadley',48,027,'Sydney Astrolab'),
('JHNWTS005','Johanna','Watson',38,025,'Sydney Astrolab'),
('PTRMLS006','Peter','Malsen',35,010,'Sydney Astrolab');

INSERT INTO
Osservatorio (Nome,Via,Città,Nazione) VALUES
('Osservatorio G.Piazzi','San.Bernardo 12','Ponte In Valtellina','Italy'),
('Osservatorio AstroPlanet','Europa 6','Pisa','Italy'),
('SETI Lab','Liberty Ave. 74','Los Angeles','U.S.A.'),
('Outer Worlds Observatory','Goose Str. 122','Philadelphia','U.S.A.'),
('Rymdobservatorium','Vintergatan 112','Stockholm','Sweden'),
('Kosmicheskaya Observatoriya','Ulista Hm.Kalinina 3','Volgograd','Russia'),
('Southern Observatory','St David Rd 8','Johannesburg','South Africa'),
('Sydney Astrolab','Tudar Rd 45','Sydney','Australia');

INSERT INTO
Telescopio (Nome,Osservatorio_Appartenenza,Risoluzione) VALUES
('Cerere1','Osservatorio G.Piazzi',1250),
('Fibonacci','Osservatorio AstroPlanet',2000),
('Galileo','Osservatorio AstroPlanet',1500),
('deGrasse','SETI Lab',2000),
('ETfinder','SETI Lab',1750),
('Scott','Outer Worlds Observatory',750),
('Halpert1','Outer Worlds Observatory',1500),
('Halpert2','Outer Worlds Observatory',2750),
('Martin','Rymdobservatorium',2500),
('MMX','Rymdobservatorium',2000),
('Laika','Kosmicheskaya Observatoriya',1500),
('Gagarin','Kosmicheskaya Observatoriya',1250),
('Sputnik100','Kosmicheskaya Observatoriya',1750),
('Gaia','Southern Observatory',2750),
('Hay','Sydney Astrolab',3000),
('Strykert','Sydney Astrolab',2500),
('Speiser','Sydney Astrolab',2000),
('Rees','Sydney Astrolab',1500),
('Bayley','Sydney Astrolab',1250);

INSERT INTO
Manutentore (CP,Nome,Cognome,Età,Telescopio_Assegnato) VALUES
('LBTFRR003','Alberto','Ferrari',32,'Cerere1'),
('LCUFRR005','Luca','Ferrari',31,'Fibonacci'),
('FBRNGL006','Fabrizio','Angela',44,'Galileo'),
('RBRSMM007','Roberta','Sammarelli',31,'Fibonacci'),
('KLYKTZ005','Kyle','Kutzma',28,'deGrasse'),
('DWGHWR006','Dwight','Howard',45,'ETfinder'),
('LXACRS006','Alex','Caruso',48,'Scott'),
('JNNFSC007','Jenna','Fischer',36,'Halpert1'),
('RSHJNS008','Rashida','Jones',38,'Halpert2'),
('PHLFLN009','Phillis','Flanderson',53,'Halpert2'),
('JLOBRG004','Joel','Berghult',34,'Martin'),
('FLXDVD005','Felix','Davidson',39,'MMX'),
('NTLMSK003','Natalie','Maskov',24,'Gagarin'),
('RVLGRV004','Ravil','Gorevory',54,'Laika'),
('VLDZZK005','Vladimir','Zizikin',59,'Sputnik100'),
('LNDVSS002','Yolandi','Visser',29,'Gaia'),
('TSHSLT007','Tash','Sultana',43,'Hay'),
('RDRRVN012','Rodrigo','Aravena',53,'Hay'),
('GNSBLL008','Agnes','Bell',44,'Strykert'),
('SMNHSF013','Simon','Hosford',64,'Strykert'),
('LPRWLF009','Leper','Wolf',43,'Speiser'),
('MRCCVA010','Marco','Cave',62,'Rees'),
('TNOFLD014','Tony','Floyd',32,'Rees'),
('WRRTRT015','Warren','Trout',42,'Rees'),
('PTRTHY011','Peter','Yothu',60,'Bayley');

INSERT INTO
CorpoCeleste (Nome,Tipo,Posizione,Documento_Migliore) VALUES
('14Andromedae','S',48233,4004),
('18Delphini','S',74933,1050),
('41Lyncis','S',63518,5100),
('42Draconis','S',29719,1160),
('47UrsaeMajoris','S',11805,3890),
('51Pegasi','S',79596,2090),
('55Cancri','S',30006,3070),
('EpsilonEridani','S',58962,5400),
('EpsilonTauri','S',62464,3045),
('Formalhaut','S',51938,3046),
('GammaCephei','S',29687,4700),
('HD104985','S',34401,7321),
('Spe','P',59393,4005),
('Arion','P',79122,4960),
('Arkas','P',26621,5103),
('Orbitar','P',28777,4961),
('TaphaoThong','P',38954,4962),
('TaphaoKaew','P',83412,4963),
('Dimidium','P',14880,4964),
('Galileo','P',91768,3072),
('Brahe','P',35727,3073),
('Lipperhey','P',59706,3074),
('Janssen','P',62933,3075),
('Harriot','P',36587,3076),
('Aegir','P',40808,8000),
('Amateru','P',32764,2077),
('Dagon','P',61053,1990),
('Tadmor','P',81842,1991),
('Meztli','P',95862,1992),
('Smetrios','P',41562,1993),
('37Gauss','S',78555,NULL),
('32Kelvin','S',45788,NULL),
('Se7en','S',25663,8303),
('Scorpion','P',43255,NULL),
('Chronos','P',23566,NULL),
('Swan','P',98676,NULL),
('Arlequin','P',43567,NULL),
('Torus','P',62456,NULL),
('Panfilus','P',25476,NULL);

INSERT INTO
Pianeta (Nome,DataOra_Scoperta,Nome_Sistema,Doc_Scoperta) VALUES
('Spe','2019-10-25 15:25:36','14Andromedae',4005),
('Arion','2019-12-12 20:30:00','18Delphini',4960),
('Arkas','2020-01-01 10:30:00','41Lyncis',5103), 
('Orbitar','2019-12-13 22:20:00','42Draconis',4961),
('TaphaoThong','2016-12-13 09:49:20','47UrsaeMajoris',4962),
('TaphaoKaew','2019-12-15 21:32:00','47UrsaeMajoris',4963),
('Dimidium','2019-12-16 19:42:00','51Pegasi',4964),
('Galileo','2017-06-16 09:35:43','55Cancri',3072),
('Brahe','2017-06-12 10:00:00','55Cancri',3073),
('Lipperhey','2017-06-13 12:10:01','55Cancri',3074),
('Janssen','2017-06-14 13:07:41','55Cancri',3075),
('Harriot','2017-06-15 12:12:21','55Cancri',3076),
('Aegir','2014-07-10 22:10:10','EpsilonEridani',9810),
('Amateru','2012-12-21 18:23:57','EpsilonTauri',2070),
('Dagon','2019-12-28 20:30:00','Formalhaut',1990),
('Tadmor','2019-12-20 12:20:00','GammaCephei',1991),
('Meztli','2016-07-04 18:40:40','HD104985',1992),
('Smetrios','2019-12-29 15:20:00','HD104985',1993),
('Scorpion','2019-10-21 12:00:30','Formalhaut',NULL),
('Chronos','2019-11-02 04:30:30','EpsilonEridani',NULL),
('Swan','2019-10-23 14:04:34','51Pegasi',NULL),
('Arlequin','2019-07-30 07:50:30','51Pegasi',NULL),
('Torus','2019-08-05 02:00:10','Formalhaut',NULL),
('Panfilus','2019-08-05 03:10:17','GammaCephei',NULL);

INSERT INTO
Campionatura (DataOrario,Strumentazione,Spettro,Ricercatore,Stella_Target,Corrispondenza) VALUES
('2019-10-20 14:45:56','Cerere1','pPv4AJVo4TsPCK9b9eFr','MRCCST001','14Andromedae','14Andromedae'),
('2019-10-25 15:25:36','Galileo','pPv4AJVo4TsksoO84daS','STFBLS001','14Andromedae','Spe'),
('2020-01-01 10:30:00','Gaia','uW0d8gfSsTSaofsdOLL5','WTKJNS001','41Lyncis','Arkas'),
('2020-01-01 08:40:50','Gaia','uW0d8gfSsTS18SdgTH41','WTKJNS001','41Lyncis',NULL),
('2020-01-01 09:22:40','Gaia','uW0d8gfSsTStttfs4532','WTKJNS001','41Lyncis','41Lyncis'),
('2017-06-10 09:20:52','Hay','GsNhndMUeE97rCWjZ0U5','MRTKNN001','55Cancri','55Cancri'),
('2017-06-11 09:00:00','Rees','GsNhndMUeE97sdkfjb9Y','CLNHMA003','55Cancri',NULL),
('2017-06-12 10:00:00','Strykert','GsNhndMUeE97ggSAr478','JHNWTS005','55Cancri','Brahe'),
('2017-06-13 12:10:01','Speiser','GsNhndMUeE97sdhISU94','JRMLSP002','55Cancri','Lipperhey'),
('2017-06-14 13:07:41','Rees','GsNhndMUeE97awwqwpeQ','MRTKNN001','55Cancri','Janssen'),
('2017-06-15 12:12:21','Bayley','GsNhndMUeE96asdoaf84','PTRMLS006','55Cancri','Harriot'),
('2017-06-16 09:35:43','Hay','GsNhndMUeE95alefhiO7','PTRMLS006','55Cancri','Galileo'),
('2019-11-01 07:25:00','Laika','pPv4AJVo4TsksoO84daS','KZJMLK002','14Andromedae','Spe'),
('2020-01-03 12:50:00','deGrasse','uW0d8gfSsTSaofsdOLL5','LRABLA002','41Lyncis','Arkas'),
('2020-01-04 19:00:00','deGrasse','uW0d8gfSsTSaofsdOLL5','SHLJHN003','41Lyncis','Arkas'),
('2020-01-05 20:24:00','MMX','uW0d8gfSsTSaofsdOLL5','DVDZND003','41Lyncis','Arkas'),
('2016-12-10 08:40:30','Gagarin','9HD5ZmiHpy7iTs6DtTh3','XNJMLK001','47UrsaeMajoris','47UrsaeMajoris'),
('2016-12-11 10:40:00','Sputnik100','9HD5ZmiHpy7iTs6DtTh3','KZJMLK002','47UrsaeMajoris','47UrsaeMajoris'),
('2016-12-12 11:32:30','Gagarin','9HD5ZmiHpy7iTs6DtTh3','XNJMLK001','47UrsaeMajoris','47UrsaeMajoris'),
('2016-12-12 12:40:20','Laika','9HD5ZmiHpy234HDaif77','KZJMLK002','47UrsaeMajoris',NULL),
('2016-12-13 09:49:20','Sputnik100','9HD5ZmiHpy7shsf45sDF','XNJMLK001','47UrsaeMajoris','TaphaoThong'),
('2016-07-01 15:40:40','Fibonacci','Wz63jIrI8Lb75NVJWBsK','CRSMRE003','HD104985','HD104985'),
('2016-07-02 16:40:40','Fibonacci','Wz63jIrI8Lb75NVJWBsK','STFBLS001','HD104985','HD104985'),
('2016-07-03 17:40:40','Galileo','Wz63jIrI8Lb75NVJWBsK','NCLFSN002','HD104985','HD104985'),
('2016-07-04 18:40:40','Galileo','Wz63jIrI8Lb7dsshjkf7','NTNGZZ004','HD104985','Meztli'),
('2018-02-27 06:45:50','Scott','FgghFNVGRtKN4XW08zUM','DRRSDD001','18Delphini','18Delphini'),
('2018-02-27 12:50:55','Scott','FgghFNVGRtKN4XW08zUM','DRRSDD001','18Delphini','18Delphini'),
('2018-02-28 18:23:00','Halpert1','FgghFNVGRtKasdsdafgh','DRRSDD001','18Delphini',NULL),
('2018-02-29 16:47:13','Halpert2','FgghFNVGRtKasdsdafgh','DRRSDD001','18Delphini','Arion'),
('2020-04-30 03:00:00','Fibonacci',NULL,'NTNGZZ004','14Andromedae',NULL),
('2030-08-30 16:00:00','Sputnik100',NULL,'XNJMLK001','55Cancri',NULL),
('2020-02-23 00:00:00','MMX',NULL,'DVDZND003','55Cancri',NULL),
('2020-01-09 22:59:43','Speiser',NULL,'JHNWTS005','55Cancri',NULL);

INSERT INTO
Documentazione (ID,Rating,Data_Pubblicazione,Oggetto) VALUES
(4004,8,'2019-10-29 13:45:23','14Andromedae'),
(4005,8,'2019-10-29 09:48:22','Spe'),
(1333,6,'2018-08-12 17:23:34','14Andromedae'),
(5100,9,'2020-01-01 23:00:30','41Lyncis'),
(5103,7,'2020-01-02 10:32:31','Arkas'),
(3070,8,'2017-07-20 20:12:11','55Cancri'),
(3072,7,'2017-07-21 13:23:56','Galileo'),
(3073,7,'2017-07-22 14:23:43','Brahe'),
(3074,7,'2017-07-22 17:24:10','Lipperhey'),
(3075,8,'2017-07-23 08:23:56','Janssen'),
(3076,6,'2017-07-24 08:45:12','Harriot'),
(1050,8,'2002-12-23 20:03:00','18Delphini'),
(1160,8,'2012-08-12 18:54:11','42Draconis'),
(3890,7,'2013-06-02 12:32:16','47UrsaeMajoris'),
(2090,9,'2015-05-30 13:32:21','51Pegasi'),
(5400,8,'2015-11-28 17:23:45','EpsilonEridani'),
(3045,9,'2007-08-18 22:33:22','EpsilonTauri'),
(3046,8,'2009-10-25 14:34:12','Formalhaut'),
(4700,9,'2010-02-27 13:09:07','GammaCephei'),
(7321,7,'2016-03-18 19:18:17','HD104985'),
(9810,6,'2014-08-01 11:10:00','Aegir'),
(8000,9,'2019-12-02 10:00:00','Aegir'),
(2070,5,'2013-01-19 07:10:00','Amateru'),
(2077,8,'2019-12-22 18:30:00','Amateru'),
(1990,9,'2019-12-29 10:30:00','Dagon'),
(1991,8,'2019-12-21 08:20:00','Tadmor'),
(1992,9,'2019-12-11 11:40:00','Meztli'),
(1993,8,'2019-12-30 10:20:00','Smetrios'),
(4960,7,'2019-12-13 10:30:00','Arion'),
(4961,7,'2019-12-14 11:30:00','Orbitar'),
(4962,8,'2019-12-15 10:20:00','TaphaoThong'),
(4963,9,'2019-12-16 16:32:00','TaphaoKaew'),
(4964,8,'2019-12-17 17:52:00','Dimidium'),
(4974,8,'2017-10-18 14:44:00','Dimidium'),
(5630,5,'2020-01-02 07:20:00','Galileo'),
(8303,8,'2001-09-30 05:20:43','Se7en'),
(8304,7,'2011-01-30 11:20:43','Se7en'),
(2700,7,'2018-02-28 13:00:55','18Delphini'),
(5000,7,'2020-01-04 14:40:00','41Lyncis');

INSERT INTO
DocumentazioneSistema (ID_doc,Massa,Temperatura,Inizio_FA,Fine_FA,Spettro_Base) VALUES
(4004,2.2,4743,0.80,1,'pPv4AJVo4TsPCK9b9eFr'),
(1333,2.4,5000,0.70,1.10,'pPv4AJVo4TssdID0qwod'),
(5100,2.1,4753,0.75,0.90,'uW0d8gfSsTSwsjCGiT4C'),
(3070,0.91,5196,0.10,0.30,'GsNhndMUeE97rCWjZ0U5'),
(1050,2.3,4979,1.20,1.50,'L7SwZtSYUWhts4MeHwBv'),
(1160,0.98,4200,1.10,1.60,'kX1jDsqUr2Y27LX9GOY0'),
(3890,1.03,5892,1.90,2.30,'HGNuRJR78oEegkariYb5'),
(2090,1.12,5793,2.30,2.40,'l6wo8qFJk01l0C3rvLKl'),
(5400,0.83,3989,1.80,2.30,'igGGw0JSCCDLqvEaaBcQ'),
(3045,2.7,4901,1.80,2.00,'8B8sPCZjvVn90gqGqk8W'),
(3046,2,5012,4.80,5.10,'96GgfJG4lczhfWfJ2kr8'),
(4700,1.4,4562,3.10,3.40,'CchDma0qya7FMh8FIzjJ'),
(7321,1.34,6160,0.85,1.10,'RW4pWzhxs9F08BtghYfN'),
(8303,20.5,3256,4.56,5.00,'kifDIsXCzu2nQuyife6L'),
(8304,21.5,3332,4.70,5.11,'kifDIsXCzu2nQuyife6L'),
(2700,12.4,4790,2.70,3.30,'FgghFNVGRtKN4XW08zUM'),
(5000,7.2,7800,5.60,5.90,'uW0d8gfSsTSaofsdOLL5');

INSERT INTO
DocumentazionePianeta (ID_doc,Massa,Raggio_Orbita,SuperPeriodo) VALUES
(4005,4.8,0.83,185.84),
(5103,2.7,0.81,184.02),
(3072,0.83,0.11,14.65),
(3073,7.7,0.24,44.41),
(3074,3.8,5.5,4825),
(3075,10.2,0.015,0.73),
(3076,14.0,0.78,262),
(9810,9.0,3.00,3000),
(8000,11.5,3.39,2502),
(2070,10.6,2.00,600),
(2077,7.6,1.93,594.9),
(1990,10.5,160,55530),
(1991,1.85,2.05,903.3),
(1992,6.33,0.95,199.50),
(1993,0.36,15.3,2.87),
(4960,10.3,2.6,993.3),
(4961,3.88,1.19,479.1),
(4962,2.53,2.1,1078),
(4963,0.54,3.6,2391),
(4964,18.6,1.34,4.23),
(4974,19.6,1.24,4.03),
(5630,0.70,0.20,16.90);

INSERT INTO
ElementoAtmosfera (ID_doc,Simbolo,Nome,Percentuale) VALUES
(4005,'O','Ossigeno',30),
(4005,'H','Idrogeno',10),
(4005,'C','Carbonio',5),
(4005,'Ot','Others',55),
(5103,'N','Azoto',60),
(5103,'O','Ossigeno',20),
(5103,'C','Carbonio',12),
(5103,'H','Idrogeno',6),
(5103,'Ot','Others',2),
(3072,'O','Ossigeno',10),
(3072,'C','Carbonio',15),
(3072,'Ot','Others',75),
(3073,'O','Ossigeno',14),
(3073,'H','Idrogeno',6),
(3073,'C','Carbonio',9),
(3073,'Ot','Others',71),
(3074,'O','Ossigeno',17),
(3074,'C','Carbonio',8),
(3074,'H','Idrogeno',5),
(3074,'Ot','Others',70),
(3075,'Ot','Others',100),
(3076,'S','Zolfo',65),
(3076,'O','Ossigeno',5),
(3076,'Ot','Others',30),
(9810,'C','Carbonio',12),
(9810,'O','Ossigeno',12),
(9810,'Ot','Others',76),
(8000,'C','Carbonio',8),
(8000,'O','Ossigeno',16),
(8000,'Ot','Others',76),
(2070,'C','Carbonio',18),
(2070,'O','Ossigeno',12),
(2070,'Ot','Others',70),
(2077,'O','Ossigeno',17),
(2077,'C','Carbonio',8),
(2077,'H','Idrogeno',5),
(2077,'Ot','Others',70),
(1990,'O','Ossigeno',30),
(1990,'H','Idrogeno',10),
(1990,'C','Carbonio',5),
(1990,'Ot','Others',55),
(1991,'O','Ossigeno',14),
(1991,'H','Idrogeno',6),
(1991,'C','Carbonio',9),
(1991,'Ot','Others',71),
(1992,'S','Zolfo',65),
(1992,'O','Ossigeno',5),
(1992,'Ot','Others',30),
(1993,'N','Azoto',60),
(1993,'O','Ossigeno',22),
(1993,'C','Carbonio',10),
(1993,'H','Idrogeno',6),
(1993,'Ot','Others',2),
(4960,'O','Ossigeno',23),
(4960,'C','Carbonio',7),
(4960,'H','Idrogeno',5),
(4960,'Ot','Others',65),
(4961,'O','Ossigeno',23),
(4961,'C','Carbonio',7),
(4961,'H','Idrogeno',5),
(4961,'Ot','Others',65),
(4962,'O','Ossigeno',18),
(4962,'H','Idrogeno',22),
(4962,'Ot','Others',60),
(4963,'O','Ossigeno',15),
(4963,'H','Idrogeno',25),
(4963,'Ot','Others',60),
(4964,'O','Ossigeno',20),
(4964,'C','Carbonio',9),
(4964,'H','Idrogeno',8),
(4964,'Ot','Others',63),
(4974,'O','Ossigeno',20),
(4974,'Ot','Others',80);

INSERT INTO
Scrittura (ID_doc,Ricercatore) VALUES
(4004,'MRCCST001'),
(4005,'MRCCST001'),
(4005,'NDRFMG002'),
(1333,'NCLFSN002'),
(5100,'WTKJNS001'),
(5100,'VLNHGG001'),
(5100,'MRCSJB002'),
(5103,'WTKJNS001'),
(5103,'VLNHGG001'),
(3070,'PTRMLS006'),
(3070,'MRTKNN001'),
(3072,'PTRMLS006'),
(3073,'STPHDL004'),
(3074,'JHNWTS005'),
(3074,'MRTKNN001'),
(3075,'MRTKNN001'),
(3076,'JRMLSP002'),
(1050,'CLFCMP002'),
(1050,'CRSMRE003'),
(1050,'STPHDL004'),
(1160,'STFBLS001'),
(3890,'NDRFMG002'),
(2090,'MTTLNG003'),
(2090,'JHNWTS005'),
(5400,'LGNKNN005'),
(5400,'MTTMRC001'),
(3045,'DVDZND003'),
(3045,'MTTMRC001'),
(3045,'NTNGZZ004'),
(3045,'LGNKNN005'),
(3046,'KZJMLK002'),
(4700,'JRMLSP002'),
(7321,'SHLJHN003'),
(9810,'KZJMLK002'),
(9810,'LGNKNN005'),
(9810,'MTTMRC001'),
(8000,'RNYCLL004'),
(2070,'DRRSDD001'),
(2077,'DNACRR004'),
(2077,'SHLJHN003'),
(1990,'MRCSJB002'),
(1991,'CLNHMA003'),
(1992,'MRCCST001'),
(1993,'DNACRR004'),
(1993,'CRSMRE003'),
(1993,'PTRMLS006'),
(4960,'LRABLA002'),
(4960,'MTTMRC001'),
(4961,'LRABLA002'),
(4962,'SHLJHN003'),
(4963,'MRTKNN001'),
(4964,'CRSMRE003'),
(4974,'CLFCMP002'),
(5630,'NTNGZZ004'),
(5630,'VLNHGG001'),
(5630,'WTKJNS001'),
(8303,'LGNKNN005'),
(8304,'MTTMRC001'),
(2700,'DRRSDD001'),
(5000,'LRABLA002');

SET FOREIGN_KEY_CHECKS=1;


-- Queries e Index

--1° Selezione di pianeti più interessanti per lo studio della vita extraterrestre

DROP VIEW IF EXISTS FasciaAbitabile;
CREATE VIEW FasciaAbitabile(pianeta,inizio_FA,fine_FA) as 
(SELECT P.Nome,DS.Inizio_FA,DS.Fine_FA
 FROM Pianeta as P,CorpoCeleste as C,DocumentazioneSistema as DS
 WHERE P.Nome_Sistema=C.Nome AND C.Documento_Migliore=DS.ID_doc);

SELECT PValidi.Nome Nome, count(*) numOss 
FROM Campionatura Camp, 
  (SELECT C.Nome Nome 
   FROM CorpoCeleste C,DocumentazionePianeta DP,
      FasciaAbitabile F, ElementoAtmosfera E 
   WHERE C.Nome=F.pianeta AND C.Documento_Migliore=DP.ID_doc AND
      DP.Raggio_Orbita>F.inizio_FA AND 
      DP.Raggio_Orbita<F.fine_FA AND
      DP.Massa<10 AND E.ID_doc=DP.ID_doc AND 
      (E.Simbolo='C' OR E.Simbolo='O' OR E.Simbolo='H') 
   GROUP BY C.Nome HAVING count(*)=3 ) as PValidi 
WHERE Camp.Corrispondenza=PValidi.Nome 
GROUP BY PValidi.Nome
ORDER BY numOss;

--2° Osservare un pianeta {‘Galileo’ è un esempio di soggetto della prenotazione}

SET @DataPresente := '2020-01-01 00:00:00'; 
DROP VIEW IF EXISTS DataVisibil;
CREATE VIEW DataVisibil(dataOra) as
(SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(P.DataOra_Scoperta)+
      ((UNIX_TIMESTAMP(@DataPresente)-UNIX_TIMESTAMP(P.DataOra_Scoperta)) DIV
       (DP.SuperPeriodo*24*60*60) +1)*(DP.SuperPeriodo*24*60*60))
 FROM CorpoCeleste C1,DocumentazionePianeta DP,Pianeta P
 WHERE C1.Nome='Galileo' AND P.Nome='Galileo' AND
       C1.Documento_Migliore=DP.ID_doc );

SELECT DISTINCT A1.Nome Astronomo,DataVisibil.dataOra visibilià,T.Nome Telescopio,
       ManutPerTelesc.numManut numManutentori
FROM Astronomo A1,Osservatorio O, Telescopio T, Campionatura Camp, DataVisibil,
     (SELECT T1.Nome as Telesc,count(M.Nome) as numManut
     FROM Telescopio T1 LEFT JOIN Manutentore M on M.Telescopio_Assegnato=T1.Nome
     GROUP BY T1.Nome) as ManutPerTelesc
WHERE A1.Pos_Classifica= 
  (SELECT MIN(A.Pos_Classifica)
   FROM CorpoCeleste C, Documentazione D,Scrittura S,Astronomo A
   WHERE C.Nome='Galileo'  AND  D.ID=C.Documento_Migliore  AND
       S.ID_doc=D.ID  AND  S.Ricercatore=A.CP)  AND
   NOT EXISTS (SELECT *
      FROM Campionatura as CA, DataVisibil
      WHERE CA.DataOrario=DataVisibil.dataOra
          AND CA.Strumentazione=T.Nome)   AND
   A1.Ufficio=O.Nome  AND  
   T.Osservatorio_Appartenenza=O.Nome AND
   T.Nome = ManutPerTelesc.Telesc
ORDER BY ManutPerTelesc.numManut DESC;

--3° Quanto è efficiente l’algoritmo di scheduling di campionature nel scovare nuovi pianeti?

SELECT Camp.Stella_Target Sistema,count(*) CampIniziali,InfoStella.numP numPianeti,
1/(InfoStella.numP*count(*)) Efficienza
FROM Campionatura Camp, 
 (SELECT Ca.Stella_Target Stella
  FROM Astronomo A,Campionatura Ca       
  WHERE A.CP=Ca.Ricercatore AND 
     EXISTS (SELECT * FROM Pianeta P 
             WHERE P.Nome_Sistema=Ca.Stella_Target)
  GROUP BY Ca.Stella_Target
  HAVING count(DISTINCT A.CP)>=2) StValide,  
 (SELECT P2.Nome_Sistema Stella, Count(*) numP,
    MIN(UNIX_TIMESTAMP(P2.DataOra_Scoperta)) Scp1
  FROM Pianeta P2
  GROUP BY P2.Nome_Sistema ) InfoStella  
WHERE InfoStella.Stella=StValide.Stella AND
      Camp.Stella_Target=StValide.Stella AND
      (UNIX_TIMESTAMP(Camp.DataOrario)<
          InfoStella.Scp1)
GROUP BY Camp.Stella_Target,InfoStella.numP;

--4.1° Selezione di Astronomi disponibili a intraprendere un nuovo progetti

DROP VIEW IF EXISTS UltCamp;
CREATE VIEW UltCamp(Astr,ult) as
   (SELECT A.CP Astr,
       MAX(IFNULL(C.DataOrario,0)) Ult
    FROM Astronomo A LEFT JOIN
      Campionatura C on C.Ricercatore=A.CP
    GROUP BY A.CP);

DROP VIEW IF EXISTS UltDoc;
CREATE VIEW UltDoc(Astr,ult) as
   (SELECT A1.CP Astr,
        MAX(IFNULL(D.Data_Pubblicazione,0)) Ult
   FROM Documentazione D, Scrittura S, Astronomo A1
   WHERE D.ID=S.ID_doc AND S.Ricercatore=A1.CP
    GROUP BY A1.CP);

DROP VIEW IF EXISTS AstronomiValidi;
CREATE VIEW AstronomiValidi(Astr) as
(SELECT IFNULL(UltCamp.Astr,UltDoc.Astr) as Astr
 FROM UltCamp LEFT JOIN UltDoc 
 ON UltDoc.Astr=UltCamp.Astr
 WHERE IFNULL(UltDoc.ult,0)>=
   IFNULL(UltCamp.ult,0));

--4.2° Proporre una collaborazione tra astronomi affini e capaci di gestire la collaborazione

DROP VIEW IF EXISTS AstrInterAssoc;
CREATE VIEW AstrInterAssoc(Astr) as
  (SELECT S1.Ricercatore
   FROM Scrittura S1, Scrittura S2, Astronomo A1, Astronomo A2
   WHERE S1.ID_doc=S2.ID_doc AND A1.CP=S1.Ricercatore AND
       A2.CP=S2.Ricercatore AND A1.Ufficio<>A2.Ufficio);

DROP VIEW IF EXISTS CorpiPerAstr; 
CREATE VIEW CorpiPerAstr(Astr,CorpoC) as
  (SELECT AV.Astr, D1.Oggetto
   FROM  AstronomiValidi AV , Scrittura as S, Documentazione as D1
   WHERE AV.Astr=S.Ricercatore AND S.ID_doc=D1.ID AND
      EXISTS(SELECT * FROM Scrittura S1, Scrittura S2
            WHERE S1.Ricercatore=AV.Astr AND S2.Ricercatore<>AV.Astr AND
                 S1.ID_doc=S2.ID_doc)
    GROUP BY AV.Astr, D1.Oggetto);

SELECT W.Astr1 Astronomo1, 
W.Astr2 Astronomo2, W.num CorpiComuni
FROM Astronomo A1, Astronomo A2,
(SELECT AA.Astr Astr1,BB.Astr Astr2, COUNT(AA.CorpoC) num
 FROM CorpiPerAstr AA, CorpiPerAstr BB
 WHERE AA.CorpoC=BB.CorpoC AND AA.Astr<>BB.Astr
 GROUP BY AA.Astr,BB.Astr) W
WHERE W.Astr1<W.Astr2 AND W.Astr1=A1.CP AND W.Astr2=A2.CP
   AND (A1.Ufficio=A2.Ufficio OR A1.CP in (SELECT * FROM AstrInterAssoc) OR
        A2.CP in (SELECT * FROM AstrInterAssoc) )       
ORDER BY num DESC
LIMIT 5;

--5° Statistiche sugli orari di lavoro negli osservatori

SELECT OIdA.Oss,OIdA.ID_doc,A.Nome 
FROM Astronomo A,
  (SELECT A.Ufficio Oss,DocMaxOra.ID ID_doc,MAX(A.Pos_Classifica) Astr 
   FROM Scrittura S,Astronomo A, 
     (SELECT MaxOra.Oss, D1.ID 
      FROM Documentazione D1, Scrittura S1, Astronomo A1,
        (SELECT A2.Ufficio Oss, MAX(TIME(D2.Data_Pubblicazione)) max 
         FROM Documentazione D2, Scrittura S2, Astronomo A2 
         WHERE D2.ID=S2.ID_doc AND S2.Ricercatore=A2.CP 
         GROUP BY A2.Ufficio) MaxOra 
      WHERE TIME(D1.Data_Pubblicazione)=MaxOra.max AND 
            D1.ID=S1.ID_doc AND S1.Ricercatore=A1.CP 
            AND A1.Ufficio=MaxOra.Oss ) DocMaxOra   
   WHERE S.Ricercatore=A.CP AND S.ID_doc=DocMaxOra.ID AND
     DocMaxOra.Oss=A.Ufficio 
   GROUP BY A.Ufficio,DocMaxOra.ID) OIdA    
WHERE A.Pos_Classifica=OIdA.Astr

--6° Solleciti per la pubblicazione dei documenti di scoperta tardivi

SET @DataPresente := '2020-01-01 00:00:00'; 
SELECT P.Nome NomePianeta,P.DataOra_Scoperta Scoperta,
   (CASE WHEN 
        ((UNIX_TIMESTAMP(@DataPresente)-
          UNIX_TIMESTAMP(P.DataOra_Scoperta)) >
         (SELECT AVG(UNIX_TIMESTAMP(D1.Data_Pubblicazione)-
                     UNIX_TIMESTAMP(P1.DataOra_Scoperta))
          FROM Pianeta P1, Documentazione D1
          WHERE  D1.ID=P1.Doc_Scoperta))    
    THEN 'ANORMALE' ELSE 'REGOLARE' END ) Situazione   
FROM Pianeta P
WHERE P.Doc_Scoperta is NULL;

-- Index
/*
Dalle ipotesi che: La relazione Documentazione contiene molte tuple, l’operazione di scrittura è un’operazione poco frequente (20 volte al giorno) rispetto alla lettura della documentazione che è molto frequente  (più di 1000 volte al giorno), si conclude che la creazione di un indice su Documentazione possa migliorare le performance di ricerca. 
L’attributo ID è più sfruttato rispetto agli altri attributi di documentazione perché riveste un ruolo maggiore nell’organizzazione funzionale del DB rispetto agli altri attributi che in modo separato rivestono funzioni utili maggiormente ad un livello applicativo. Quindi si è deciso di indicizzare in modo più mirato l’attributo ID.
*/

CREATE INDEX idx_ID_Documentazione ON Documentazione (ID);

/*
Dalle ipotesi che:
1) La relazione Scrittura contiene molte tuple
2) Essa funge da connettore molti a molti tra Astronomo e Documentazione quindi entrambi gli attributi costituiscono la chiave e vengono interpellati assieme (quindi distribuzione di overHead equa).
3) Le operazioni di tipo scrittura nella stessa sono meno frequenti rispetto alle letture (molto frequenti).
Si conclude che la creazione di un indice su Scrittura su tutta la relazione possa migliorare le performance di ricerca.
*/

CREATE INDEX idx_Scrittura ON Scrittura;
