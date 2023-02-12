SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

UPDATE securitycurrency SET id_connector_intra = null WHERE id_connector_intra = "gt.datafeed.swissquote" OR id_connector_intra = "gt.datafeed.alphavantage";
UPDATE securitycurrency SET id_connector_history = "gt.datafeed.exchangeratehosts", retry_history_load = 0 WHERE id_connector_history = "gt.datafeed.investing" AND dtype = "C"; 
UPDATE securitycurrency sc JOIN security s ON sc.id_securitycurrency = s.id_securitycurrency SET sc.id_connector_history = "gt.datafeed.yahoo", sc.retry_history_load = 0, sc.url_history_extend = sc.url_intra_extend WHERE sc.id_connector_history = "gt.datafeed.investing" AND (sc.id_connector_intra = "gt.datafeed.yahoo" OR sc.id_connector_intra = "gt.datafeed.finnhub" ) AND s.active_to_date > "2022-10-01";

DROP TABLE IF EXISTS `gt_net_message_param`;
DROP TABLE IF EXISTS `gt_net_message`;
DROP TABLE IF EXISTS `gt_net_message_answer`;

CREATE TABLE `gt_net_message` (
  `id_gt_net_message` int(11) NOT NULL,
  `id_gt_net` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `send_recv` tinyint(1) NOT NULL,
  `reply_to` int(11) DEFAULT NULL,
  `message_code` smallint(6) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `has_been_read` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `gt_net_message_answer` (
  `request_msg_code` smallint(6) NOT NULL,
  `response_msg_code1` smallint(6) NOT NULL,
  `response_msg_conditional1` varchar(256) DEFAULT NULL,
  `response_msg_message1` varchar(1024) DEFAULT NULL,
  `response_msg_code2` smallint(6) DEFAULT NULL,
  `response_msg_conditional2` varchar(256) DEFAULT NULL,
  `response_msg_message2` varchar(1024) DEFAULT NULL,
  `response_msg_code3` smallint(6) DEFAULT NULL,
  `response_msg_conditional3` varchar(256) DEFAULT NULL,
  `response_msg_message3` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `gt_net_message_param` (
  `id_gt_net_message` int(11) NOT NULL,
  `param_name` varchar(32) NOT NULL,
  `param_value` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `gt_net_message`
--
ALTER TABLE `gt_net_message`
  ADD PRIMARY KEY (`id_gt_net_message`),
  ADD KEY `FK_GtNetMessage_GtNet` (`id_gt_net`),
  ADD KEY `FK_GtNetMessage_GtNetMessage` (`reply_to`);

--
-- Indizes für die Tabelle `gt_net_message_answer`
--
ALTER TABLE `gt_net_message_answer`
  ADD PRIMARY KEY (`request_msg_code`);

--
-- Indizes für die Tabelle `gt_net_message_param`
--
ALTER TABLE `gt_net_message_param`
  ADD PRIMARY KEY (`id_gt_net_message`,`param_name`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `gt_net_message`
--
ALTER TABLE `gt_net_message`
  MODIFY `id_gt_net_message` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `gt_net_message`
--
ALTER TABLE `gt_net_message`
  ADD CONSTRAINT `FK_GtNetMessage_GtNet` FOREIGN KEY (`id_gt_net`) REFERENCES `gt_net` (`id_gt_net`),
  ADD CONSTRAINT `FK_GtNetMessage_GtNetMessage` FOREIGN KEY (`reply_to`) REFERENCES `gt_net_message` (`id_gt_net_message`);

--
-- Constraints der Tabelle `gt_net_message_param`
--
ALTER TABLE `gt_net_message_param`
  ADD CONSTRAINT `FK_GTNetMessageParam_GTNetMessage` FOREIGN KEY (`id_gt_net_message`) REFERENCES `gt_net_message` (`id_gt_net_message`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
