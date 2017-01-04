

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `variables` longtext,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `name`, `variables`, `enabled`) VALUES
(1, 'homer', '{"grpmsg":"ici"}', 1),
(2, 'centrex', '{}', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `group`
--
ALTER TABLE `group`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `group_name` (`name`);


--
-- Database: `ansiblevoip`
--

-- --------------------------------------------------------

--
-- Table structure for table `host`
--

CREATE TABLE IF NOT EXISTS `host` (
`id` int(11) NOT NULL,
  `host` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `variables` longtext,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `host`
--

INSERT INTO `host` (`id`, `host`, `hostname`, `variables`, `enabled`) VALUES
(1, '1.1.1.1', 'HOMER36', '{"itemlist":["iotop","htop"]}', 1),
(2, '2.2.2.2', 'centrex1', '{}', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `host`
--
ALTER TABLE `host`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `host_host` (`host`), ADD UNIQUE KEY `host_hostname` (`hostname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `host`
--
ALTER TABLE `host`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

--
-- Database: `ansiblevoip`
--

-- --------------------------------------------------------

--
-- Table structure for table `hostgroups`
--

CREATE TABLE IF NOT EXISTS `hostgroups` (
`id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hostgroups`
--

INSERT INTO `hostgroups` (`id`, `host_id`, `group_id`) VALUES
(1, 1, 1),
(2, 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hostgroups`
--
ALTER TABLE `hostgroups`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `host_id` (`host_id`,`group_id`), ADD KEY `hostgroups_host_id` (`host_id`), ADD KEY `hostgroups_group_id` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hostgroups`
--
ALTER TABLE `hostgroups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `hostgroups`
--
ALTER TABLE `hostgroups`
ADD CONSTRAINT `hostgroups_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
ADD CONSTRAINT `hostgroups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`);

