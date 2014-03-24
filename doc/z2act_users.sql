/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Version : 50150
 Source Host           : localhost
 Source Database       : grart_cn

 Target Server Version : 50150
 File Encoding         : utf-8

 Date: 03/24/2014 09:36:44 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `z2act_users`
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` timestamp NOT NULL DEFAULT '2014-02-01 00:00:00',
  `lastvisitDate` timestamp NOT NULL DEFAULT '2014-02-01 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` timestamp NOT NULL DEFAULT '2014-02-01 00:00:00',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  `usertype` varchar(45) NOT NULL,
  `thumbnail` int(11) DEFAULT '0',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=737 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `z2act_users`
-- ----------------------------
BEGIN;
INSERT INTO `admins` VALUES ('698', 'Super User', 'admin', 'jiangfanglu@hotmail.com', '9931e10f8bbe08cfdf577011cd00080a:wzFnDEEPkTb3UJHGKgyFAMQyGkEGBANC', '0', '1', '2014-03-01 00:00:00', '2014-03-01 00:00:00', '0', '', '2014-03-01 00:00:00', '0', '1', null, null), ('730', '木木', 'panpan9066@126.com', 'panpan9066@126.com', 'def3d8101f7fbd5e9734349c520b4690580dd0117378b36b438510f90a1b2b82', '0', '1', '2014-03-17 05:14:29', '2014-03-17 05:14:29', '1', '', '2014-03-17 05:14:29', '0', '1', '1', '8468a860cec599abb7e169af210139a0a019c8d8497ad6650944429734fdabb0'), ('731', 'leon', 'leon.zcf@gmail.com', 'leon.zcf@gmail.com', '3188a89b1073594529616a1e34320b321b4b14c0709d6611b50a6a844e795c13', '0', '1', '2014-03-17 05:19:15', '2014-03-17 05:19:15', '1', '', '2014-03-17 05:19:15', '0', '1', '0', '4bba080cdd8ba0489a223d3154d7fc6a55359eb67b7f0702dbdac9aa3e07669d'), ('732', '沙罗檀华', 'coronaliuyuwei@163.com', 'coronaliuyuwei@163.com', 'c53b43630c7eee7383aa6a97d877bce3209184b89e70802d30ac7bdecfc4f6ca', '0', '1', '2014-03-17 05:21:42', '2014-03-17 05:21:42', '1', '', '2014-03-17 05:21:42', '0', '1', '0', '3583b45fcc732b5a2cc618ed4f05a72f863d2aa4c7abfd7d230a969e3ac2fbe1'), ('733', '姜方路', 'fanglu.jiang@1shoo.com', 'fanglu.jiang@1shoo.com', '79e15ef4dd77750fa749929611b2bb87e014ef475a5f12f96299faff7d2f7f67', '0', '1', '2014-03-17 06:16:17', '2014-03-17 06:16:17', '1', '', '2014-03-17 06:16:17', '0', '1', '1', '15c92128ab4f92412e91cb001f3d7da4fb51006b564c8ed499577ae74d14d2ad'), ('734', 'test', '710458561@qq.com', '710458561@qq.com', '9355aac796553906e61a04f04c3527311623d9fe047937bc08c3ebb847d1d499', '0', '1', '2014-03-17 06:20:27', '2014-03-17 06:20:27', '1', '', '2014-03-17 06:20:27', '0', '1', '1', '48b75e87dfe22b7210dd42dcdc20ace4030fb2dc7da370e053887996bd5dda32'), ('735', 'prings', 'prings@qq.com', 'prings@qq.com', 'fea2489d72a406b17eac42b5d973b302788c690da0c24b917ef5c937c3ed7fd0', '0', '1', '2014-03-17 06:25:59', '2014-03-17 06:25:59', '1', '', '2014-03-17 06:25:59', '0', '1', '1', '040452a745e65c33f282f611c0f48ef55f693bca8a45df9a5d5727aa1cb776ed'), ('736', '乔布斯', '229174926@qq.com', '229174926@qq.com', '0fadf3d0df4fd27fddb6884bd3ab10263a035aced0fd8ce44cc76e64b9e1a930', '0', '1', '2014-03-18 05:57:34', '2014-03-18 05:57:34', '1', '', '2014-03-18 05:57:34', '0', '0', '0', '4b4a893cb36910db65820e727f3a60f6319cf98fa84d83a11dc914cec6fe7923');
COMMIT;

