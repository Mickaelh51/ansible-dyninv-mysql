--
-- Structure de la table `childgroups`
--

CREATE TABLE IF NOT EXISTS `childgroups` (
`id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `children`
--
CREATE TABLE IF NOT EXISTS `children` (
`parent` varchar(255)
,`child` varchar(255)
);
-- --------------------------------------------------------

--
-- Structure de la table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `group`
--

INSERT INTO `group` (`id`, `name`, `enabled`) VALUES
(1, 'group1', 1),
(2, 'group2', 1),
(3, 'group3', 1);

-- --------------------------------------------------------

--
-- Structure de la table `groupvars`
--

CREATE TABLE IF NOT EXISTS `groupvars` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `groupvars`
--

INSERT INTO `groupvars` (`id`, `name`, `value`, `group_id`, `enabled`) VALUES
(1, 'grpmsg', 'ici,pasla,test1', 1, 1),
(3, 'test2', 'var2', 1, 1),
(4, 'test3', 'var3', 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `host`
--

CREATE TABLE IF NOT EXISTS `host` (
`id` int(11) NOT NULL,
  `host` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `host`
--

INSERT INTO `host` (`id`, `host`, `hostname`, `enabled`) VALUES
(1, '1.1.1.1', 'Host1', 1),
(2, '2.2.2.2', 'Host2', 1),
(3, '3.3.3.3', 'Host3', 1),
(4, '4.4.4.4', 'Host4', 1);

-- --------------------------------------------------------

--
-- Structure de la table `hostgroups`
--

CREATE TABLE IF NOT EXISTS `hostgroups` (
`id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `hostgroups`
--

INSERT INTO `hostgroups` (`id`, `host_id`, `group_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `hostvars`
--

CREATE TABLE IF NOT EXISTS `hostvars` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `hostvars`
--

INSERT INTO `hostvars` (`id`, `name`, `value`, `enabled`) VALUES
(1, 'itemlist2', 'iotop,htop2', 1),
(2, 'itemlist', 'iotop,htop', 1),
(3, 'itemhomer5', 'toto', 1),
(4, 'hostname', 'hostmika', 1);

-- --------------------------------------------------------

--
-- Structure de la table `hostvarsjoin`
--

CREATE TABLE IF NOT EXISTS `hostvarsjoin` (
`id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  `hostvars_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `hostvarsjoin`
--

INSERT INTO `hostvarsjoin` (`id`, `host_id`, `hostvars_id`) VALUES
(1, 1, 1),
(3, 1, 2),
(2, 2, 2),
(4, 3, 3),
(5, 4, 2),
(6, 4, 4);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `inventory`
--
CREATE TABLE IF NOT EXISTS `inventory` (
`group` varchar(255)
,`host` varchar(255)
,`hostname` varchar(255)
,`hostvars_name` varchar(255)
,`hostvars_value` varchar(200)
);
-- --------------------------------------------------------

--
-- Structure de la vue `children`
--
DROP TABLE IF EXISTS `children`;

CREATE ALGORITHM=UNDEFINED DEFINER=`*******` SQL SECURITY DEFINER VIEW `children` AS select `gparent`.`name` AS `parent`,`gchild`.`name` AS `child` from ((`childgroups` left join `group` `gparent` on((`childgroups`.`parent_id` = `gparent`.`id`))) left join `group` `gchild` on((`childgroups`.`child_id` = `gchild`.`id`))) order by `gparent`.`name`;

-- --------------------------------------------------------

--
-- Structure de la vue `inventory`
--
DROP TABLE IF EXISTS `inventory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`******` SQL SECURITY DEFINER VIEW `inventory` AS select `group`.`name` AS `group`,`host`.`host` AS `host`,`host`.`hostname` AS `hostname`,`hostvars`.`name` AS `hostvars_name`,`hostvars`.`value` AS `hostvars_value` from (`hostvars` left join (`hostvarsjoin` left join (`host` left join (`group` left join `hostgroups` on((`hostgroups`.`group_id` = `group`.`id`))) on((`host`.`id` = `hostgroups`.`host_id`))) on((`hostvarsjoin`.`host_id` = `host`.`id`))) on((`hostvars`.`id` = `hostvarsjoin`.`hostvars_id`))) where ((`group`.`enabled` = 1) and (`host`.`enabled` = 1) and (`hostvars`.`enabled` = 1)) order by `host`.`host`;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `childgroups`
--
ALTER TABLE `childgroups`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `childid` (`child_id`,`parent_id`), ADD KEY `childgroups_child_id` (`child_id`), ADD KEY `childgroups_parent_id` (`parent_id`);

--
-- Index pour la table `group`
--
ALTER TABLE `group`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `group_name` (`name`);

--
-- Index pour la table `groupvars`
--
ALTER TABLE `groupvars`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `host`
--
ALTER TABLE `host`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `host_host` (`host`), ADD UNIQUE KEY `host_hostname` (`hostname`);

--
-- Index pour la table `hostgroups`
--
ALTER TABLE `hostgroups`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `host_id` (`host_id`,`group_id`), ADD KEY `hostgroups_host_id` (`host_id`), ADD KEY `hostgroups_group_id` (`group_id`);

--
-- Index pour la table `hostvars`
--
ALTER TABLE `hostvars`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hostvarsjoin`
--
ALTER TABLE `hostvarsjoin`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `host_id` (`host_id`,`hostvars_id`), ADD KEY `hotvars_host_id` (`host_id`), ADD KEY `hostvars_group_id` (`hostvars_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `childgroups`
--
ALTER TABLE `childgroups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `group`
--
ALTER TABLE `group`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `groupvars`
--
ALTER TABLE `groupvars`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `host`
--
ALTER TABLE `host`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `hostgroups`
--
ALTER TABLE `hostgroups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `hostvars`
--
ALTER TABLE `hostvars`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `hostvarsjoin`
--
ALTER TABLE `hostvarsjoin`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `childgroups`
--
ALTER TABLE `childgroups`
ADD CONSTRAINT `childgroups_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `group` (`id`),
ADD CONSTRAINT `childgroups_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `group` (`id`);

--
-- Contraintes pour la table `hostgroups`
--
ALTER TABLE `hostgroups`
ADD CONSTRAINT `hostgroups_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
ADD CONSTRAINT `hostgroups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`);

--
-- Contraintes pour la table `hostvarsjoin`
--
ALTER TABLE `hostvarsjoin`
ADD CONSTRAINT `hostvars_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
ADD CONSTRAINT `hostvars_ibfk_2` FOREIGN KEY (`hostvars_id`) REFERENCES `hostvars` (`id`);

