DROP DATABASE IF EXISTS virtualgym;

CREATE DATABASE IF NOT EXISTS virtualgym;

USE virtualgym;

/* Creazione di tabelle nel database: Comando SQL CREATE TABLE */
CREATE TABLE Utente (
  	CodiceFiscale VARCHAR(16) PRIMARY KEY,
  	Nome VARCHAR(255) NOT NULL,
  	Cognome VARCHAR(255) NOT NULL,
  	DataNascita DATE NOT NULL,
  	Sesso ENUM('M', 'F'),
  	Username VARCHAR(255) NOT NULL UNIQUE,
  	Password VARCHAR(255) NOT NULL,
  	Email VARCHAR(255) NOT NULL UNIQUE,
  	DataRegistrazione DATE NOT NULL,
  	Telefono VARCHAR(32),
  	Indirizzo VARCHAR(255),
  	Tipo ENUM('Membro', 'Istruttore') NOT NULL
);

CREATE TABLE Istruttore (
  	CodiceFiscale VARCHAR(16),
  	Qualifiche VARCHAR(255),
  	Esperienza INT,
  	AreeCompetenze VARCHAR(255),
  	PRIMARY KEY (CodiceFiscale),
  	FOREIGN KEY (CodiceFiscale) REFERENCES Utente(CodiceFiscale)
);

CREATE TABLE Membro (
  	CodiceFiscale VARCHAR(16),
  	LivelloEsperienza ENUM('Principiante', 'Intermedio', 'Avanzato'),
  	ObiettiviFitness VARCHAR(255),
  	PRIMARY KEY (CodiceFiscale),
  	FOREIGN KEY (CodiceFiscale) REFERENCES Utente(CodiceFiscale)
);

CREATE TABLE ClasseOnline (
  	ID INT PRIMARY KEY AUTO_INCREMENT,
  	Nome VARCHAR(255) NOT NULL,
  	Istruttore VARCHAR(16),
  	Categoria VARCHAR(255),
  	Descrizione VARCHAR(255),
  	Prezzo DECIMAL (10,2) NOT NULL,
  	MaxPartecipanti INT,
  	FasceOrarie VARCHAR(255),
  	Stato ENUM('Attiva', 'In attesa di conferma', 'Cancellata'),
  	LinkPiattaforma VARCHAR(255) NOT NULL,
  	FOREIGN KEY (Istruttore) REFERENCES Istruttore(CodiceFiscale)
);

CREATE TABLE Allenamento (
  	Membro VARCHAR(16),
  	ClasseOnline INT,
  	Data DATE NOT NULL,
  	Durata INT NOT NULL,
  	CalorieBruciate INT NOT NULL,
  	Completato BOOLEAN NOT NULL,
  	FOREIGN KEY (Membro) REFERENCES Membro(CodiceFiscale),
  	FOREIGN KEY (ClasseOnline) REFERENCES ClasseOnline(ID),
  	PRIMARY KEY (Membro, ClasseOnline, Data)
);

CREATE TABLE Pagamento (
  	Tipo ENUM('Iscrizione', 'Mensile', 'Trimestrale', 'Semestrale', 'Annuale'),
  	ClasseOnline INT,
  	Data DATE NOT NULL,
  	MetodoPagamento ENUM('Carta di credito/debito', 'PayPal', 'Bonifico bancario', 'Portafoglio digitale','Altro') NOT NULL,
  	Importo DECIMAL(10,2) NOT NULL,
  	DataInizio DATE NOT NULL,
  	DataFine DATE NOT NULL,
  	Membro VARCHAR(16),
  	FOREIGN KEY (ClasseOnline) REFERENCES ClasseOnline(ID),
  	FOREIGN KEY (Membro) REFERENCES Membro(CodiceFiscale),
  	PRIMARY KEY (Membro, ClasseOnline, Data)
);

CREATE TABLE Feedback (
  	DataOra DATETIME DEFAULT CURRENT_TIMESTAMP, 
  	Commento VARCHAR(255),
  	Valutazione INT NOT NULL CHECK (Valutazione >= 1 AND Valutazione <= 10),
  	Membro VARCHAR(16),
  	ClasseOnline INT,
  	FOREIGN KEY (Membro) REFERENCES Membro(CodiceFiscale),
  	FOREIGN KEY (ClasseOnline) REFERENCES ClasseOnline(ID),
  	PRIMARY KEY (Membro, ClasseOnline, DataOra)
);

CREATE TABLE StatisticheAllenamento (
  	Membro VARCHAR(16),
  	AllenamentiTotali INT NOT NULL,
  	DurataTotale INT,
  	CalorieMedie INT,
  	UltimoAggiornamento DATETIME DEFAULT CURRENT_TIMESTAMP,
  	FOREIGN KEY (Membro) REFERENCES Membro(CodiceFiscale),
  	PRIMARY KEY (Membro, UltimoAggiornamento)
);

/* Inserimento di dati nel database: Comando SQL INSERT INTO */
INSERT INTO Utente (CodiceFiscale, Nome, Cognome, DataNascita, Sesso, Username, Password, Email, DataRegistrazione, Tipo)
VALUES ('CF1', 'Mario', 'Rossi', '1990-05-15', 'M', 'mario90', 'password123', 'mario@example.com', '2024-02-10', 'Membro'),
       ('CF2', 'Giulia', 'Verdi', '1995-09-22', 'F', 'giulia95', 'securepwd456', 'giulia@example.com', '2024-02-11', 'Membro'),
       ('CF3', 'Luca', 'Bianchi', '1988-11-30', 'M', 'luca88', 'strongpwd789', 'luca@example.com', '2024-02-12', 'Membro');


INSERT INTO Utente (CodiceFiscale, Nome, Cognome, DataNascita, Sesso, Username, Password, Email, DataRegistrazione, Tipo)
VALUES ('CF4', 'Laura', 'Neri', '1985-07-12', 'F', 'laura85', 'laura_pwd123', 'laura@example.com', '2023-04-15', 'Istruttore'),
       ('CF5', 'Alessio', 'Russo', '1980-04-25', 'M', 'alessio80', 'alessio_pwd456', 'alessio@example.com', '2023-05-20', 'Istruttore');



INSERT INTO Membro (CodiceFiscale, LivelloEsperienza, ObiettiviFitness)
VALUES ('CF1', 'Principiante', 'Aumentare la massa muscolare e migliorare la resistenza'),
	   ('CF2', 'Intermedio', 'Perdere peso e migliorare la forma fisica'),
       ('CF3', 'Avanzato', 'Partecipare a competizioni di bodybuilding e ottenere un corpo definito');


INSERT INTO Istruttore (CodiceFiscale, Qualifiche, Esperienza, AreeCompetenze)
VALUES ('CF4', 'Istruttrice di yoga', 5, 'Yoga, Meditazione'),
       ('CF5', 'Personal Trainer', 3, 'Fitness, Bodybuilding');


INSERT INTO ClasseOnline (Nome, Istruttore, Categoria, Descrizione, Prezzo, MaxPartecipanti, FasceOrarie, Stato, LinkPiattaforma)
VALUES ('Yoga Flow', 'CF4', 'Yoga', 'Classe di yoga per migliorare la flessibilità e la respirazione', 15.99, 20, 'Lunedì e Mercoledì 18:00-19:00', 'Attiva', 'https://virtualgym/yogaflow'),
('Total Body Workout', 'CF5', 'Fitness', 'Allenamento completo per tonificare tutti i muscoli del corpo', 12.50, 15, 'Martedì e Giovedì 19:00-20:00', 'Attiva', 'https://virtualgym/totalbodyworkout'),
('Powerlifting 101', 'CF5', 'Bodybuilding', 'Corso base di powerlifting per imparare le tecniche di sollevamento pesi', 19.99, 10, 'Lunedì, Mercoledì e Venerdì 20:00-21:00', 'In attesa di conferma', 'https://virtualgym/powerlifting101');


INSERT INTO Pagamento (Tipo, ClasseOnline, Data, MetodoPagamento, Importo, DataInizio, DataFine, Membro)
VALUES
('Mensile', 2, '2024-02-10', 'Carta di credito/debito', 17.50, '2024-02-10', '2024-03-10', 'CF1'),
('Semestrale', 1, '2024-02-11', 'Bonifico bancario', 110.00, '2024-02-13', '2024-08-13', 'CF2'),
('Trimestrale', 3, '2024-02-12', 'PayPal', 75.00, '2024-02-12', '2024-05-12', 'CF3');


INSERT INTO Allenamento (Membro, ClasseOnline, Data, Durata, CalorieBruciate, Completato)
VALUES ('CF1', 2, '2024-02-10', 60, 300, TRUE),
('CF2', 1, '2024-01-03', 60, 200, TRUE),
('CF3', 3, '2024-02-15', 45, 300, FALSE),
('CF3', 3, '2024-03-20', 60, 400, TRUE);


INSERT INTO Feedback (DataOra, Commento, Valutazione, Membro, ClasseOnline)
VALUES ('2024-02-10 20:30:00', 'Ottima classe, molto coinvolgente!', 9, 'CF1', 2),
('2024-01-03 19:15:00', 'Allenamento ben strutturato, consiglio!', 8, 'CF2', 1),
('2024-02-15 22:20:00', 'Mi aspettavo di più, forse necessita di miglioramenti.', 5, 'CF3', 3);


INSERT INTO StatisticheAllenamento (Membro, AllenamentiTotali, DurataTotale, CalorieMedie, UltimoAggiornamento)
VALUES ('CF1', 1, 60, 300, '2024-02-20 08:00:00'),
('CF2', 1, 60, 200, '2024-02-21 09:15:00'),
('CF3', 1, 45, 300, '2024-02-22 10:30:00'),
('CF3', 2, 105, 350, '2024-03-22 12:45:00');


/* Esempi di interrogazioni SQL: Utilizzo e Sintassi */
SELECT U.Nome, U.Cognome, S.AllenamentiTotali, S.DurataTotale, S.CalorieMedie
FROM Membro M
JOIN Utente U ON M.CodiceFiscale = U.CodiceFiscale
JOIN (
    SELECT Membro, AllenamentiTotali, DurataTotale, CalorieMedie
    FROM StatisticheAllenamento 
    WHERE (Membro, UltimoAggiornamento) IN (
        SELECT Membro, MAX(UltimoAggiornamento) AS UltimoAggiornamento
        FROM StatisticheAllenamento
        GROUP BY Membro
    )
) AS S ON M.CodiceFiscale = S.Membro;


SELECT U.Nome, U.Cognome, P.Tipo, P.Importo, P.Data
FROM Membro M
JOIN Utente U ON M.CodiceFiscale = U.CodiceFiscale
JOIN Pagamento P ON M.CodiceFiscale = P.Membro
WHERE P.Tipo = 'Trimestrale' OR P.Tipo = "Semestrale"; 


SELECT U.Nome, U.Cognome, C.Nome AS "Nome classe", C.Categoria
FROM Membro M
JOIN Utente U ON M.CodiceFiscale = U.CodiceFiscale
JOIN Pagamento P ON M.CodiceFiscale = P.Membro
JOIN ClasseOnline C ON P.ClasseOnline = C.ID;

SELECT U.Nome AS "Nome istruttore", I.Qualifiche, C.Nome AS "Nome classe", C.Categoria, C.Descrizione, C.Stato
FROM Utente U
JOIN Istruttore I on I.CodiceFiscale = U.CodiceFiscale
JOIN ClasseOnline C ON I.CodiceFiscale = C.Istruttore;


SELECT I.CodiceFiscale, concat(U.Nome, ' ' , U.Cognome) AS "Nome completo", COUNT(C.ID) AS "Numero classi"
FROM Utente U
JOIN Istruttore I on U.CodiceFiscale = I.CodiceFiscale
LEFT JOIN ClasseOnline C ON I.CodiceFiscale = C.Istruttore
GROUP BY I.CodiceFiscale, concat(U.Nome, ' ' , U.Cognome);


/* Esempio Trigger: */
DELIMITER //

CREATE TRIGGER aggiorna_statistiche_allenamento
AFTER INSERT ON Allenamento
FOR EACH ROW
BEGIN
    DECLARE num_allenamenti_totali INT;
    DECLARE durata_totale INT;
    DECLARE calorie_medie INT;
    
    -- Trova il numero totale di allenamenti per il membro
    SELECT COUNT(*) INTO num_allenamenti_totali
    FROM Allenamento
    WHERE Membro = NEW.Membro;

    -- Trova la durata totale degli allenamenti per il membro
    SELECT SUM(Durata) INTO durata_totale
    FROM Allenamento
    WHERE Membro = NEW.Membro;

    -- Trova le calorie medie degli allenamenti per il membro
    SELECT AVG(CalorieBruciate) INTO calorie_medie
    FROM Allenamento
    WHERE Membro = NEW.Membro;

    -- Aggiorna le statistiche di allenamento se il membro è già presente
    UPDATE StatisticheAllenamento
    SET AllenamentiTotali = num_allenamenti_totali,
        DurataTotale = durata_totale,
        CalorieMedie = calorie_medie,
        UltimoAggiornamento = NOW()
    WHERE Membro = NEW.Membro;

    -- Inserisci le statistiche di allenamento se il membro non è presente
    IF ROW_COUNT() = 0 THEN
        INSERT INTO StatisticheAllenamento (Membro, AllenamentiTotali, DurataTotale, CalorieMedie, UltimoAggiornamento)
        VALUES (NEW.Membro, num_allenamenti_totali, durata_totale, calorie_medie, NOW());
    END IF;
END//

DELIMITER ;
