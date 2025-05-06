-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 06, 2025 alle 13:09
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `game_zone`
--
CREATE DATABASE IF NOT EXISTS `game_zone` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `game_zone`;

-- --------------------------------------------------------

--
-- Struttura della tabella `giochi`
--

CREATE TABLE `giochi` (
  `id` int(10) UNSIGNED NOT NULL,
  `titolo` varchar(100) NOT NULL,
  `genere` varchar(30) NOT NULL,
  `anno_uscita` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `giochi`
--

INSERT INTO `giochi` (`id`, `titolo`, `genere`, `anno_uscita`) VALUES
(1, 'Celeste', 'Platformer', 2018),
(2, 'Cyberpunk 2077', 'Action RPG', 2020),
(3, 'Dead Cells', 'Roguelike/Metroidvania', 2018),
(4, 'Death Stranding', 'Action', 2019),
(5, 'Disco Elysium The Final Cut', 'RPG', 2021),
(6, 'Elden Ring', 'Action RPG', 2022),
(7, 'Forza Motorsport', 'Racing', 2023),
(8, 'Grand Theft Auto V', 'Action-adventure', 2013),
(9, 'Hades', 'Roguelike', 2020),
(10, 'Half Life Alyx', 'VR FPS', 2020),
(11, 'Hollow Knight', 'Metroidvania', 2017),
(12, 'No Mans Sky', 'Survival', 2016),
(13, 'Red Dead Redemption 2', 'Action-adventure', 2018),
(14, 'RimWorld', 'Simulation', 2018),
(15, 'Slay the Spire', 'Deck-building roguelike', 2019),
(16, 'Stardew Valley', 'Farming simulator', 2016),
(17, 'Subnautica', 'Survival', 2018),
(18, 'Terraria', 'Sandbox', 2011),
(19, 'The Last Of Us Part I', 'Action-adventure', 2022),
(20, 'The Witcher 3 Wild Hunt', 'Action RPG', 2015);

-- --------------------------------------------------------

--
-- Struttura della tabella `recensioni`
--

CREATE TABLE `recensioni` (
  `id` int(10) UNSIGNED NOT NULL,
  `gioco_id` int(10) UNSIGNED NOT NULL,
  `utente_id` int(10) UNSIGNED NOT NULL,
  `voto` smallint(6) NOT NULL,
  `commento` varchar(150) DEFAULT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `recensioni`
--

INSERT INTO `recensioni` (`id`, `gioco_id`, `utente_id`, `voto`, `commento`, `data`) VALUES
(1, 19, 11, 8, 'belloooooooooooooo', '2025-05-02'),
(2, 19, 11, 5, 'bruttoooooooooooooo', '2025-05-02'),
(3, 10, 11, 7, 'uoooooooooooooooooooooooooooooooooo\r\nnnn', '2025-05-02'),
(4, 13, 11, 5, 'blablablabkaj3nrjvke', '2025-05-02');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `username`, `email`, `password`, `active`) VALUES
(1, 'mario_rossi', 'mario.rossi@example.com', 'password123', 1),
(2, 'laura_bianchi', 'laura.b@mail.com', 'laura456', 1),
(3, 'giovanni_verdi', 'g.verdi@domain.net', 'verdi789', 0),
(4, 'sofia_neri', 'sofianeri@email.it', 'sofia000', 1),
(5, 'alex_smith', 'alex.smith@international.com', 'smith123', 0),
(6, 'chiara_bruni', 'cbruni@mailservice.org', 'bruni456', 1),
(7, 'francesco_esposito', 'francesco.e@webmail.it', 'francesco1', 1),
(8, 'elena_russo', 'erusso@company.eu', 'elena222', 0),
(9, 'david_johnson', 'd.johnson@global.net', 'david333', 1),
(10, 'anna_ferrari', 'anna.ferrari@emailbox.com', 'ferrari44', 0),
(11, 'matteo', 'matteocastelli1802@gmail.com', '12345', 1);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `giochi`
--
ALTER TABLE `giochi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `recensioni`
--
ALTER TABLE `recensioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gioco_id` (`gioco_id`),
  ADD KEY `utente_id` (`utente_id`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `giochi`
--
ALTER TABLE `giochi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la tabella `recensioni`
--
ALTER TABLE `recensioni`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `recensioni`
--
ALTER TABLE `recensioni`
  ADD CONSTRAINT `recensioni_ibfk_1` FOREIGN KEY (`gioco_id`) REFERENCES `giochi` (`id`),
  ADD CONSTRAINT `recensioni_ibfk_2` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
