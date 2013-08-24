# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.29)
# Database: magento
# Generation Time: 2013-08-24 14:52:56 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table mg_admin_assert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_admin_assert`;

CREATE TABLE `mg_admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table';



# Dump of table mg_admin_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_admin_role`;

CREATE TABLE `mg_admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_MG_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_MG_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';

LOCK TABLES `mg_admin_role` WRITE;
/*!40000 ALTER TABLE `mg_admin_role` DISABLE KEYS */;

INSERT INTO `mg_admin_role` (`role_id`, `parent_id`, `tree_level`, `sort_order`, `role_type`, `user_id`, `role_name`)
VALUES
	(1,0,1,1,'G',0,'Administrators'),
	(2,1,2,0,'U',1,'Aurimas');

/*!40000 ALTER TABLE `mg_admin_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_admin_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_admin_rule`;

CREATE TABLE `mg_admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MG_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_MG_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_MG_ADMIN_RULE_ROLE_ID_MG_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `mg_admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';

LOCK TABLES `mg_admin_rule` WRITE;
/*!40000 ALTER TABLE `mg_admin_rule` DISABLE KEYS */;

INSERT INTO `mg_admin_rule` (`rule_id`, `role_id`, `resource_id`, `privileges`, `assert_id`, `role_type`, `permission`)
VALUES
	(1,1,'all',NULL,0,'G','allow');

/*!40000 ALTER TABLE `mg_admin_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_admin_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_admin_user`;

CREATE TABLE `mg_admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(40) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_MG_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin User Table';

LOCK TABLES `mg_admin_user` WRITE;
/*!40000 ALTER TABLE `mg_admin_user` DISABLE KEYS */;

INSERT INTO `mg_admin_user` (`user_id`, `firstname`, `lastname`, `email`, `username`, `password`, `created`, `modified`, `logdate`, `lognum`, `reload_acl_flag`, `is_active`, `extra`, `rp_token`, `rp_token_created_at`)
VALUES
	(1,'Aurimas','Aurimas','aurimasdgt@gmail.com','aurimasdgt','fecedf5f354f250b34840b65fecddf3a:ck','2013-08-24 16:32:54','2013-08-09 22:44:35','2013-08-24 13:32:54',23,0,1,'a:1:{s:11:\"configState\";a:4:{s:15:\"general_country\";s:1:\"0\";s:14:\"general_region\";s:1:\"0\";s:14:\"general_locale\";s:1:\"1\";s:25:\"general_store_information\";s:1:\"0\";}}',NULL,NULL);

/*!40000 ALTER TABLE `mg_admin_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_adminnotification_inbox
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_adminnotification_inbox`;

CREATE TABLE `mg_adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_MG_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_MG_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_MG_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';

LOCK TABLES `mg_adminnotification_inbox` WRITE;
/*!40000 ALTER TABLE `mg_adminnotification_inbox` DISABLE KEYS */;

INSERT INTO `mg_adminnotification_inbox` (`notification_id`, `severity`, `date_added`, `title`, `description`, `url`, `is_read`, `is_remove`)
VALUES
	(1,4,'2008-07-25 05:24:40','Magento 1.1 Production Version Now Available','We are thrilled to announce the availability of the production release of Magento 1.1. Read more about the release in the Magento Blog.','http://www.magentocommerce.com/blog/comments/magento-11-is-here-1/',1,0),
	(2,4,'2008-08-02 05:30:16','Updated iPhone Theme is now available','Updated iPhone theme for Magento 1.1 is now available on Magento Connect and for upgrade through your Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/updated-iphone-theme-for-magento-11-is-now-available/',1,0),
	(3,3,'2008-08-02 05:40:27','Magento version 1.1.2 is now available','Magento version 1.1.2 is now available for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-version-112-is-now-available/',1,0),
	(4,3,'2008-08-13 21:51:46','Magento version 1.1.3 is now available','Magento version 1.1.3 is now available','http://www.magentocommerce.com/blog/comments/magento-version-113-is-now-available/',1,0),
	(5,1,'2008-09-03 01:10:31','Magento Version 1.1.4 Security Update Now Available','Magento 1.1.4 Security Update Now Available. If you are using Magento version 1.1.x, we highly recommend upgrading to this version as soon as possible.','http://www.magentocommerce.com/blog/comments/magento-version-114-security-update/',1,0),
	(6,3,'2008-09-16 02:09:54','Magento version 1.1.5 Now Available','Magento version 1.1.5 Now Available.\n\nThis release includes many bug fixes, a new category manager and a new skin for the default Magento theme.','http://www.magentocommerce.com/blog/comments/magento-version-115-now-available/',1,0),
	(7,3,'2008-09-18 00:18:35','Magento version 1.1.6 Now Available','Magento version 1.1.6 Now Available.\n\nThis version includes bug fixes for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-116-now-available/',1,0),
	(8,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.',NULL,1,0),
	(9,3,'2008-11-20 06:31:12','Magento version 1.1.7 Now Available','Magento version 1.1.7 Now Available.\n\nThis version includes over 350 issue resolutions for Magento 1.1.x that are listed in the release notes section, and new functionality that includes:\n\n-Google Website Optimizer integration\n-Google Base integration\n-Scheduled DB logs cleaning option','http://www.magentocommerce.com/blog/comments/magento-version-117-now-available/',1,0),
	(10,3,'2008-11-27 02:24:50','Magento Version 1.1.8 Now Available','Magento version 1.1.8 now available.\n\nThis version includes some issue resolutions for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-118-now-available/',1,0),
	(11,3,'2008-12-30 12:45:59','Magento version 1.2.0 is now available for download and upgrade','We are extremely happy to announce the availability of Magento version 1.2.0 for download and upgrade.\n\nThis version includes numerous issue resolutions for Magento version 1.1.x and some highly requested new features such as:\n\n    * Support for Downloadable/Digital Products. \n    * Added Layered Navigation to site search result page.\n    * Improved site search to utilize MySQL fulltext search\n    * Added support for fixed-taxes on product level.\n    * Upgraded Zend Framework to the latest stable version 1.7.2','http://www.magentocommerce.com/blog/comments/magento-version-120-is-now-available/',1,0),
	(12,2,'2008-12-31 02:59:22','Magento version 1.2.0.1 now available','Magento version 1.2.0.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1201-available/',1,0),
	(13,2,'2009-01-13 01:41:49','Magento version 1.2.0.2 now available','Magento version 1.2.0.2 is now available for download and upgrade. This version includes an issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1202-now-available/',1,0),
	(14,3,'2009-01-24 05:25:56','Magento version 1.2.0.3 now available','Magento version 1.2.0.3 is now available for download and upgrade. This version includes issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1203-now-available/',1,0),
	(15,3,'2009-02-03 02:57:00','Magento version 1.2.1 is now available for download and upgrade','We are happy to announce the availability of Magento version 1.2.1 for download and upgrade.\n\nThis version includes some issue resolutions for Magento version 1.2.x. A full list of items included in this release can be found on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-121-now-available/',1,0),
	(16,3,'2009-02-24 05:45:47','Magento version 1.2.1.1 now available','Magento version 1.2.1.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1211-now-available/',1,0),
	(17,3,'2009-02-27 06:39:24','CSRF Attack Prevention','We have just posted a blog entry about a hypothetical CSRF attack on a Magento admin panel. Please read the post to find out if your Magento installation is at risk at http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/','http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/',1,0),
	(18,2,'2009-03-04 04:03:58','Magento version 1.2.1.2 now available','Magento version 1.2.1.2 is now available for download and upgrade.\nThis version includes some updates to improve admin security as described in the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-1212-now-available/',1,0),
	(19,3,'2009-03-31 06:22:40','Magento version 1.3.0 now available','Magento version 1.3.0 is now available for download and upgrade. This version includes numerous issue resolutions for Magento version 1.2.x and new features as described on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-130-is-now-available/',1,0),
	(20,3,'2009-04-18 08:06:02','Magento version 1.3.1 now available','Magento version 1.3.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and new features such as Checkout By Amazon and Amazon Flexible Payment. To see a full list of updates please check the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-131-now-available/',1,0),
	(21,3,'2009-05-20 02:31:21','Magento version 1.3.1.1 now available','Magento version 1.3.1.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and a security update for Magento installations that run on multiple domains or sub-domains. If you are running Magento with multiple domains or sub-domains we highly recommend upgrading to this version.','http://www.magentocommerce.com/blog/comments/magento-version-1311-now-available/',1,0),
	(22,3,'2009-05-30 02:54:06','Magento version 1.3.2 now available','This version includes some improvements and issue resolutions for version 1.3.x that are listed on the release notes page. also included is a Beta version of the Compile module.','http://www.magentocommerce.com/blog/comments/magento-version-132-now-available/',1,0),
	(23,3,'2009-06-01 23:32:52','Magento version 1.3.2.1 now available','Magento version 1.3.2.1 now available for download and upgrade.\n\nThis release solves an issue for users running Magento with PHP 5.2.0, and changes to index.php to support the new Compiler Module.','http://www.magentocommerce.com/blog/comments/magento-version-1321-now-available/',1,0),
	(24,3,'2009-07-02 05:21:44','Magento version 1.3.2.2 now available','Magento version 1.3.2.2 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1322-now-available/',1,0),
	(25,3,'2009-07-23 10:48:54','Magento version 1.3.2.3 now available','Magento version 1.3.2.3 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. We recommend to upgrade to this version if PayPal payment modules are in use. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1323-now-available/',1,0),
	(26,4,'2009-08-28 22:26:28','PayPal is updating Payflow Pro and Website Payments Pro (Payflow Edition) UK.','If you are using Payflow Pro and/or Website Payments Pro (Payflow Edition) UK.  payment methods, you will need to update the URLâ€˜s in your Magento Administrator Panel in order to process transactions after September 1, 2009. Full details are available here: http://www.magentocommerce.com/wiki/paypal_payflow_changes','http://www.magentocommerce.com/wiki/paypal_payflow_changes',1,0),
	(27,2,'2009-09-24 00:16:49','Magento Version 1.3.2.4 Security Update','Magento Version 1.3.2.4 is now available. This version includes a security updates for Magento 1.3.x that solves possible XSS vulnerability issue on customer registration page and is available through SVN, Download Page and through the Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-version-1324-security-update/',1,0),
	(28,4,'2009-09-25 18:57:54','Magento Preview Version 1.4.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha2-now-available/',1,0),
	(29,4,'2009-10-07 04:55:40','Magento Preview Version 1.4.0.0-alpha3 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha3 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha3-now-available/',1,0),
	(30,4,'2009-12-09 04:30:36','Magento Preview Version 1.4.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-beta1-now-available/',1,0),
	(31,4,'2009-12-31 14:22:12','Magento Preview Version 1.4.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-rc1-now-available/',1,0),
	(32,4,'2010-02-13 08:39:53','Magento CE Version 1.4.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.0.0 Stable for upgrade and download.','http://bit.ly/c53rpK',1,0),
	(33,3,'2010-02-20 07:39:36','Magento CE Version 1.4.0.1 Stable is now available','Magento CE 1.4.0.1 Stable is now available for upgrade and download.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1401-stable-now-available/',1,0),
	(34,4,'2010-04-24 00:09:03','Magento Version CE 1.3.3.0 Stable - Now Available With Support for 3-D Secure','Based on community requests, we are excited to announce the release of Magento CE 1.3.3.0-Stable with support for 3-D Secure. This release is intended for Magento merchants using version 1.3.x, who want to add support for 3-D Secure.','http://www.magentocommerce.com/blog/comments/magento-version-ce-1330-stable-now-available-with-support-for-3-d-secure/',1,0),
	(35,4,'2010-05-31 21:20:21','Announcing the Launch of Magento Mobile','The Magento team is pleased to announce the launch of Magento mobile, a new product that will allow Magento merchants to easily create branded, native mobile storefront applications that are deeply integrated with Magentoâ€™s market-leading eCommerce platform. The product includes a new administrative manager, a native iPhone app that is fully customizable, and a service where Magento manages the submission and maintenance process for the iTunes App Store.\n\nLearn more by visiting the Magento mobile product page and sign-up to be the first to launch a native mobile commerce app, fully integrated with Magento.','http://www.magentocommerce.com/product/mobile',1,0),
	(36,4,'2010-06-11 00:08:08','Magento CE Version 1.4.1.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.0 Stable for upgrade and download. Some of the highlights of this release include: Enhanced PayPal integration (more info to follow), Change of Database structure of the Sales module to no longer use EAV, and much more.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1410-stable-now-available/',1,0),
	(37,4,'2010-07-27 01:37:34','Magento CE Version 1.4.1.1 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-now-available/',1,0),
	(38,4,'2010-07-28 09:12:12','Magento CE Version 1.4.2.0-beta1 Preview Release Now Available','This release gives a preview of the new Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-beta1-now-available/',1,0),
	(39,4,'2010-07-29 00:15:01','Magento CE Version 1.4.1.1 Patch Available','As some users experienced issues with upgrading to CE 1.4.1.1 through PEAR channels we provided a patch for it that is available on our blog http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/',1,0),
	(40,4,'2010-10-12 04:13:25','Magento Mobile is now live!','Magento Mobile is now live! Signup today to have your own native iPhone mobile-shopping app in iTunes for the holiday season! Learn more at http://www.magentomobile.com/','http://www.magentomobile.com/',1,0),
	(41,4,'2010-11-09 02:52:06','Magento CE Version 1.4.2.0-RC1 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC1 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc1-now-available/',1,0),
	(42,4,'2010-12-03 01:33:00','Magento CE Version 1.4.2.0-RC2 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC2 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc2-now-available/',1,0),
	(43,4,'2010-12-09 03:29:55','Magento CE Version 1.4.2.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1420-stable-now-available/',1,0),
	(44,4,'2010-12-18 04:23:55','Magento Preview Version CE 1.5.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha1-now-available/',1,0),
	(45,4,'2010-12-30 04:51:08','Magento Preview Version CE 1.5.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha2-now-available/',1,0),
	(46,4,'2011-01-14 05:35:36','Magento Preview Version CE 1.5.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta1-now-available/',1,0),
	(47,4,'2011-01-22 02:19:09','Magento Preview Version CE 1.5.0.0-beta2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta2-now-available/',1,0),
	(48,4,'2011-01-28 02:27:57','Magento Preview Version CE 1.5.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc1-now-available/',1,0),
	(49,4,'2011-02-04 02:56:33','Magento Preview Version CE 1.5.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc2-now-available/',1,0),
	(50,4,'2011-02-09 00:43:23','Magento CE Version 1.5.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.5.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-community-professional-and-enterprise-editions-releases-now-availab/',1,0),
	(51,4,'2011-02-10 04:42:57','Magento CE 1.5.0.1 stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.0.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-1501-stable-now-available/',1,0),
	(52,4,'2011-03-19 00:15:45','Magento CE 1.5.1.0-beta1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-beta1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-beta1-now-available/',1,0),
	(53,4,'2011-03-31 22:43:02','Magento CE 1.5.1.0-rc1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-rc1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-rc1-now-available/',1,0),
	(54,4,'2011-04-26 23:21:07','Magento CE 1.5.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1510-stable-now-available/',1,0),
	(55,4,'2011-05-26 23:33:23','Magento Preview Version CE 1.6.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-alpha1-now-available/',1,0),
	(56,4,'2011-06-15 22:12:08','Magento Preview Version CE 1.6.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-beta1for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-beta1-now-available/',1,0),
	(57,4,'2011-06-30 23:03:58','Magento Preview Version CE 1.6.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc1-now-available/',1,0),
	(58,4,'2011-07-11 23:07:39','Magento Preview Version CE 1.6.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc2-now-available/',1,0),
	(59,4,'2011-08-19 21:58:31','Magento CE 1.6.0.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1600-stable-now-available/',1,0),
	(60,4,'2011-09-17 05:31:26','Magento Preview Version CE 1.6.1.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-beta1-now-available/',1,0),
	(61,4,'2011-09-29 19:44:10','Magento Preview Version CE 1.6.1.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-rc1-now-available/',1,0),
	(62,4,'2011-10-19 21:50:05','Magento CE 1.6.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1610-stable-now-available/',1,0),
	(63,4,'2011-12-30 22:39:35','Magento Preview Version CE 1.7.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-alpha1-now-available/',1,0),
	(64,4,'2012-01-11 22:24:20','Magento CE 1.6.2.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1620-stable-now-available/',1,0),
	(65,4,'2012-03-03 00:54:12','Magento Preview Version CE 1.7.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-beta1-now-available/',1,0),
	(66,4,'2012-04-23 14:02:40','Magento Community Preview Version CE 1.7.0.0-RC1 has been released!','Learn more about the exciting new features and updates in this release and how you can take it for a test drive. As this is a preview version, we need to stress that it\'s likely unstable and that we DON\'T recommend that you use it in any production environment just yet.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-rc1-now-available/',1,0),
	(67,4,'2012-05-11 09:46:54','Magento Community 1.7 and Magento Enterprise 1.12 now available!','Learn more about the exciting new features and updates in these releases.','http://www.magentocommerce.com/blog/comments/magento-enterprise-112-and-community-17-now-available/',1,0),
	(68,4,'2012-06-20 18:54:07','Magento Community Edition 1.7.0.1 now available! ','We have just released an updated version of Magento Community Edition, version 1.7.0.1. This update delivers new, minor functionality and fixes for some potential security vulnerabilities.','http://www.magentocommerce.com/blog/comments/magento-community-edition-1701-released/',1,0),
	(69,4,'2012-07-05 19:21:43','Important Security Update - Zend Platform Vulnerability','We have recently learned of a serious vulnerability in the Zend platform on which Magento is built. Learn more and access a patch that addresses this issue. ','http://www.magentocommerce.com/blog/comments/important-security-update-zend-platform-vulnerability/',1,0),
	(70,4,'2012-11-19 20:27:42','Wrap up more holiday sales with financing','Give your customers up to 6 months financing. You get paid right away with Bill Me Later, a PayPal service. It’s a great way to extend financing in time for the holidays. Learn More.','http://www.magentocommerce.com/paypal/billmelater?utm_source=CEMessaging&utm_medium=copy&utm_content=sixmonths&utm_campaign=BML',1,0),
	(71,4,'2012-12-07 11:22:30','Increase Your Sales With PayPal','Magento merchants using PayPal Express Checkout can help increase their sales on average 18%. It is one simple thing you can do right now to help boost your sales. Learn more.','http://www.magentocommerce.com/add-paypal?utm_source=CEModule&utm_medium=copy&utm_content=18&utm_campaign=choosepaypal',1,0),
	(72,4,'2013-01-15 22:02:07','Imagine 2013 Registration is Now Open!','Join 1500 merchants, partners, developers and enthusiasts from 35+ countries around the world for Magento’s premier global conference! Collaborate, learn, network and get inspired by the future of eCommerce. Tickets will sell out fast! April 8th – 10th in Las Vegas.','https://registration.imagineecommerce.com/',1,0),
	(73,4,'2013-02-12 17:53:42','Get More eCommerce Power with Magento Enterprise','Limited time offer: Get a free, customized evaluation of your Community Edition site from a Magento Solution Partner. This evaluation gives you a clear look at the numerous benefits you can achieve by upgrading to Enterprise Edition. ','http://www.magentocommerce.com/community-to-enterprise?utm_source=CEMM&utm_medium=copy&utm_campaign=CE2EE',1,0),
	(74,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.',NULL,1,0),
	(75,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.',NULL,1,0),
	(76,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.',NULL,1,0),
	(77,4,'2008-11-08 04:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.',NULL,1,0);

/*!40000 ALTER TABLE `mg_adminnotification_inbox` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_api_assert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api_assert`;

CREATE TABLE `mg_api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts';



# Dump of table mg_api_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api_role`;

CREATE TABLE `mg_api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_MG_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_MG_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles';



# Dump of table mg_api_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api_rule`;

CREATE TABLE `mg_api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MG_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_MG_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_MG_API_RULE_ROLE_ID_MG_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `mg_api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules';



# Dump of table mg_api_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api_session`;

CREATE TABLE `mg_api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_MG_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_MG_API_SESSION_SESSID` (`sessid`),
  CONSTRAINT `FK_MG_API_SESSION_USER_ID_MG_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `mg_api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';



# Dump of table mg_api_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api_user`;

CREATE TABLE `mg_api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(40) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users';



# Dump of table mg_api2_acl_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api2_acl_attribute`;

CREATE TABLE `mg_api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_MG_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_MG_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes';



# Dump of table mg_api2_acl_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api2_acl_role`;

CREATE TABLE `mg_api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_MG_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles';

LOCK TABLES `mg_api2_acl_role` WRITE;
/*!40000 ALTER TABLE `mg_api2_acl_role` DISABLE KEYS */;

INSERT INTO `mg_api2_acl_role` (`entity_id`, `created_at`, `updated_at`, `role_name`)
VALUES
	(1,'2013-08-10 01:43:17',NULL,'Guest'),
	(2,'2013-08-10 01:43:17',NULL,'Customer');

/*!40000 ALTER TABLE `mg_api2_acl_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_api2_acl_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api2_acl_rule`;

CREATE TABLE `mg_api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_MG_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`),
  CONSTRAINT `FK_MG_API2_ACL_RULE_ROLE_ID_MG_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `mg_api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules';



# Dump of table mg_api2_acl_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_api2_acl_user`;

CREATE TABLE `mg_api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_MG_MG_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_MG_API2_ACL_USER_ROLE_ID_MG_API2_ACL_ROLE_ENTITY_ID` (`role_id`),
  CONSTRAINT `FK_MG_API2_ACL_USER_ADMIN_ID_MG_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `mg_admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_API2_ACL_USER_ROLE_ID_MG_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `mg_api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';



# Dump of table mg_captcha_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_captcha_log`;

CREATE TABLE `mg_captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';



# Dump of table mg_catalog_category_anc_categs_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_anc_categs_index_idx`;

CREATE TABLE `mg_catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_MG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';



# Dump of table mg_catalog_category_anc_categs_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_anc_categs_index_tmp`;

CREATE TABLE `mg_catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_MG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';



# Dump of table mg_catalog_category_anc_products_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_anc_products_index_idx`;

CREATE TABLE `mg_catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_MG_CAT_CTGR_ANC_PRDS_IDX_IDX_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';



# Dump of table mg_catalog_category_anc_products_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_anc_products_index_tmp`;

CREATE TABLE `mg_catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_MG_CAT_CTGR_ANC_PRDS_IDX_TMP_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';



# Dump of table mg_catalog_category_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity`;

CREATE TABLE `mg_catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_PATH_ENTITY_ID` (`path`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';

LOCK TABLES `mg_catalog_category_entity` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`)
VALUES
	(1,3,0,0,'2013-08-09 22:43:30','2013-08-09 22:43:30','1',0,0,3),
	(2,3,3,1,'2013-08-09 22:43:30','2013-08-09 22:43:30','1/2',1,1,0),
	(3,3,3,1,'2013-08-12 21:05:39','2013-08-12 21:05:39','1/3',2,1,0),
	(4,3,3,1,'2013-08-12 21:05:55','2013-08-12 21:05:55','1/4',3,1,0);

/*!40000 ALTER TABLE `mg_catalog_category_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity_datetime`;

CREATE TABLE `mg_catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_CTGR_ENTT_DTIME_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DTIME_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DTIME_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DTIME_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';

LOCK TABLES `mg_catalog_category_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity_datetime` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity_datetime` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,59,0,3,NULL),
	(2,3,60,0,3,NULL),
	(3,3,59,0,4,NULL),
	(4,3,60,0,4,NULL);

/*!40000 ALTER TABLE `mg_catalog_category_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity_decimal`;

CREATE TABLE `mg_catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DEC_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DEC_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_DEC_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';

LOCK TABLES `mg_catalog_category_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity_decimal` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity_decimal` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,70,0,3,NULL),
	(2,3,70,0,4,NULL);

/*!40000 ALTER TABLE `mg_catalog_category_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity_int`;

CREATE TABLE `mg_catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_INT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_INT_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_INT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';

LOCK TABLES `mg_catalog_category_entity_int` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity_int` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,67,0,1,1),
	(2,3,67,1,1,1),
	(3,3,42,0,2,1),
	(4,3,67,0,2,1),
	(5,3,42,1,2,1),
	(6,3,67,1,2,1),
	(7,3,42,0,3,1),
	(8,3,67,0,3,1),
	(9,3,50,0,3,NULL),
	(10,3,51,0,3,0),
	(11,3,68,0,3,0),
	(12,3,69,0,3,0),
	(13,3,42,0,4,1),
	(14,3,67,0,4,1),
	(15,3,50,0,4,NULL),
	(16,3,51,0,4,0),
	(17,3,68,0,4,0),
	(18,3,69,0,4,0);

/*!40000 ALTER TABLE `mg_catalog_category_entity_int` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity_text`;

CREATE TABLE `mg_catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_TEXT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_TEXT_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_TEXT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';

LOCK TABLES `mg_catalog_category_entity_text` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity_text` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,65,0,1,NULL),
	(2,3,65,1,1,NULL),
	(3,3,65,0,2,NULL),
	(4,3,65,1,2,NULL),
	(5,3,44,0,3,NULL),
	(6,3,47,0,3,NULL),
	(7,3,48,0,3,NULL),
	(8,3,62,0,3,NULL),
	(9,3,65,0,3,NULL),
	(10,3,44,0,4,NULL),
	(11,3,47,0,4,NULL),
	(12,3,48,0,4,NULL),
	(13,3,62,0,4,NULL),
	(14,3,65,0,4,NULL);

/*!40000 ALTER TABLE `mg_catalog_category_entity_text` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_entity_varchar`;

CREATE TABLE `mg_catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_VCHR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_VCHR_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_ENTT_VCHR_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';

LOCK TABLES `mg_catalog_category_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_entity_varchar` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,41,0,1,'Root Catalog'),
	(2,3,41,1,1,'Root Catalog'),
	(3,3,43,1,1,'root-catalog'),
	(4,3,41,0,2,'Default Category'),
	(5,3,41,1,2,'Default Category'),
	(6,3,49,1,2,'PRODUCTS'),
	(7,3,43,1,2,'default-category'),
	(8,3,41,0,3,'Darbuotojas'),
	(9,3,43,0,3,'darbuotojas'),
	(10,3,46,0,3,NULL),
	(11,3,49,0,3,'PRODUCTS'),
	(12,3,58,0,3,NULL),
	(13,3,61,0,3,NULL),
	(14,3,41,0,4,'Detale'),
	(15,3,43,0,4,'detale'),
	(16,3,46,0,4,NULL),
	(17,3,49,0,4,'PRODUCTS'),
	(18,3,58,0,4,NULL),
	(19,3,61,0,4,NULL);

/*!40000 ALTER TABLE `mg_catalog_category_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_flat_store_1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_flat_store_1`;

CREATE TABLE `mg_catalog_category_flat_store_1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entity_id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'parent_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'updated_at',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'path',
  `position` int(11) NOT NULL COMMENT 'position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'level',
  `children_count` int(11) NOT NULL COMMENT 'children_count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `all_children` text COMMENT 'All Children',
  `available_sort_by` text COMMENT 'Available Product Listing Sort By',
  `children` text COMMENT 'Children',
  `custom_apply_to_products` int(11) DEFAULT NULL COMMENT 'Apply To Products',
  `custom_design` varchar(255) DEFAULT NULL COMMENT 'Custom Design',
  `custom_design_from` datetime DEFAULT NULL COMMENT 'Active From',
  `custom_design_to` datetime DEFAULT NULL COMMENT 'Active To',
  `custom_layout_update` text COMMENT 'Custom Layout Update',
  `custom_use_parent_settings` int(11) DEFAULT NULL COMMENT 'Use Parent Category Settings',
  `default_sort_by` varchar(255) DEFAULT NULL COMMENT 'Default Product Listing Sort By',
  `description` text COMMENT 'Description',
  `display_mode` varchar(255) DEFAULT NULL COMMENT 'Display Mode',
  `filter_price_range` decimal(12,4) DEFAULT NULL COMMENT 'Layered Navigation Price Step',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `include_in_menu` int(11) DEFAULT NULL COMMENT 'Include in Navigation Menu',
  `is_active` int(11) DEFAULT NULL COMMENT 'Is Active',
  `is_anchor` int(11) DEFAULT NULL COMMENT 'Is Anchor',
  `landing_page` int(11) DEFAULT NULL COMMENT 'CMS Block',
  `meta_description` text COMMENT 'Meta Description',
  `meta_keywords` text COMMENT 'Meta Keywords',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `path_in_store` text COMMENT 'Path In Store',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Image',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'URL Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_FLAT_STORE_1_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_FLAT_STORE_1_PATH` (`path`),
  KEY `IDX_MG_CATALOG_CATEGORY_FLAT_STORE_1_LEVEL` (`level`),
  CONSTRAINT `FK_MG_CAT_CTGR_FLAT_STORE_1_ENTT_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_FLAT_STORE_1_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Flat (Store 1)';

LOCK TABLES `mg_catalog_category_flat_store_1` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_flat_store_1` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_flat_store_1` (`entity_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`, `store_id`, `all_children`, `available_sort_by`, `children`, `custom_apply_to_products`, `custom_design`, `custom_design_from`, `custom_design_to`, `custom_layout_update`, `custom_use_parent_settings`, `default_sort_by`, `description`, `display_mode`, `filter_price_range`, `image`, `include_in_menu`, `is_active`, `is_anchor`, `landing_page`, `meta_description`, `meta_keywords`, `meta_title`, `name`, `page_layout`, `path_in_store`, `thumbnail`, `url_key`, `url_path`)
VALUES
	(1,0,'2013-08-09 22:43:30','2013-08-09 22:43:30','1',0,0,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,'Root Catalog',NULL,NULL,NULL,NULL,NULL),
	(2,1,'2013-08-09 22:43:30','2013-08-09 22:43:30','1/2',1,1,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL,'Default Category',NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_catalog_category_flat_store_1` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product`;

CREATE TABLE `mg_catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_MG_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CAT_CTGR_PRD_CTGR_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_PRD_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';

LOCK TABLES `mg_catalog_category_product` WRITE;
/*!40000 ALTER TABLE `mg_catalog_category_product` DISABLE KEYS */;

INSERT INTO `mg_catalog_category_product` (`category_id`, `product_id`, `position`)
VALUES
	(3,2,1),
	(4,3,1);

/*!40000 ALTER TABLE `mg_catalog_category_product` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_category_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product_index`;

CREATE TABLE `mg_catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_MG_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `9F0DE3351D175F137D28704CB260F849` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`),
  CONSTRAINT `FK_MG_CAT_CTGR_PRD_IDX_CTGR_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_PRD_IDX_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CTGR_PRD_IDX_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';



# Dump of table mg_catalog_category_product_index_enbl_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product_index_enbl_idx`;

CREATE TABLE `mg_catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_MG_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_IDX_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_CAT_CTGR_PRD_IDX_ENBL_IDX_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';



# Dump of table mg_catalog_category_product_index_enbl_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product_index_enbl_tmp`;

CREATE TABLE `mg_catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_MG_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_TMP_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_CAT_CTGR_PRD_IDX_ENBL_TMP_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';



# Dump of table mg_catalog_category_product_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product_index_idx`;

CREATE TABLE `mg_catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_MG_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';



# Dump of table mg_catalog_category_product_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_category_product_index_tmp`;

CREATE TABLE `mg_catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_MG_CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';



# Dump of table mg_catalog_compare_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_compare_item`;

CREATE TABLE `mg_catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_MG_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_MG_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MG_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CATALOG_COMPARE_ITEM_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CMP_ITEM_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_CMP_ITEM_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';



# Dump of table mg_catalog_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_eav_attribute`;

CREATE TABLE `mg_catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_MG_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_MG_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_MG_CAT_EAV_ATTR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';

LOCK TABLES `mg_catalog_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mg_catalog_eav_attribute` DISABLE KEYS */;

INSERT INTO `mg_catalog_eav_attribute` (`attribute_id`, `frontend_input_renderer`, `is_global`, `is_visible`, `is_searchable`, `is_filterable`, `is_comparable`, `is_visible_on_front`, `is_html_allowed_on_front`, `is_used_for_price_rules`, `is_filterable_in_search`, `used_in_product_listing`, `used_for_sort_by`, `is_configurable`, `apply_to`, `is_visible_in_advanced_search`, `position`, `is_wysiwyg_enabled`, `is_used_for_promo_rules`)
VALUES
	(41,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(42,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(43,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(44,NULL,0,1,0,0,0,0,1,0,0,0,0,1,NULL,0,0,1,0),
	(45,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(46,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(47,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(48,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(49,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(50,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(51,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(52,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(53,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(54,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(55,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(56,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(57,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(58,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(59,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(60,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(61,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(62,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(63,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(64,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(65,'adminhtml/catalog_category_helper_sortby_available',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(66,'adminhtml/catalog_category_helper_sortby_default',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(67,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(68,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(69,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(70,'adminhtml/catalog_category_helper_pricestep',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(71,NULL,0,1,1,0,0,0,0,0,0,1,1,1,NULL,1,0,0,0),
	(72,NULL,0,1,1,0,1,0,1,0,0,0,0,1,NULL,1,0,1,0),
	(73,NULL,0,1,1,0,1,0,1,0,0,1,0,1,NULL,1,0,1,0),
	(74,NULL,1,1,1,0,1,0,0,0,0,0,0,1,NULL,1,0,0,0),
	(75,NULL,2,1,1,1,0,0,0,0,0,1,1,1,'simple,configurable,virtual,bundle,downloadable',1,0,0,0),
	(76,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(77,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(78,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(79,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'virtual,downloadable',0,0,0,0),
	(80,NULL,1,1,0,0,0,0,0,0,0,0,0,1,'simple,bundle',0,0,0,0),
	(81,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),
	(82,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(83,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(84,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(85,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(86,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(87,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(88,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(89,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(90,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(91,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(92,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),
	(93,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(94,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(95,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(96,NULL,2,1,1,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(97,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(98,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(99,NULL,0,0,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(100,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),
	(101,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),
	(102,NULL,0,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0),
	(103,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(104,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(105,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(106,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(107,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(108,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(109,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(110,NULL,1,0,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(111,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(112,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(113,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(114,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(115,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(116,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(117,NULL,2,1,0,0,0,0,0,0,0,0,0,0,'simple,configurable,bundle,grouped',0,0,0,0),
	(118,'adminhtml/catalog_product_helper_form_msrp_enabled',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(119,'adminhtml/catalog_product_helper_form_msrp_price',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(120,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(121,NULL,1,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0),
	(122,NULL,2,1,1,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',1,0,0,0),
	(123,'giftmessage/adminhtml_product_helper_form_config',1,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0),
	(124,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(125,NULL,1,0,0,0,0,0,0,0,0,0,0,0,'bundle',0,0,0,0),
	(126,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(127,NULL,1,1,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(128,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(129,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),
	(130,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),
	(131,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),
	(132,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),
	(133,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(134,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(135,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(136,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(138,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(149,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(155,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0),
	(156,NULL,0,1,0,0,0,0,1,0,0,0,0,0,NULL,0,0,0,0);

/*!40000 ALTER TABLE `mg_catalog_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_bundle_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_option`;

CREATE TABLE `mg_catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_OPT_PARENT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';



# Dump of table mg_catalog_product_bundle_option_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_option_value`;

CREATE TABLE `mg_catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_OPT_VAL_OPT_ID_MG_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';



# Dump of table mg_catalog_product_bundle_price_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_price_index`;

CREATE TABLE `mg_catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_F3E860D0DACEEBBFBF279E8F78E46AAD` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_PRICE_IDX_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';



# Dump of table mg_catalog_product_bundle_selection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_selection`;

CREATE TABLE `mg_catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_SELECTION_OPT_ID_MG_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_SELECTION_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';



# Dump of table mg_catalog_product_bundle_selection_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_selection_price`;

CREATE TABLE `mg_catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_F2D0521A203A5C27BFDE0C64B836525D` FOREIGN KEY (`selection_id`) REFERENCES `mg_catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';



# Dump of table mg_catalog_product_bundle_stock_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_bundle_stock_index`;

CREATE TABLE `mg_catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';



# Dump of table mg_catalog_product_enabled_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_enabled_index`;

CREATE TABLE `mg_catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENABLED_IDX_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENABLED_IDX_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';



# Dump of table mg_catalog_product_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity`;

CREATE TABLE `mg_catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_ATTR_SET_ID_MG_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `mg_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';

LOCK TABLES `mg_catalog_product_entity` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `type_id`, `sku`, `has_options`, `required_options`, `created_at`, `updated_at`)
VALUES
	(2,4,10,'simple',NULL,0,0,'2013-08-12 21:07:03','2013-08-12 21:07:11'),
	(3,4,9,'simple',NULL,0,0,'2013-08-12 21:07:46','2013-08-15 00:00:20');

/*!40000 ALTER TABLE `mg_catalog_product_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_datetime`;

CREATE TABLE `mg_catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DTIME_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DTIME_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DTIME_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';

LOCK TABLES `mg_catalog_product_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity_datetime` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity_datetime` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(7,4,93,0,2,NULL),
	(8,4,94,0,2,NULL),
	(9,4,77,0,2,NULL),
	(10,4,78,0,2,NULL),
	(11,4,105,0,2,NULL),
	(12,4,104,0,2,NULL),
	(19,4,136,0,3,'2013-08-14 00:00:00'),
	(20,4,94,0,3,NULL),
	(21,4,93,0,3,NULL),
	(22,4,77,0,3,NULL),
	(23,4,78,0,3,NULL),
	(24,4,104,0,3,NULL),
	(25,4,105,0,3,NULL);

/*!40000 ALTER TABLE `mg_catalog_product_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_decimal`;

CREATE TABLE `mg_catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DEC_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DEC_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_DEC_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';

LOCK TABLES `mg_catalog_product_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity_decimal` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity_decimal` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(5,4,75,0,2,NULL),
	(6,4,80,0,2,NULL),
	(7,4,76,0,2,NULL),
	(8,4,120,0,2,NULL),
	(13,4,80,0,3,NULL),
	(14,4,75,0,3,14.0000),
	(15,4,138,0,3,12.0000),
	(16,4,76,0,3,NULL),
	(17,4,120,0,3,NULL),
	(28,4,155,0,3,15.0000),
	(29,4,156,0,3,13.0000);

/*!40000 ALTER TABLE `mg_catalog_product_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_entity_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_gallery`;

CREATE TABLE `mg_catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_GLR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_GLR_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_GLR_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';



# Dump of table mg_catalog_product_entity_group_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_group_price`;

CREATE TABLE `mg_catalog_product_entity_group_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `BD6DADE3E4CD24F3E6F99CF01F03CD7A` (`entity_id`,`all_groups`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_AD48413C102AC1E809BAAE0CEA27AA8E` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_GROUP_PRICE_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_GROUP_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Attribute Backend Table';



# Dump of table mg_catalog_product_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_int`;

CREATE TABLE `mg_catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_INT_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_INT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_INT_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';

LOCK TABLES `mg_catalog_product_entity_int` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity_int` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(6,4,96,0,2,NULL),
	(7,4,102,0,2,4),
	(8,4,121,0,2,1),
	(9,4,122,0,2,NULL),
	(10,4,100,0,2,0),
	(13,4,96,0,3,NULL),
	(14,4,122,0,3,5),
	(15,4,121,0,3,1),
	(16,4,100,0,3,0),
	(17,4,102,0,3,4),
	(18,4,81,0,3,NULL);

/*!40000 ALTER TABLE `mg_catalog_product_entity_int` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_entity_media_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_media_gallery`;

CREATE TABLE `mg_catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';



# Dump of table mg_catalog_product_entity_media_gallery_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_media_gallery_value`;

CREATE TABLE `mg_catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_9E74861600CFFB7DC3B1B92170DF6782` FOREIGN KEY (`value_id`) REFERENCES `mg_catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';



# Dump of table mg_catalog_product_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_text`;

CREATE TABLE `mg_catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_TEXT_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_TEXT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_TEXT_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_TEXT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';

LOCK TABLES `mg_catalog_product_entity_text` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity_text` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(5,4,73,0,2,NULL),
	(6,4,83,0,2,NULL),
	(7,4,72,0,2,NULL),
	(8,4,106,0,2,NULL),
	(13,4,73,0,3,NULL),
	(14,4,72,0,3,NULL),
	(15,4,83,0,3,NULL),
	(16,4,106,0,3,NULL);

/*!40000 ALTER TABLE `mg_catalog_product_entity_text` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_entity_tier_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_tier_price`;

CREATE TABLE `mg_catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `C993396E720E6ED52BF4AD082B2ACE02` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_0EAD7FC34CF8EEB6DA933AC217A9F138` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_TIER_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';



# Dump of table mg_catalog_product_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_entity_varchar`;

CREATE TABLE `mg_catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_VCHR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_VCHR_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_ENTT_VCHR_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';

LOCK TABLES `mg_catalog_product_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_entity_varchar` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(18,4,71,0,2,'Jonas'),
	(19,4,134,0,2,NULL),
	(20,4,117,0,2,NULL),
	(21,4,97,0,2,'jonas'),
	(22,4,118,0,2,'2'),
	(23,4,119,0,2,'4'),
	(24,4,84,0,2,NULL),
	(25,4,87,0,2,'no_selection'),
	(26,4,86,0,2,'no_selection'),
	(27,4,85,0,2,'no_selection'),
	(28,4,82,0,2,NULL),
	(29,4,103,0,2,NULL),
	(30,4,107,0,2,NULL),
	(31,4,109,0,2,'container2'),
	(32,4,123,0,2,NULL),
	(33,4,98,1,2,'jonas.html'),
	(34,4,98,0,2,'jonas.html'),
	(42,4,71,0,3,'Kuro filtras'),
	(43,4,117,0,3,NULL),
	(44,4,135,0,3,'AD'),
	(45,4,82,0,3,NULL),
	(46,4,97,0,3,'kuro-filtras'),
	(47,4,118,0,3,'2'),
	(48,4,119,0,3,'4'),
	(49,4,85,0,3,'no_selection'),
	(50,4,86,0,3,'no_selection'),
	(51,4,87,0,3,'no_selection'),
	(52,4,103,0,3,NULL),
	(53,4,109,0,3,'container2'),
	(54,4,107,0,3,NULL),
	(55,4,84,0,3,NULL),
	(56,4,123,0,3,NULL),
	(57,4,98,1,3,'kuro-filtras.html'),
	(58,4,98,0,3,'kuro-filtras.html'),
	(59,4,149,0,3,NULL);

/*!40000 ALTER TABLE `mg_catalog_product_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_flat_1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_flat_1`;

CREATE TABLE `mg_catalog_product_flat_1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type Id',
  `cost` decimal(12,4) DEFAULT NULL COMMENT 'Cost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `enable_googlecheckout` smallint(6) DEFAULT NULL COMMENT 'Enable Googlecheckout',
  `gift_message_available` smallint(6) DEFAULT NULL COMMENT 'Gift Message Available',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `image_label` varchar(255) DEFAULT NULL COMMENT 'Image Label',
  `is_recurring` smallint(6) DEFAULT NULL COMMENT 'Is Recurring',
  `links_exist` int(11) DEFAULT NULL COMMENT 'Links Exist',
  `links_purchased_separately` int(11) DEFAULT NULL COMMENT 'Links Purchased Separately',
  `links_title` varchar(255) DEFAULT NULL COMMENT 'Links Title',
  `msrp` decimal(12,4) DEFAULT NULL COMMENT 'Msrp',
  `msrp_display_actual_price_type` varchar(255) DEFAULT NULL COMMENT 'Msrp Display Actual Price Type',
  `msrp_enabled` smallint(6) DEFAULT NULL COMMENT 'Msrp Enabled',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `news_from_date` datetime DEFAULT NULL COMMENT 'News From Date',
  `news_to_date` datetime DEFAULT NULL COMMENT 'News To Date',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `price_type` int(11) DEFAULT NULL COMMENT 'Price Type',
  `price_view` int(11) DEFAULT NULL COMMENT 'Price View',
  `recurring_profile` text COMMENT 'Recurring Profile',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `shipment_type` int(11) DEFAULT NULL COMMENT 'Shipment Type',
  `short_description` text COMMENT 'Short Description',
  `sku` varchar(64) DEFAULT NULL COMMENT 'Sku',
  `sku_type` int(11) DEFAULT NULL COMMENT 'Sku Type',
  `small_image` varchar(255) DEFAULT NULL COMMENT 'Small Image',
  `small_image_label` varchar(255) DEFAULT NULL COMMENT 'Small Image Label',
  `special_from_date` datetime DEFAULT NULL COMMENT 'Special From Date',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `special_to_date` datetime DEFAULT NULL COMMENT 'Special To Date',
  `tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Tax Class Id',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Thumbnail',
  `thumbnail_label` varchar(255) DEFAULT NULL COMMENT 'Thumbnail Label',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `url_key` varchar(255) DEFAULT NULL COMMENT 'Url Key',
  `url_path` varchar(255) DEFAULT NULL COMMENT 'Url Path',
  `visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Visibility',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `weight_type` int(11) DEFAULT NULL COMMENT 'Weight Type',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_FLAT_1_TYPE_ID` (`type_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_FLAT_1_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_FLAT_1_NAME` (`name`),
  KEY `IDX_MG_CATALOG_PRODUCT_FLAT_1_PRICE` (`price`),
  CONSTRAINT `FK_MG_MG_CAT_PRD_FLAT_1_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Flat (Store 1)';



# Dump of table mg_catalog_product_index_eav
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav`;

CREATE TABLE `mg_catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`),
  CONSTRAINT `FK_MG_CATALOG_PRODUCT_INDEX_EAV_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_EAV_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_EAV_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';



# Dump of table mg_catalog_product_index_eav_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav_decimal`;

CREATE TABLE `mg_catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`),
  CONSTRAINT `FK_MG_CAT_PRD_IDX_EAV_DEC_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_EAV_DEC_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_EAV_DEC_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';



# Dump of table mg_catalog_product_index_eav_decimal_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav_decimal_idx`;

CREATE TABLE `mg_catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';



# Dump of table mg_catalog_product_index_eav_decimal_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav_decimal_tmp`;

CREATE TABLE `mg_catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';



# Dump of table mg_catalog_product_index_eav_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav_idx`;

CREATE TABLE `mg_catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';



# Dump of table mg_catalog_product_index_eav_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_eav_tmp`;

CREATE TABLE `mg_catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';



# Dump of table mg_catalog_product_index_group_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_group_price`;

CREATE TABLE `mg_catalog_product_index_group_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_A9267616724242949BFBAFFB13855168` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_GROUP_PRICE_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_GROUP_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Index Table';



# Dump of table mg_catalog_product_index_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price`;

CREATE TABLE `mg_catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `IDX_MG_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`),
  CONSTRAINT `FK_74DDC26ED5FB574D3E963E6FC395C1EE` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_PRICE_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';



# Dump of table mg_catalog_product_index_price_bundle_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_idx`;

CREATE TABLE `mg_catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';



# Dump of table mg_catalog_product_index_price_bundle_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_opt_idx`;

CREATE TABLE `mg_catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';



# Dump of table mg_catalog_product_index_price_bundle_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_opt_tmp`;

CREATE TABLE `mg_catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';



# Dump of table mg_catalog_product_index_price_bundle_sel_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_sel_idx`;

CREATE TABLE `mg_catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';



# Dump of table mg_catalog_product_index_price_bundle_sel_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_sel_tmp`;

CREATE TABLE `mg_catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';



# Dump of table mg_catalog_product_index_price_bundle_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_bundle_tmp`;

CREATE TABLE `mg_catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';



# Dump of table mg_catalog_product_index_price_cfg_opt_agr_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_cfg_opt_agr_idx`;

CREATE TABLE `mg_catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';



# Dump of table mg_catalog_product_index_price_cfg_opt_agr_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_cfg_opt_agr_tmp`;

CREATE TABLE `mg_catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';



# Dump of table mg_catalog_product_index_price_cfg_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_cfg_opt_idx`;

CREATE TABLE `mg_catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';



# Dump of table mg_catalog_product_index_price_cfg_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_cfg_opt_tmp`;

CREATE TABLE `mg_catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';



# Dump of table mg_catalog_product_index_price_downlod_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_downlod_idx`;

CREATE TABLE `mg_catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';



# Dump of table mg_catalog_product_index_price_downlod_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_downlod_tmp`;

CREATE TABLE `mg_catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';



# Dump of table mg_catalog_product_index_price_final_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_final_idx`;

CREATE TABLE `mg_catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';



# Dump of table mg_catalog_product_index_price_final_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_final_tmp`;

CREATE TABLE `mg_catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';



# Dump of table mg_catalog_product_index_price_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_idx`;

CREATE TABLE `mg_catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';



# Dump of table mg_catalog_product_index_price_opt_agr_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_opt_agr_idx`;

CREATE TABLE `mg_catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';



# Dump of table mg_catalog_product_index_price_opt_agr_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_opt_agr_tmp`;

CREATE TABLE `mg_catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';



# Dump of table mg_catalog_product_index_price_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_opt_idx`;

CREATE TABLE `mg_catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';



# Dump of table mg_catalog_product_index_price_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_opt_tmp`;

CREATE TABLE `mg_catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';



# Dump of table mg_catalog_product_index_price_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_price_tmp`;

CREATE TABLE `mg_catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';



# Dump of table mg_catalog_product_index_tier_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_tier_price`;

CREATE TABLE `mg_catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_3EF0EFE7EEF4423557A86C7D6DFBCB2D` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_IDX_TIER_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';



# Dump of table mg_catalog_product_index_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_index_website`;

CREATE TABLE `mg_catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `FK_MG_CAT_PRD_IDX_WS_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';

LOCK TABLES `mg_catalog_product_index_website` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_index_website` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_index_website` (`website_id`, `website_date`, `rate`)
VALUES
	(1,'2013-08-15',1);

/*!40000 ALTER TABLE `mg_catalog_product_index_website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link`;

CREATE TABLE `mg_catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_MG_CAT_PRD_LNK_LNKED_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_LNK_LNK_TYPE_ID_MG_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `mg_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_LNK_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';



# Dump of table mg_catalog_product_link_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link_attribute`;

CREATE TABLE `mg_catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_4672F1428F23AAF233DCC6C147443700` FOREIGN KEY (`link_type_id`) REFERENCES `mg_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';

LOCK TABLES `mg_catalog_product_link_attribute` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_link_attribute` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_link_attribute` (`product_link_attribute_id`, `link_type_id`, `product_link_attribute_code`, `data_type`)
VALUES
	(1,1,'position','int'),
	(2,3,'position','int'),
	(3,3,'qty','decimal'),
	(4,4,'position','int'),
	(5,5,'position','int');

/*!40000 ALTER TABLE `mg_catalog_product_link_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_link_attribute_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link_attribute_decimal`;

CREATE TABLE `mg_catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MG_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_38E871CE377CDC9B63D9A1CAE959099D` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_LNK_ATTR_DEC_LNK_ID_MG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mg_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';



# Dump of table mg_catalog_product_link_attribute_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link_attribute_int`;

CREATE TABLE `mg_catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MG_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_77EBD7C6B6B4BF3208DD69658F5BAC4A` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_LNK_ATTR_INT_LNK_ID_MG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mg_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';



# Dump of table mg_catalog_product_link_attribute_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link_attribute_varchar`;

CREATE TABLE `mg_catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MG_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_24039B2859452C276743FB232A0B805B` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_MG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mg_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';



# Dump of table mg_catalog_product_link_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_link_type`;

CREATE TABLE `mg_catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';

LOCK TABLES `mg_catalog_product_link_type` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_link_type` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_link_type` (`link_type_id`, `code`)
VALUES
	(1,'relation'),
	(3,'super'),
	(4,'up_sell'),
	(5,'cross_sell');

/*!40000 ALTER TABLE `mg_catalog_product_link_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_catalog_product_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option`;

CREATE TABLE `mg_catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CAT_PRD_OPT_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';



# Dump of table mg_catalog_product_option_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option_price`;

CREATE TABLE `mg_catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_PRD_OPT_PRICE_OPT_ID_MG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_OPT_PRICE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';



# Dump of table mg_catalog_product_option_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option_title`;

CREATE TABLE `mg_catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CAT_PRD_OPT_TTL_OPT_ID_MG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_OPT_TTL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';



# Dump of table mg_catalog_product_option_type_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option_type_price`;

CREATE TABLE `mg_catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_144DB6851C12D4DF43807C8D904278D5` FOREIGN KEY (`option_type_id`) REFERENCES `mg_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';



# Dump of table mg_catalog_product_option_type_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option_type_title`;

CREATE TABLE `mg_catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_E094412A592F73545A15400FBE8AC662` FOREIGN KEY (`option_type_id`) REFERENCES `mg_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_OPT_TYPE_TTL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';



# Dump of table mg_catalog_product_option_type_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_option_type_value`;

CREATE TABLE `mg_catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `FK_MG_CAT_PRD_OPT_TYPE_VAL_OPT_ID_MG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';



# Dump of table mg_catalog_product_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_relation`;

CREATE TABLE `mg_catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `FK_MG_CAT_PRD_RELATION_CHILD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_RELATION_PARENT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';



# Dump of table mg_catalog_product_super_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_super_attribute`;

CREATE TABLE `mg_catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CAT_PRD_SPR_ATTR_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';



# Dump of table mg_catalog_product_super_attribute_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_super_attribute_label`;

CREATE TABLE `mg_catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_MG_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_FDC7F5C8A5A6011A7C891585668338C6` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `mg_catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_SPR_ATTR_LBL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';



# Dump of table mg_catalog_product_super_attribute_pricing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_super_attribute_pricing`;

CREATE TABLE `mg_catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_MG_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_F7212F8F0D3A049C1D8ED8624A0EC5E3` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `mg_catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_SPR_ATTR_PRICING_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table';



# Dump of table mg_catalog_product_super_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_super_link`;

CREATE TABLE `mg_catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MG_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CAT_PRD_SPR_LNK_PARENT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_SPR_LNK_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';



# Dump of table mg_catalog_product_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalog_product_website`;

CREATE TABLE `mg_catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_MG_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CAT_PRD_WS_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CAT_PRD_WS_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';

LOCK TABLES `mg_catalog_product_website` WRITE;
/*!40000 ALTER TABLE `mg_catalog_product_website` DISABLE KEYS */;

INSERT INTO `mg_catalog_product_website` (`product_id`, `website_id`)
VALUES
	(2,1),
	(3,1);

/*!40000 ALTER TABLE `mg_catalog_product_website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cataloginventory_stock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cataloginventory_stock`;

CREATE TABLE `mg_cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';

LOCK TABLES `mg_cataloginventory_stock` WRITE;
/*!40000 ALTER TABLE `mg_cataloginventory_stock` DISABLE KEYS */;

INSERT INTO `mg_cataloginventory_stock` (`stock_id`, `stock_name`)
VALUES
	(1,'Default');

/*!40000 ALTER TABLE `mg_cataloginventory_stock` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cataloginventory_stock_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cataloginventory_stock_item`;

CREATE TABLE `mg_cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_MG_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `FK_MG_CATINV_STOCK_ITEM_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATINV_STOCK_ITEM_STOCK_ID_MG_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `mg_cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';

LOCK TABLES `mg_cataloginventory_stock_item` WRITE;
/*!40000 ALTER TABLE `mg_cataloginventory_stock_item` DISABLE KEYS */;

INSERT INTO `mg_cataloginventory_stock_item` (`item_id`, `product_id`, `stock_id`, `qty`, `min_qty`, `use_config_min_qty`, `is_qty_decimal`, `backorders`, `use_config_backorders`, `min_sale_qty`, `use_config_min_sale_qty`, `max_sale_qty`, `use_config_max_sale_qty`, `is_in_stock`, `low_stock_date`, `notify_stock_qty`, `use_config_notify_stock_qty`, `manage_stock`, `use_config_manage_stock`, `stock_status_changed_auto`, `use_config_qty_increments`, `qty_increments`, `use_config_enable_qty_inc`, `enable_qty_increments`, `is_decimal_divided`)
VALUES
	(2,2,1,0.0000,0.0000,1,0,0,1,1.0000,1,0.0000,1,0,'2013-08-12 21:07:11',NULL,1,0,1,1,1,0.0000,1,0,0),
	(3,3,1,0.0000,0.0000,1,0,0,1,1.0000,1,0.0000,1,0,'2013-08-15 00:00:20',NULL,1,0,1,1,1,0.0000,1,0,0);

/*!40000 ALTER TABLE `mg_cataloginventory_stock_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cataloginventory_stock_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cataloginventory_stock_status`;

CREATE TABLE `mg_cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CATINV_STOCK_STS_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATINV_STOCK_STS_STOCK_ID_MG_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `mg_cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATINV_STOCK_STS_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';



# Dump of table mg_cataloginventory_stock_status_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cataloginventory_stock_status_idx`;

CREATE TABLE `mg_cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';



# Dump of table mg_cataloginventory_stock_status_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cataloginventory_stock_status_tmp`;

CREATE TABLE `mg_cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_MG_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';



# Dump of table mg_catalogrule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule`;

CREATE TABLE `mg_catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From Date',
  `to_date` date DEFAULT NULL COMMENT 'To Date',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `sub_is_enable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Rule Enable For Subitems',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MG_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule';



# Dump of table mg_catalogrule_affected_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_affected_product`;

CREATE TABLE `mg_catalogrule_affected_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Affected Product';



# Dump of table mg_catalogrule_customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_customer_group`;

CREATE TABLE `mg_catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_MG_CATALOGRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_MG_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_DB19917F3E55031806A021CC446CFE57` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATALOGRULE_CUSTOMER_GROUP_RULE_ID_MG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';



# Dump of table mg_catalogrule_group_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_group_website`;

CREATE TABLE `mg_catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MG_CATALOGRULE_GROUP_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MG_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CATALOGRULE_GROUP_WEBSITE_RULE_ID_MG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_GROUP_WS_CSTR_GROUP_ID_MG_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_GROUP_WS_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';



# Dump of table mg_catalogrule_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_product`;

CREATE TABLE `mg_catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `DA1358CC06FA5B33D4A0E2FC597C56CD` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_RULE_ID` (`rule_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CATALOGRULE_PRODUCT_RULE_ID_MG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATALOGRULE_PRODUCT_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_PRD_CSTR_GROUP_ID_MG_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_PRD_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';



# Dump of table mg_catalogrule_product_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_product_price`;

CREATE TABLE `mg_catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `UNQ_MG_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_DE5A3C2AAD6957284E4FCA2DAA7A75AD` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_PRD_PRICE_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATRULE_PRD_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';



# Dump of table mg_catalogrule_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogrule_website`;

CREATE TABLE `mg_catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_MG_CATALOGRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MG_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CATALOGRULE_WEBSITE_RULE_ID_MG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATALOGRULE_WEBSITE_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';



# Dump of table mg_catalogsearch_fulltext
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogsearch_fulltext`;

CREATE TABLE `mg_catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_MG_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_MG_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';



# Dump of table mg_catalogsearch_query
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogsearch_query`;

CREATE TABLE `mg_catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_MG_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_MG_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CATALOGSEARCH_QUERY_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search query table';



# Dump of table mg_catalogsearch_result
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_catalogsearch_result`;

CREATE TABLE `mg_catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_MG_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_MG_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CATSRCH_RESULT_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CATSRCH_RESULT_QR_ID_MG_CATSRCH_QR_QR_ID` FOREIGN KEY (`query_id`) REFERENCES `mg_catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';



# Dump of table mg_checkout_agreement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_checkout_agreement`;

CREATE TABLE `mg_checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';



# Dump of table mg_checkout_agreement_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_checkout_agreement_store`;

CREATE TABLE `mg_checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_MG_CHECKOUT_AGREEMENT_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CHECKOUT_AGREEMENT_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CHKT_AGRT_STORE_AGRT_ID_MG_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `mg_checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';



# Dump of table mg_cms_block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cms_block`;

CREATE TABLE `mg_cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';

LOCK TABLES `mg_cms_block` WRITE;
/*!40000 ALTER TABLE `mg_cms_block` DISABLE KEYS */;

INSERT INTO `mg_cms_block` (`block_id`, `title`, `identifier`, `content`, `creation_time`, `update_time`, `is_active`)
VALUES
	(1,'Footer Links','footer_links','<ul>\r\n<li><a href=\"{{store direct_url=\"about-magento-demo-store\"}}\">About Us</a></li>\r\n<li><a href=\"{{store direct_url=\"customer-service\"}}\">Customer Service</a></li>\r\n<li class=\"last privacy\"><a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy</a></li>\r\n</ul>','2013-08-09 22:43:26','2013-08-09 22:43:26',1);

/*!40000 ALTER TABLE `mg_cms_block` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cms_block_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cms_block_store`;

CREATE TABLE `mg_cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_MG_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CMS_BLOCK_STORE_BLOCK_ID_MG_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `mg_cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CMS_BLOCK_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';

LOCK TABLES `mg_cms_block_store` WRITE;
/*!40000 ALTER TABLE `mg_cms_block_store` DISABLE KEYS */;

INSERT INTO `mg_cms_block_store` (`block_id`, `store_id`)
VALUES
	(1,0);

/*!40000 ALTER TABLE `mg_cms_block_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cms_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cms_page`;

CREATE TABLE `mg_cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  PRIMARY KEY (`page_id`),
  KEY `IDX_MG_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';

LOCK TABLES `mg_cms_page` WRITE;
/*!40000 ALTER TABLE `mg_cms_page` DISABLE KEYS */;

INSERT INTO `mg_cms_page` (`page_id`, `title`, `root_template`, `meta_keywords`, `meta_description`, `identifier`, `content_heading`, `content`, `creation_time`, `update_time`, `is_active`, `sort_order`, `layout_update_xml`, `custom_theme`, `custom_root_template`, `custom_layout_update_xml`, `custom_theme_from`, `custom_theme_to`)
VALUES
	(1,'404 Not Found 1','two_columns_right','Page keywords','Page description','no-route',NULL,'<div class=\"page-title\"><h1>Whoops, our bad...</h1></div>\r\n<dl>\r\n<dt>The page you requested was not found, and we have a fine guess why.</dt>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li>If you typed the URL directly, please make sure the spelling is correct.</li>\r\n<li>If you clicked on a link to get here, the link is outdated.</li>\r\n</ul></dd>\r\n</dl>\r\n<dl>\r\n<dt>What can you do?</dt>\r\n<dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\r\n<li>Use the search bar at the top of the page to search for your products.</li>\r\n<li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a> <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li></ul></dd></dl>\r\n','2013-08-09 22:43:26','2013-08-09 22:43:26',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,'Home page','two_columns_right',NULL,NULL,'home',NULL,'<div class=\"page-title\"><h2>Home Page</h2></div>\r\n','2013-08-09 22:43:26','2013-08-09 22:43:30',1,0,'<!--<reference name=\"content\">\n        <block type=\"catalog/product_new\" name=\"home.catalog.product.new\" alias=\"product_new\" template=\"catalog/product/new.phtml\" after=\"cms_page\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_viewed\" name=\"home.reports.product.viewed\" alias=\"product_viewed\" template=\"reports/home_product_viewed.phtml\" after=\"product_new\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_compared\" name=\"home.reports.product.compared\" template=\"reports/home_product_compared.phtml\" after=\"product_viewed\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n    </reference>\n    <reference name=\"right\">\n        <action method=\"unsetChild\"><alias>right.reports.product.viewed</alias></action>\n        <action method=\"unsetChild\"><alias>right.reports.product.compared</alias></action>\n    </reference>-->',NULL,NULL,NULL,NULL,NULL),
	(3,'About Us','two_columns_right',NULL,NULL,'about-magento-demo-store',NULL,'<div class=\"page-title\">\r\n<h1>About Magento Store</h1>\r\n</div>\r\n<div class=\"col3-set\">\r\n<div class=\"col-1\"><p><a href=\"http://www.varien.com/\"><img src=\"{{skin url=\'images/media/about_us_img.jpg\'}}\" title=\"Varien\" alt=\"Varien\" /></a></p><p style=\"line-height:1.2em;\"><small>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.</small></p>\r\n<p style=\"color:#888; font:1.2em/1.4em georgia, serif;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta.</p></div>\r\n<div class=\"col-2\">\r\n<p><strong style=\"color:#de036f;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.</strong></p>\r\n<p>Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo. </p>\r\n<p>Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci, sit amet aliquet lectus dolor et quam. Pellentesque consequat luctus purus. Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi. Vestibulum sapien dolor, aliquet nec, porta ac, malesuada a, libero. Praesent feugiat purus eget est. Nulla facilisi. Vestibulum tincidunt sapien eu velit. Mauris purus. Maecenas eget mauris eu orci accumsan feugiat. Pellentesque eget velit. Nunc tincidunt.</p></div>\r\n<div class=\"col-3\">\r\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper </p>\r\n<p><strong style=\"color:#de036f;\">Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci, sit amet aliquet lectus dolor et quam. Pellentesque consequat luctus purus.</strong></p>\r\n<p>Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.</p>\r\n<div class=\"divider\"></div>\r\n<p>To all of you, from all of us at Magento Store - Thank you and Happy eCommerce!</p>\r\n<p style=\"line-height:1.2em;\"><strong style=\"font:italic 2em Georgia, serif;\">John Doe</strong><br /><small>Some important guy</small></p></div>\r\n</div>','2013-08-09 22:43:26','2013-08-09 22:43:26',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,'Customer Service','three_columns',NULL,NULL,'customer-service',NULL,'<div class=\"page-title\">\r\n<h1>Customer Service</h1>\r\n</div>\r\n<ul class=\"disc\">\r\n<li><a href=\"#answer1\">Shipping &amp; Delivery</a></li>\r\n<li><a href=\"#answer2\">Privacy &amp; Security</a></li>\r\n<li><a href=\"#answer3\">Returns &amp; Replacements</a></li>\r\n<li><a href=\"#answer4\">Ordering</a></li>\r\n<li><a href=\"#answer5\">Payment, Pricing &amp; Promotions</a></li>\r\n<li><a href=\"#answer6\">Viewing Orders</a></li>\r\n<li><a href=\"#answer7\">Updating Account Information</a></li>\r\n</ul>\r\n<dl>\r\n<dt id=\"answer1\">Shipping &amp; Delivery</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer2\">Privacy &amp; Security</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer3\">Returns &amp; Replacements</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer4\">Ordering</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer5\">Payment, Pricing &amp; Promotions</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer6\">Viewing Orders</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id=\"answer7\">Updating Account Information</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n</dl>','2013-08-09 22:43:26','2013-08-09 22:43:26',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,'Enable Cookies','one_column',NULL,NULL,'enable-cookies',NULL,'<div class=\"std\">\r\n    <ul class=\"messages\">\r\n        <li class=\"notice-msg\">\r\n            <ul>\r\n                <li>Please enable cookies in your web browser to continue.</li>\r\n            </ul>\r\n        </li>\r\n    </ul>\r\n    <div class=\"page-title\">\r\n        <h1><a name=\"top\"></a>What are Cookies?</h1>\r\n    </div>\r\n    <p>Cookies are short pieces of data that are sent to your computer when you visit a website. On later visits, this data is then returned to that website. Cookies allow us to recognize you automatically whenever you visit our site so that we can personalize your experience and provide you with better service. We also use cookies (and similar browser data, such as Flash cookies) for fraud prevention and other purposes. If your web browser is set to refuse cookies from our website, you will not be able to complete a purchase or take advantage of certain features of our website, such as storing items in your Shopping Cart or receiving personalized recommendations. As a result, we strongly encourage you to configure your web browser to accept cookies from our website.</p>\r\n    <h2 class=\"subtitle\">Enabling Cookies</h2>\r\n    <ul class=\"disc\">\r\n        <li><a href=\"#ie7\">Internet Explorer 7.x</a></li>\r\n        <li><a href=\"#ie6\">Internet Explorer 6.x</a></li>\r\n        <li><a href=\"#firefox\">Mozilla/Firefox</a></li>\r\n        <li><a href=\"#opera\">Opera 7.x</a></li>\r\n    </ul>\r\n    <h3><a name=\"ie7\"></a>Internet Explorer 7.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Start Internet Explorer</p>\r\n        </li>\r\n        <li>\r\n            <p>Under the <strong>Tools</strong> menu, click <strong>Internet Options</strong></p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-1.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Privacy</strong> tab</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-2.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Advanced</strong> button</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-3.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Put a check mark in the box for <strong>Override Automatic Cookie Handling</strong>, put another check mark in the <strong>Always accept session cookies </strong>box</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-4.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click <strong>OK</strong></p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-5.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click <strong>OK</strong></p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie7-6.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Restart Internet Explore</p>\r\n        </li>\r\n    </ol>\r\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\r\n    <h3><a name=\"ie6\"></a>Internet Explorer 6.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Select <strong>Internet Options</strong> from the Tools menu</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie6-1.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> tab</p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Default</strong> button (or manually slide the bar down to <strong>Medium</strong>) under <strong>Settings</strong>. Click <strong>OK</strong></p>\r\n            <p><img src=\"{{skin url=\"images/cookies/ie6-2.gif\"}}\" alt=\"\" /></p>\r\n        </li>\r\n    </ol>\r\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\r\n    <h3><a name=\"firefox\"></a>Mozilla/Firefox</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Click on the <strong>Tools</strong>-menu in Mozilla</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Options...</strong> item in the menu - a new window open</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> selection in the left part of the window. (See image below)</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/firefox.png\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Expand the <strong>Cookies</strong> section</p>\r\n        </li>\r\n        <li>\r\n            <p>Check the <strong>Enable cookies</strong> and <strong>Accept cookies normally</strong> checkboxes</p>\r\n        </li>\r\n        <li>\r\n            <p>Save changes by clicking <strong>Ok</strong>.</p>\r\n        </li>\r\n    </ol>\r\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\r\n    <h3><a name=\"opera\"></a>Opera 7.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Click on the <strong>Tools</strong> menu in Opera</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Preferences...</strong> item in the menu - a new window open</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> selection near the bottom left of the window. (See image below)</p>\r\n            <p><img src=\"{{skin url=\"images/cookies/opera.png\"}}\" alt=\"\" /></p>\r\n        </li>\r\n        <li>\r\n            <p>The <strong>Enable cookies</strong> checkbox must be checked, and <strong>Accept all cookies</strong> should be selected in the &quot;<strong>Normal cookies</strong>&quot; drop-down</p>\r\n        </li>\r\n        <li>\r\n            <p>Save changes by clicking <strong>Ok</strong></p>\r\n        </li>\r\n    </ol>\r\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\r\n</div>\r\n','2013-08-09 22:43:26','2013-08-09 22:43:26',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,'Privacy Policy','one_column',NULL,NULL,'privacy-policy-cookie-restriction-mode','Privacy Policy','<p style=\"color: #ff0000; font-weight: bold; font-size: 13px\">\n    Please replace this text with you Privacy Policy.\n    Please add any additional cookies your website uses below (e.g., Google Analytics)\n</p>\n<p>\n    This privacy policy sets out how {{config path=\"general/store_information/name\"}} uses and protects any information\n    that you give {{config path=\"general/store_information/name\"}} when you use this website.\n    {{config path=\"general/store_information/name\"}} is committed to ensuring that your privacy is protected.\n    Should we ask you to provide certain information by which you can be identified when using this website,\n    then you can be assured that it will only be used in accordance with this privacy statement.\n    {{config path=\"general/store_information/name\"}} may change this policy from time to time by updating this page.\n    You should check this page from time to time to ensure that you are happy with any changes.\n</p>\n<h2>What we collect</h2>\n<p>We may collect the following information:</p>\n<ul>\n    <li>name</li>\n    <li>contact information including email address</li>\n    <li>demographic information such as postcode, preferences and interests</li>\n    <li>other information relevant to customer surveys and/or offers</li>\n</ul>\n<p>\n    For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n</p>\n<h2>What we do with the information we gather</h2>\n<p>\n    We require this information to understand your needs and provide you with a better service,\n    and in particular for the following reasons:\n</p>\n<ul>\n    <li>Internal record keeping.</li>\n    <li>We may use the information to improve our products and services.</li>\n    <li>\n        We may periodically send promotional emails about new products, special offers or other information which we\n        think you may find interesting using the email address which you have provided.\n    </li>\n    <li>\n        From time to time, we may also use your information to contact you for market research purposes.\n        We may contact you by email, phone, fax or mail. We may use the information to customise the website\n        according to your interests.\n    </li>\n</ul>\n<h2>Security</h2>\n<p>\n    We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure,\n    we have put in place suitable physical, electronic and managerial procedures to safeguard and secure\n    the information we collect online.\n</p>\n<h2>How we use cookies</h2>\n<p>\n    A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n    Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n    a particular site. Cookies allow web applications to respond to you as an individual. The web application\n    can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n    your preferences.\n</p>\n<p>\n    We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page traffic\n    and improve our website in order to tailor it to customer needs. We only use this information for statistical\n    analysis purposes and then the data is removed from the system.\n</p>\n<p>\n    Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful\n    and which you do not. A cookie in no way gives us access to your computer or any information about you,\n    other than the data you choose to share with us. You can choose to accept or decline cookies.\n    Most web browsers automatically accept cookies, but you can usually modify your browser setting\n    to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n</p>\n<h2>Links to other websites</h2>\n<p>\n    Our website may contain links to other websites of interest. However, once you have used these links\n    to leave our site, you should note that we do not have any control over that other website.\n    Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n    visiting such sites and such sites are not governed by this privacy statement.\n    You should exercise caution and look at the privacy statement applicable to the website in question.\n</p>\n<h2>Controlling your personal information</h2>\n<p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n<ul>\n    <li>\n        whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n        that you do not want the information to be used by anybody for direct marketing purposes\n    </li>\n    <li>\n        if you have previously agreed to us using your personal information for direct marketing purposes,\n        you may change your mind at any time by writing to or emailing us at\n        {{config path=\"trans_email/ident_general/email\"}}\n    </li>\n</ul>\n<p>\n    We will not sell, distribute or lease your personal information to third parties unless we have your permission\n    or are required by law to do so. We may use your personal information to send you promotional information\n    about third parties which we think you may find interesting if you tell us that you wish this to happen.\n</p>\n<p>\n    You may request details of personal information which we hold about you under the Data Protection Act 1998.\n    A small fee will be payable. If you would like a copy of the information held on you please write to\n    {{config path=\"general/store_information/address\"}}.\n</p>\n<p>\n    If you believe that any information we are holding on you is incorrect or incomplete,\n    please write to or email us as soon as possible, at the above address.\n    We will promptly correct any information found to be incorrect.\n</p>\n<h2><a name=\"list\"></a>List of cookies we collect</h2>\n<p>The table below lists the cookies we collect and what information they store.</p>\n<table class=\"data-table\">\n    <thead>\n        <tr>\n            <th>COOKIE name</th>\n            <th>COOKIE Description</th>\n        </tr>\n    </thead>\n    <tbody>\n        <tr>\n            <th>CART</th>\n            <td>The association with your shopping cart.</td>\n        </tr>\n        <tr>\n            <th>CATEGORY_INFO</th>\n            <td>Stores the category info on the page, that allows to display pages more quickly.</td>\n        </tr>\n        <tr>\n            <th>COMPARE</th>\n            <td>The items that you have in the Compare Products list.</td>\n        </tr>\n        <tr>\n            <th>CURRENCY</th>\n            <td>Your preferred currency</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER</th>\n            <td>An encrypted version of your customer id with the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_AUTH</th>\n            <td>An indicator if you are currently logged into the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_INFO</th>\n            <td>An encrypted version of the customer group you belong to.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_SEGMENT_IDS</th>\n            <td>Stores the Customer Segment ID</td>\n        </tr>\n        <tr>\n            <th>EXTERNAL_NO_CACHE</th>\n            <td>A flag, which indicates whether caching is disabled or not.</td>\n        </tr>\n        <tr>\n            <th>FRONTEND</th>\n            <td>You sesssion ID on the server.</td>\n        </tr>\n        <tr>\n            <th>GUEST-VIEW</th>\n            <td>Allows guests to edit their orders.</td>\n        </tr>\n        <tr>\n            <th>LAST_CATEGORY</th>\n            <td>The last category you visited.</td>\n        </tr>\n        <tr>\n            <th>LAST_PRODUCT</th>\n            <td>The most recent product you have viewed.</td>\n        </tr>\n        <tr>\n            <th>NEWMESSAGE</th>\n            <td>Indicates whether a new message has been received.</td>\n        </tr>\n        <tr>\n            <th>NO_CACHE</th>\n            <td>Indicates whether it is allowed to use cache.</td>\n        </tr>\n        <tr>\n            <th>PERSISTENT_SHOPPING_CART</th>\n            <td>A link to information about your cart and viewing history if you have asked the site.</td>\n        </tr>\n        <tr>\n            <th>POLL</th>\n            <td>The ID of any polls you have recently voted in.</td>\n        </tr>\n        <tr>\n            <th>POLLN</th>\n            <td>Information on what polls you have voted on.</td>\n        </tr>\n        <tr>\n            <th>RECENTLYCOMPARED</th>\n            <td>The items that you have recently compared.            </td>\n        </tr>\n        <tr>\n            <th>STF</th>\n            <td>Information on products you have emailed to friends.</td>\n        </tr>\n        <tr>\n            <th>STORE</th>\n            <td>The store view or language you have selected.</td>\n        </tr>\n        <tr>\n            <th>USER_ALLOWED_SAVE_COOKIE</th>\n            <td>Indicates whether a customer allowed to use cookies.</td>\n        </tr>\n        <tr>\n            <th>VIEWED_PRODUCT_IDS</th>\n            <td>The products that you have recently viewed.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST</th>\n            <td>An encrypted list of products added to your Wishlist.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST_CNT</th>\n            <td>The number of items in your Wishlist.</td>\n        </tr>\n    </tbody>\n</table>','2013-08-09 22:43:26','2013-08-09 22:43:26',1,0,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_cms_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_cms_page_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cms_page_store`;

CREATE TABLE `mg_cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_MG_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CMS_PAGE_STORE_PAGE_ID_MG_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `mg_cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CMS_PAGE_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';

LOCK TABLES `mg_cms_page_store` WRITE;
/*!40000 ALTER TABLE `mg_cms_page_store` DISABLE KEYS */;

INSERT INTO `mg_cms_page_store` (`page_id`, `store_id`)
VALUES
	(1,0),
	(2,0),
	(3,0),
	(4,0),
	(5,0),
	(6,0);

/*!40000 ALTER TABLE `mg_cms_page_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_cache`;

CREATE TABLE `mg_core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_MG_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';



# Dump of table mg_core_cache_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_cache_option`;

CREATE TABLE `mg_core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';

LOCK TABLES `mg_core_cache_option` WRITE;
/*!40000 ALTER TABLE `mg_core_cache_option` DISABLE KEYS */;

INSERT INTO `mg_core_cache_option` (`code`, `value`)
VALUES
	('block_html',0),
	('collections',0),
	('config',0),
	('config_api',0),
	('config_api2',0),
	('eav',0),
	('layout',0),
	('translate',0);

/*!40000 ALTER TABLE `mg_core_cache_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_cache_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_cache_tag`;

CREATE TABLE `mg_core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_MG_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';



# Dump of table mg_core_config_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_config_data`;

CREATE TABLE `mg_core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_MG_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Config Data';

LOCK TABLES `mg_core_config_data` WRITE;
/*!40000 ALTER TABLE `mg_core_config_data` DISABLE KEYS */;

INSERT INTO `mg_core_config_data` (`config_id`, `scope`, `scope_id`, `path`, `value`)
VALUES
	(1,'default',0,'general/region/display_all','1'),
	(2,'default',0,'general/region/state_required','AT,EE,ES,US,CA,LV,LT,FR,RO,FI,DE,CH'),
	(3,'default',0,'catalog/category/root_id','2'),
	(4,'default',0,'admin/dashboard/enable_charts','1'),
	(5,'default',0,'web/unsecure/base_url','http://magento/'),
	(6,'default',0,'web/secure/base_url','http://magento/'),
	(7,'default',0,'general/locale/code','en_GB'),
	(8,'default',0,'general/locale/timezone','Europe/Moscow'),
	(9,'default',0,'currency/options/base','LTL'),
	(10,'default',0,'currency/options/default','LTL'),
	(11,'default',0,'currency/options/allow','LTL'),
	(12,'default',0,'general/country/default','US'),
	(13,'default',0,'general/country/allow','AF,IE,AX,AL,DZ,AS,AD,AI,AO,AQ,AG,AR,AM,AW,AU,AT,AZ,BS,BH,BY,BD,BB,BE,BZ,BJ,BM,GW,BO,BA,BW,BV,BR,BN,BG,BF,BI,BT,CF,DK,GB,VG,DM,DO,CI,JE,DJ,EG,EC,ER,EE,ET,FK,FO,FJ,PH,GA,GY,GM,GH,GI,GR,GD,GL,GE,GU,GG,GP,GT,GN,HT,HM,HN,IN,IO,ID,IQ,IR,IS,ES,IT,IL,JM,JP,YE,JO,AE,UM,US,ME,KY,CX,KH,CM,CA,QA,KZ,KE,CN,HK,CY,KG,KI,CC,CO,KM,CG,CD,CR,HR,CU,CK,KW,LA,LV,PL,LS,LB,LR,LY,LI,LT,LU,MO,MG,MK,MY,MW,MV,ML,MT,MP,MA,MQ,MH,MU,MR,YT,IM,MX,VI,MM,FM,MD,MC,MN,MS,MZ,NA,NC,NZ,NR,NP,NG,NE,NI,NU,NF,NO,NL,AN,OM,PK,PW,PS,PA,PG,PY,PE,ZA,GS,KR,PN,PT,FR,GF,TF,PF,PR,GQ,RE,RW,RO,RU,TL,MF,SB,SV,WS,SM,ST,SA,SC,PM,SN,KN,RS,SL,SG,SY,SK,SI,SO,SD,FI,SR,SJ,SZ,TJ,TH,TW,TZ,TG,TK,TO,TT,TN,TR,TM,TC,TV,UG,UA,UY,UZ,EH,VU,VA,VE,HU,VN,DE,WF,ZM,ZW,TD,CZ,CL,KP,LK,SE,CH,VC,BL,SH,LC,CV'),
	(14,'default',0,'general/country/optional_zip_countries','IE,HK,MO,PA'),
	(15,'default',0,'general/country/eu_countries','IE,AT,BE,BG,DK,GB,EE,GR,ES,IT,CY,LV,PL,LT,LU,MT,NL,PT,FR,RO,SK,SI,FI,HU,DE,CZ,SE'),
	(16,'default',0,'general/locale/firstday','0'),
	(17,'default',0,'general/locale/weekend','0,6'),
	(18,'default',0,'general/store_information/name',NULL),
	(19,'default',0,'general/store_information/phone',NULL),
	(20,'default',0,'general/store_information/merchant_country',NULL),
	(21,'default',0,'general/store_information/merchant_vat_number',NULL),
	(22,'default',0,'general/store_information/address',NULL);

/*!40000 ALTER TABLE `mg_core_config_data` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_email_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_email_template`;

CREATE TABLE `mg_core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_MG_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_MG_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_MG_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';



# Dump of table mg_core_flag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_flag`;

CREATE TABLE `mg_core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_MG_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flag';

LOCK TABLES `mg_core_flag` WRITE;
/*!40000 ALTER TABLE `mg_core_flag` DISABLE KEYS */;

INSERT INTO `mg_core_flag` (`flag_id`, `flag_code`, `state`, `flag_data`, `last_update`)
VALUES
	(1,'admin_notification_survey',0,'a:1:{s:13:\"survey_viewed\";b:1;}','2013-08-09 22:44:35'),
	(2,'catalog_product_flat',0,'a:1:{s:8:\"is_built\";b:1;}','2013-08-12 21:08:46');

/*!40000 ALTER TABLE `mg_core_flag` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_layout_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_layout_link`;

CREATE TABLE `mg_core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_MG_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_MG_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_1607CB0E4832106A5C1165C4C588FC4E` FOREIGN KEY (`layout_update_id`) REFERENCES `mg_core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CORE_LAYOUT_LINK_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';



# Dump of table mg_core_layout_update
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_layout_update`;

CREATE TABLE `mg_core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_MG_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';



# Dump of table mg_core_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_resource`;

CREATE TABLE `mg_core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';

LOCK TABLES `mg_core_resource` WRITE;
/*!40000 ALTER TABLE `mg_core_resource` DISABLE KEYS */;

INSERT INTO `mg_core_resource` (`code`, `version`, `data_version`)
VALUES
	('adminnotification_setup','1.6.0.0','1.6.0.0'),
	('admin_setup','1.6.1.0','1.6.1.0'),
	('api2_setup','1.0.0.0','1.0.0.0'),
	('api_setup','1.6.0.0','1.6.0.0'),
	('backup_setup','1.6.0.0','1.6.0.0'),
	('bundle_setup','1.6.0.0.1','1.6.0.0.1'),
	('captcha_setup','1.7.0.0.0','1.7.0.0.0'),
	('catalogindex_setup','1.6.0.0','1.6.0.0'),
	('cataloginventory_setup','1.6.0.0.2','1.6.0.0.2'),
	('catalogrule_setup','1.6.0.3','1.6.0.3'),
	('catalogsearch_setup','1.6.0.0','1.6.0.0'),
	('catalog_setup','1.6.0.0.14','1.6.0.0.14'),
	('checkout_setup','1.6.0.0','1.6.0.0'),
	('cms_setup','1.6.0.0.1','1.6.0.0.1'),
	('compiler_setup','1.6.0.0','1.6.0.0'),
	('contacts_setup','1.6.0.0','1.6.0.0'),
	('core_setup','1.6.0.2','1.6.0.2'),
	('cron_setup','1.6.0.0','1.6.0.0'),
	('customer_setup','1.6.2.0.1','1.6.2.0.1'),
	('dataflow_setup','1.6.0.0','1.6.0.0'),
	('directory_setup','1.6.0.1','1.6.0.1'),
	('downloadable_setup','1.6.0.0.2','1.6.0.0.2'),
	('eav_setup','1.6.0.0','1.6.0.0'),
	('giftmessage_setup','1.6.0.0','1.6.0.0'),
	('googlecheckout_setup','1.6.0.1','1.6.0.1'),
	('importexport_setup','1.6.0.2','1.6.0.2'),
	('index_setup','1.6.0.0','1.6.0.0'),
	('log_setup','1.6.0.0','1.6.0.0'),
	('moneybookers_setup','1.6.0.0','1.6.0.0'),
	('newsletter_setup','1.6.0.1','1.6.0.1'),
	('oauth_setup','1.0.0.0','1.0.0.0'),
	('paygate_setup','1.6.0.0','1.6.0.0'),
	('payment_setup','1.6.0.0','1.6.0.0'),
	('paypaluk_setup','1.6.0.0','1.6.0.0'),
	('paypal_setup','1.6.0.2','1.6.0.2'),
	('persistent_setup','1.0.0.0','1.0.0.0'),
	('poll_setup','1.6.0.0','1.6.0.0'),
	('productalert_setup','1.6.0.0','1.6.0.0'),
	('rating_setup','1.6.0.0','1.6.0.0'),
	('reports_setup','1.6.0.0.1','1.6.0.0.1'),
	('review_setup','1.6.0.0','1.6.0.0'),
	('salesrule_setup','1.6.0.3','1.6.0.3'),
	('sales_setup','1.6.0.7','1.6.0.7'),
	('sendfriend_setup','1.6.0.0','1.6.0.0'),
	('shipping_setup','1.6.0.0','1.6.0.0'),
	('sitemap_setup','1.6.0.0','1.6.0.0'),
	('tag_setup','1.6.0.0','1.6.0.0'),
	('tax_setup','1.6.0.3','1.6.0.3'),
	('usa_setup','1.6.0.1','1.6.0.1'),
	('weee_setup','1.6.0.0','1.6.0.0'),
	('widget_setup','1.6.0.0','1.6.0.0'),
	('wishlist_setup','1.6.0.0','1.6.0.0'),
	('xmlconnect_setup','1.6.0.0','1.6.0.0');

/*!40000 ALTER TABLE `mg_core_resource` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_session`;

CREATE TABLE `mg_core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';

LOCK TABLES `mg_core_session` WRITE;
/*!40000 ALTER TABLE `mg_core_session` DISABLE KEYS */;

INSERT INTO `mg_core_session` (`session_id`, `session_expires`, `session_data`)
VALUES
	('8eec568550f03ca5c6c554b78d9d23bf',1377354755,X'636F72657C613A363A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D733A31353A226A7573745F766F7465645F706F6C6C223B623A303B733A31323A2276697369746F725F64617461223B613A31363A7B733A303A22223B4E3B733A31313A227365727665725F61646472223B693A323133303730363433333B733A31313A2272656D6F74655F61646472223B693A323133303730363433333B733A31313A22687474705F736563757265223B623A303B733A393A22687474705F686F7374223B733A373A226D6167656E746F223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B733A32303A22687474705F6163636570745F6C616E6775616765223B733A31343A22656E2D55532C656E3B713D302E35223B733A31393A22687474705F6163636570745F63686172736574223B733A303A22223B733A31313A22726571756573745F757269223B733A313A222F223B733A31303A2273657373696F6E5F6964223B733A33323A223865656335363835353066303363613563366335353462373864396432336266223B733A31323A22687474705F72656665726572223B733A303A22223B733A31343A2266697273745F76697369745F6174223B733A31393A22323031332D30382D32342031333A33323A3333223B733A31343A2269735F6E65775F76697369746F72223B623A303B733A31333A226C6173745F76697369745F6174223B733A31393A22323031332D30382D32342031333A33323A3335223B733A31303A2276697369746F725F6964223B733A323A223131223B733A31313A226C6173745F75726C5F6964223B733A323A223135223B7D733A383A226C6173745F75726C223B733A34313A22687474703A2F2F6D6167656E746F2F696E6465782E7068702F636D732F696E6465782F696E6465782F223B7D637573746F6D65725F626173657C613A343A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D733A31393A22776973686C6973745F6974656D5F636F756E74223B693A303B7D636865636B6F75747C613A333A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D7D636174616C6F677C613A343A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D733A32373A22636174616C6F675F636F6D706172655F6974656D735F636F756E74223B693A303B7D7265706F7274737C613A343A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A32363A2270726F647563745F696E6465785F7669657765645F636F756E74223B693A303B733A32383A2270726F647563745F696E6465785F636F6D70617265645F636F756E74223B693A303B7D'),
	('c60cd86f0ae3b5b8c0c9a2e58d242daa',1377356093,X'636F72657C613A343A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A393A225F666F726D5F6B6579223B733A31363A22774651546E6C66526A41656474395348223B733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D7D61646D696E68746D6C7C613A343A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A363A226C6F63616C65223B733A353A22656E5F4742223B733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D7D61646D696E7C613A353A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A32333A2273796E635F70726F636573735F73746F705F7761746368223B623A303B733A343A2275736572223B4F3A32313A224D6167655F41646D696E5F4D6F64656C5F55736572223A31373A7B733A31353A22002A005F6576656E74507265666978223B733A31303A2261646D696E5F75736572223B733A383A22002A005F726F6C65223B4E3B733A32353A22002A005F686173417661696C61626C655265736F7572636573223B623A313B733A31353A22002A005F6576656E744F626A656374223B733A363A226F626A656374223B733A31363A22002A005F7265736F757263654E616D65223B733A31303A2261646D696E2F75736572223B733A31323A22002A005F7265736F75726365223B4E3B733A32363A22002A005F7265736F75726365436F6C6C656374696F6E4E616D65223B733A32313A2261646D696E2F757365725F636F6C6C656374696F6E223B733A31323A22002A005F6361636865546167223B623A303B733A31393A22002A005F6461746153617665416C6C6F776564223B623A313B733A31353A22002A005F69734F626A6563744E6577223B4E3B733A383A22002A005F64617461223B613A31353A7B733A373A22757365725F6964223B733A313A2231223B733A393A2266697273746E616D65223B733A373A22417572696D6173223B733A383A226C6173746E616D65223B733A373A22417572696D6173223B733A353A22656D61696C223B733A32303A22617572696D617364677440676D61696C2E636F6D223B733A383A22757365726E616D65223B733A31303A22617572696D6173646774223B733A383A2270617373776F7264223B733A33353A2266656365646635663335346632353062333438343062363566656364646633613A636B223B733A373A2263726561746564223B733A31393A22323031332D30382D32342031363A33323A3534223B733A383A226D6F646966696564223B733A31393A22323031332D30382D30392032323A34343A3335223B733A373A226C6F6764617465223B733A31393A22323031332D30382D32342031333A33323A3534223B733A363A226C6F676E756D223B733A323A223233223B733A31353A2272656C6F61645F61636C5F666C6167223B733A313A2230223B733A393A2269735F616374697665223B733A313A2231223B733A353A226578747261223B613A313A7B733A31313A22636F6E6669675374617465223B613A343A7B733A31353A2267656E6572616C5F636F756E747279223B733A313A2230223B733A31343A2267656E6572616C5F726567696F6E223B733A313A2230223B733A31343A2267656E6572616C5F6C6F63616C65223B733A313A2231223B733A32353A2267656E6572616C5F73746F72655F696E666F726D6174696F6E223B733A313A2230223B7D7D733A383A2272705F746F6B656E223B4E3B733A31393A2272705F746F6B656E5F637265617465645F6174223B4E3B7D733A31383A22002A005F686173446174614368616E676573223B623A303B733A31323A22002A005F6F72696744617461223B613A31353A7B733A373A22757365725F6964223B733A313A2231223B733A393A2266697273746E616D65223B733A373A22417572696D6173223B733A383A226C6173746E616D65223B733A373A22417572696D6173223B733A353A22656D61696C223B733A32303A22617572696D617364677440676D61696C2E636F6D223B733A383A22757365726E616D65223B733A31303A22617572696D6173646774223B733A383A2270617373776F7264223B733A33353A2266656365646635663335346632353062333438343062363566656364646633613A636B223B733A373A2263726561746564223B733A31393A22323031332D30382D32342031363A33323A3534223B733A383A226D6F646966696564223B733A31393A22323031332D30382D30392032323A34343A3335223B733A373A226C6F6764617465223B733A31393A22323031332D30382D32342031333A33323A3534223B733A363A226C6F676E756D223B733A323A223233223B733A31353A2272656C6F61645F61636C5F666C6167223B733A313A2230223B733A393A2269735F616374697665223B733A313A2231223B733A353A226578747261223B613A313A7B733A31313A22636F6E6669675374617465223B613A343A7B733A31353A2267656E6572616C5F636F756E747279223B733A313A2230223B733A31343A2267656E6572616C5F726567696F6E223B733A313A2230223B733A31343A2267656E6572616C5F6C6F63616C65223B733A313A2231223B733A32353A2267656E6572616C5F73746F72655F696E666F726D6174696F6E223B733A313A2230223B7D7D733A383A2272705F746F6B656E223B4E3B733A31393A2272705F746F6B656E5F637265617465645F6174223B4E3B7D733A31353A22002A005F69644669656C644E616D65223B733A373A22757365725F6964223B733A31333A22002A005F697344656C65746564223B623A303B733A31363A22002A005F6F6C644669656C64734D6170223B613A303A7B7D733A31373A22002A005F73796E634669656C64734D6170223B613A303A7B7D7D733A333A2261636C223B4F3A32303A224D6167655F41646D696E5F4D6F64656C5F41636C223A363A7B733A31363A22002A005F726F6C655265676973747279223B4F3A33343A224D6167655F41646D696E5F4D6F64656C5F41636C5F526F6C655F5265676973747279223A313A7B733A393A22002A005F726F6C6573223B613A323A7B733A323A224731223B613A333A7B733A383A22696E7374616E6365223B4F3A33313A224D6167655F41646D696E5F4D6F64656C5F41636C5F526F6C655F47726F7570223A313A7B733A31303A22002A005F726F6C654964223B733A323A224731223B7D733A373A22706172656E7473223B613A303A7B7D733A383A226368696C6472656E223B613A313A7B733A323A225531223B4F3A33303A224D6167655F41646D696E5F4D6F64656C5F41636C5F526F6C655F55736572223A313A7B733A31303A22002A005F726F6C654964223B733A323A225531223B7D7D7D733A323A225531223B613A333A7B733A383A22696E7374616E6365223B723A3130303B733A373A22706172656E7473223B613A313A7B733A323A224731223B723A39363B7D733A383A226368696C6472656E223B613A303A7B7D7D7D7D733A31333A22002A005F7265736F7572636573223B613A3230323A7B733A333A22616C6C223B613A333A7B733A383A22696E7374616E6365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A333A22616C6C223B7D733A363A22706172656E74223B4E3B733A383A226368696C6472656E223B613A303A7B7D7D733A353A2261646D696E223B613A333A7B733A383A22696E7374616E6365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A353A2261646D696E223B7D733A363A22706172656E74223B4E3B733A383A226368696C6472656E223B613A31333A7B733A31353A2261646D696E2F64617368626F617264223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31353A2261646D696E2F64617368626F617264223B7D733A31323A2261646D696E2F73797374656D223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31323A2261646D696E2F73797374656D223B7D733A31393A2261646D696E2F676C6F62616C5F736561726368223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F676C6F62616C5F736561726368223B7D733A393A2261646D696E2F636D73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A393A2261646D696E2F636D73223B7D733A31343A2261646D696E2F637573746F6D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31343A2261646D696E2F637573746F6D6572223B7D733A31333A2261646D696E2F636174616C6F67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31333A2261646D696E2F636174616C6F67223B7D733A31313A2261646D696E2F70726F6D6F223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31313A2261646D696E2F70726F6D6F223B7D733A31313A2261646D696E2F73616C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31313A2261646D696E2F73616C6573223B7D733A31323A2261646D696E2F7265706F7274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31323A2261646D696E2F7265706F7274223B7D733A31363A2261646D696E2F6E6577736C6574746572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31363A2261646D696E2F6E6577736C6574746572223B7D733A31363A2261646D696E2F706167655F6361636865223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31363A2261646D696E2F706167655F6361636865223B7D733A31363A2261646D696E2F786D6C636F6E6E656374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31363A2261646D696E2F786D6C636F6E6E656374223B7D733A32383A2261646D696E2F4F6666695F437573746F6D6572417474726962757465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F4F6666695F437573746F6D6572417474726962757465223B7D7D7D733A31353A2261646D696E2F64617368626F617264223B613A333A7B733A383A22696E7374616E6365223B723A3131383B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A303A7B7D7D733A31323A2261646D696E2F73797374656D223B613A333A7B733A383A22696E7374616E6365223B723A3132303B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A31363A7B733A31363A2261646D696E2F73797374656D2F61636C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31363A2261646D696E2F73797374656D2F61636C223B7D733A31383A2261646D696E2F73797374656D2F73746F7265223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31383A2261646D696E2F73797374656D2F73746F7265223B7D733A31393A2261646D696E2F73797374656D2F64657369676E223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F73797374656D2F64657369676E223B7D733A31393A2261646D696E2F73797374656D2F636F6E666967223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F73797374656D2F636F6E666967223B7D733A32313A2261646D696E2F73797374656D2F63757272656E6379223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F73797374656D2F63757272656E6379223B7D733A32373A2261646D696E2F73797374656D2F656D61696C5F74656D706C617465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F656D61696C5F74656D706C617465223B7D733A32313A2261646D696E2F73797374656D2F7661726961626C65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F73797374656D2F7661726961626C65223B7D733A32323A2261646D696E2F73797374656D2F6D796163636F756E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73797374656D2F6D796163636F756E74223B7D733A31383A2261646D696E2F73797374656D2F746F6F6C73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31383A2261646D696E2F73797374656D2F746F6F6C73223B7D733A32303A2261646D696E2F73797374656D2F636F6E76657274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32303A2261646D696E2F73797374656D2F636F6E76657274223B7D733A31383A2261646D696E2F73797374656D2F6361636865223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31383A2261646D696E2F73797374656D2F6361636865223B7D733A32333A2261646D696E2F73797374656D2F657874656E73696F6E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F657874656E73696F6E73223B7D733A33303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E223B7D733A31383A2261646D696E2F73797374656D2F696E646578223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31383A2261646D696E2F73797374656D2F696E646578223B7D733A32373A2261646D696E2F73797374656D2F6F726465725F7374617475736573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F6F726465725F7374617475736573223B7D733A31363A2261646D696E2F73797374656D2F617069223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31363A2261646D696E2F73797374656D2F617069223B7D7D7D733A31363A2261646D696E2F73797374656D2F61636C223B613A333A7B733A383A22696E7374616E6365223B723A3135323B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A323A7B733A32323A2261646D696E2F73797374656D2F61636C2F726F6C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73797374656D2F61636C2F726F6C6573223B7D733A32323A2261646D696E2F73797374656D2F61636C2F7573657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73797374656D2F61636C2F7573657273223B7D7D7D733A32323A2261646D696E2F73797374656D2F61636C2F726F6C6573223B613A333A7B733A383A22696E7374616E6365223B723A3138383B733A363A22706172656E74223B723A3135323B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F73797374656D2F61636C2F7573657273223B613A333A7B733A383A22696E7374616E6365223B723A3139303B733A363A22706172656E74223B723A3135323B733A383A226368696C6472656E223B613A303A7B7D7D733A31383A2261646D696E2F73797374656D2F73746F7265223B613A333A7B733A383A22696E7374616E6365223B723A3135343B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F73797374656D2F64657369676E223B613A333A7B733A383A22696E7374616E6365223B723A3135363B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F73797374656D2F636F6E666967223B613A333A7B733A383A22696E7374616E6365223B723A3135383B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A33373A7B733A32373A2261646D696E2F73797374656D2F636F6E6669672F67656E6572616C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E6669672F67656E6572616C223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F776562223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F776562223B7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F64657369676E223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F73797374656D2F636F6E6669672F64657369676E223B7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F73797374656D223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F73797374656D2F636F6E6669672F73797374656D223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F616476616E636564223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F616476616E636564223B7D733A33313A2261646D696E2F73797374656D2F636F6E6669672F7472616E735F656D61696C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F73797374656D2F636F6E6669672F7472616E735F656D61696C223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F646576223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F646576223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F63757272656E6379223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F63757272656E6379223B7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F73656E64667269656E64223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F636F6E6669672F73656E64667269656E64223B7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F61646D696E223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F636F6E6669672F61646D696E223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F636D73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F636D73223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F637573746F6D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F637573746F6D6572223B7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67223B7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E74223B7D733A33363A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E745F7365727669636573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33363A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E745F7365727669636573223B7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F73616C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F636F6E6669672F73616C6573223B7D733A33313A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F656D61696C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F656D61696C223B7D733A32393A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F706466223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F706466223B7D733A33363A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67696E76656E746F7279223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33363A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67696E76656E746F7279223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F7368697070696E67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F7368697070696E67223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F6361727269657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F6361727269657273223B7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F70726F6D6F223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F636F6E6669672F70726F6D6F223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F636865636B6F7574223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F636865636B6F7574223B7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F70617970616C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F73797374656D2F636F6E6669672F70617970616C223B7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F676F6F676C65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F73797374656D2F636F6E6669672F676F6F676C65223B7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F7265706F727473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E6669672F7265706F727473223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F746178223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F746178223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F776973686C697374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F776973686C697374223B7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F636F6E7461637473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F73797374656D2F636F6E6669672F636F6E7461637473223B7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F736974656D6170223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E6669672F736974656D6170223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F727373223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F727373223B7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F617069223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F73797374656D2F636F6E6669672F617069223B7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F6F61757468223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F636F6E6669672F6F61757468223B7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F6E6577736C6574746572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F636F6E6669672F6E6577736C6574746572223B7D733A33323A2261646D696E2F73797374656D2F636F6E6669672F646F776E6C6F616461626C65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73797374656D2F636F6E6669672F646F776E6C6F616461626C65223B7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F70657273697374656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F636F6E6669672F70657273697374656E74223B7D733A33323A2261646D696E2F73797374656D2F636F6E6669672F6D6F6E6579626F6F6B657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73797374656D2F636F6E6669672F6D6F6E6579626F6F6B657273223B7D7D7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F67656E6572616C223B613A333A7B733A383A22696E7374616E6365223B723A3231323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F776562223B613A333A7B733A383A22696E7374616E6365223B723A3231343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F64657369676E223B613A333A7B733A383A22696E7374616E6365223B723A3231363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F73797374656D223B613A333A7B733A383A22696E7374616E6365223B723A3231383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F616476616E636564223B613A333A7B733A383A22696E7374616E6365223B723A3232303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F73797374656D2F636F6E6669672F7472616E735F656D61696C223B613A333A7B733A383A22696E7374616E6365223B723A3232323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F646576223B613A333A7B733A383A22696E7374616E6365223B723A3232343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F63757272656E6379223B613A333A7B733A383A22696E7374616E6365223B723A3232363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F73656E64667269656E64223B613A333A7B733A383A22696E7374616E6365223B723A3232383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F61646D696E223B613A333A7B733A383A22696E7374616E6365223B723A3233303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F636D73223B613A333A7B733A383A22696E7374616E6365223B723A3233323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F637573746F6D6572223B613A333A7B733A383A22696E7374616E6365223B723A3233343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67223B613A333A7B733A383A22696E7374616E6365223B723A3233363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3233383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33363A2261646D696E2F73797374656D2F636F6E6669672F7061796D656E745F7365727669636573223B613A333A7B733A383A22696E7374616E6365223B723A3234303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F73616C6573223B613A333A7B733A383A22696E7374616E6365223B723A3234323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F656D61696C223B613A333A7B733A383A22696E7374616E6365223B723A3234343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73797374656D2F636F6E6669672F73616C65735F706466223B613A333A7B733A383A22696E7374616E6365223B723A3234363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33363A2261646D696E2F73797374656D2F636F6E6669672F636174616C6F67696E76656E746F7279223B613A333A7B733A383A22696E7374616E6365223B723A3234383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F7368697070696E67223B613A333A7B733A383A22696E7374616E6365223B723A3235303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F6361727269657273223B613A333A7B733A383A22696E7374616E6365223B723A3235323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F70726F6D6F223B613A333A7B733A383A22696E7374616E6365223B723A3235343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F636865636B6F7574223B613A333A7B733A383A22696E7374616E6365223B723A3235363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F70617970616C223B613A333A7B733A383A22696E7374616E6365223B723A3235383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F73797374656D2F636F6E6669672F676F6F676C65223B613A333A7B733A383A22696E7374616E6365223B723A3236303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F7265706F727473223B613A333A7B733A383A22696E7374616E6365223B723A3236323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F746178223B613A333A7B733A383A22696E7374616E6365223B723A3236343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F776973686C697374223B613A333A7B733A383A22696E7374616E6365223B723A3236363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F73797374656D2F636F6E6669672F636F6E7461637473223B613A333A7B733A383A22696E7374616E6365223B723A3236383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E6669672F736974656D6170223B613A333A7B733A383A22696E7374616E6365223B723A3237303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F727373223B613A333A7B733A383A22696E7374616E6365223B723A3237323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F636F6E6669672F617069223B613A333A7B733A383A22696E7374616E6365223B723A3237343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F73797374656D2F636F6E6669672F6F61757468223B613A333A7B733A383A22696E7374616E6365223B723A3237363B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F6E6577736C6574746572223B613A333A7B733A383A22696E7374616E6365223B723A3237383B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73797374656D2F636F6E6669672F646F776E6C6F616461626C65223B613A333A7B733A383A22696E7374616E6365223B723A3238303B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73797374656D2F636F6E6669672F70657273697374656E74223B613A333A7B733A383A22696E7374616E6365223B723A3238323B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73797374656D2F636F6E6669672F6D6F6E6579626F6F6B657273223B613A333A7B733A383A22696E7374616E6365223B723A3238343B733A363A22706172656E74223B723A3135383B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F73797374656D2F63757272656E6379223B613A333A7B733A383A22696E7374616E6365223B723A3136303B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A323A7B733A32373A2261646D696E2F73797374656D2F63757272656E63792F7261746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F63757272656E63792F7261746573223B7D733A32393A2261646D696E2F73797374656D2F63757272656E63792F73796D626F6C73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73797374656D2F63757272656E63792F73796D626F6C73223B7D7D7D733A32373A2261646D696E2F73797374656D2F63757272656E63792F7261746573223B613A333A7B733A383A22696E7374616E6365223B723A3433383B733A363A22706172656E74223B723A3136303B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73797374656D2F63757272656E63792F73796D626F6C73223B613A333A7B733A383A22696E7374616E6365223B723A3434303B733A363A22706172656E74223B723A3136303B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F656D61696C5F74656D706C617465223B613A333A7B733A383A22696E7374616E6365223B723A3136323B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F73797374656D2F7661726961626C65223B613A333A7B733A383A22696E7374616E6365223B723A3136343B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F73797374656D2F6D796163636F756E74223B613A333A7B733A383A22696E7374616E6365223B723A3136363B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A31383A2261646D696E2F73797374656D2F746F6F6C73223B613A333A7B733A383A22696E7374616E6365223B723A3136383B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A323A7B733A32353A2261646D696E2F73797374656D2F746F6F6C732F6261636B7570223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F746F6F6C732F6261636B7570223B7D733A32373A2261646D696E2F73797374656D2F746F6F6C732F636F6D70696C6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F746F6F6C732F636F6D70696C6572223B7D7D7D733A32353A2261646D696E2F73797374656D2F746F6F6C732F6261636B7570223B613A333A7B733A383A22696E7374616E6365223B723A3436363B733A363A22706172656E74223B723A3136383B733A383A226368696C6472656E223B613A313A7B733A33343A2261646D696E2F73797374656D2F746F6F6C732F6261636B75702F726F6C6C6261636B223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33343A2261646D696E2F73797374656D2F746F6F6C732F6261636B75702F726F6C6C6261636B223B7D7D7D733A33343A2261646D696E2F73797374656D2F746F6F6C732F6261636B75702F726F6C6C6261636B223B613A333A7B733A383A22696E7374616E6365223B723A3437343B733A363A22706172656E74223B723A3436363B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F746F6F6C732F636F6D70696C6572223B613A333A7B733A383A22696E7374616E6365223B723A3436383B733A363A22706172656E74223B723A3136383B733A383A226368696C6472656E223B613A303A7B7D7D733A32303A2261646D696E2F73797374656D2F636F6E76657274223B613A333A7B733A383A22696E7374616E6365223B723A3137303B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A343A7B733A32343A2261646D696E2F73797374656D2F636F6E766572742F677569223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F73797374656D2F636F6E766572742F677569223B7D733A32393A2261646D696E2F73797374656D2F636F6E766572742F70726F66696C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73797374656D2F636F6E766572742F70726F66696C6573223B7D733A32373A2261646D696E2F73797374656D2F636F6E766572742F696D706F7274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E766572742F696D706F7274223B7D733A32373A2261646D696E2F73797374656D2F636F6E766572742F6578706F7274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F636F6E766572742F6578706F7274223B7D7D7D733A32343A2261646D696E2F73797374656D2F636F6E766572742F677569223B613A333A7B733A383A22696E7374616E6365223B723A3438383B733A363A22706172656E74223B723A3137303B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73797374656D2F636F6E766572742F70726F66696C6573223B613A333A7B733A383A22696E7374616E6365223B723A3439303B733A363A22706172656E74223B723A3137303B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E766572742F696D706F7274223B613A333A7B733A383A22696E7374616E6365223B723A3439323B733A363A22706172656E74223B723A3137303B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F636F6E766572742F6578706F7274223B613A333A7B733A383A22696E7374616E6365223B723A3439343B733A363A22706172656E74223B723A3137303B733A383A226368696C6472656E223B613A303A7B7D7D733A31383A2261646D696E2F73797374656D2F6361636865223B613A333A7B733A383A22696E7374616E6365223B723A3137323B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F73797374656D2F657874656E73696F6E73223B613A333A7B733A383A22696E7374616E6365223B723A3137343B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A323A7B733A32393A2261646D696E2F73797374656D2F657874656E73696F6E732F6C6F63616C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73797374656D2F657874656E73696F6E732F6C6F63616C223B7D733A33303A2261646D696E2F73797374656D2F657874656E73696F6E732F637573746F6D223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F657874656E73696F6E732F637573746F6D223B7D7D7D733A32393A2261646D696E2F73797374656D2F657874656E73696F6E732F6C6F63616C223B613A333A7B733A383A22696E7374616E6365223B723A3532303B733A363A22706172656E74223B723A3137343B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73797374656D2F657874656E73696F6E732F637573746F6D223B613A333A7B733A383A22696E7374616E6365223B723A3532323B733A363A22706172656E74223B723A3137343B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E223B613A333A7B733A383A22696E7374616E6365223B723A3137363B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A343A7B733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F746F6F6C626172223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F746F6F6C626172223B7D733A34303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F6C697374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F6C697374223B7D733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F6D61726B5F61735F72656164223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F6D61726B5F61735F72656164223B7D733A33373A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F72656D6F7665223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33373A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F72656D6F7665223B7D7D7D733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F746F6F6C626172223B613A333A7B733A383A22696E7374616E6365223B723A3533363B733A363A22706172656E74223B723A3137363B733A383A226368696C6472656E223B613A303A7B7D7D733A34303A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F73686F775F6C697374223B613A333A7B733A383A22696E7374616E6365223B723A3533383B733A363A22706172656E74223B723A3137363B733A383A226368696C6472656E223B613A303A7B7D7D733A34333A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F6D61726B5F61735F72656164223B613A333A7B733A383A22696E7374616E6365223B723A3534303B733A363A22706172656E74223B723A3137363B733A383A226368696C6472656E223B613A303A7B7D7D733A33373A2261646D696E2F73797374656D2F61646D696E6E6F74696669636174696F6E2F72656D6F7665223B613A333A7B733A383A22696E7374616E6365223B723A3534323B733A363A22706172656E74223B723A3137363B733A383A226368696C6472656E223B613A303A7B7D7D733A31383A2261646D696E2F73797374656D2F696E646578223B613A333A7B733A383A22696E7374616E6365223B723A3137383B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F6F726465725F7374617475736573223B613A333A7B733A383A22696E7374616E6365223B723A3138303B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A303A7B7D7D733A31363A2261646D696E2F73797374656D2F617069223B613A333A7B733A383A22696E7374616E6365223B723A3138323B733A363A22706172656E74223B723A3132303B733A383A226368696C6472656E223B613A373A7B733A32323A2261646D696E2F73797374656D2F6170692F7573657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73797374656D2F6170692F7573657273223B7D733A32323A2261646D696E2F73797374656D2F6170692F726F6C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73797374656D2F6170692F726F6C6573223B7D733A32353A2261646D696E2F73797374656D2F6170692F636F6E73756D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73797374656D2F6170692F636F6E73756D6572223B7D733A33333A2261646D696E2F73797374656D2F6170692F617574686F72697A6564546F6B656E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F73797374656D2F6170692F617574686F72697A6564546F6B656E73223B7D733A33343A2261646D696E2F73797374656D2F6170692F6F617574685F61646D696E5F746F6B656E223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33343A2261646D696E2F73797374656D2F6170692F6F617574685F61646D696E5F746F6B656E223B7D733A32373A2261646D696E2F73797374656D2F6170692F726573745F726F6C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F73797374656D2F6170692F726573745F726F6C6573223B7D733A33323A2261646D696E2F73797374656D2F6170692F726573745F61747472696275746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73797374656D2F6170692F726573745F61747472696275746573223B7D7D7D733A32323A2261646D696E2F73797374656D2F6170692F7573657273223B613A333A7B733A383A22696E7374616E6365223B723A3537323B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F73797374656D2F6170692F726F6C6573223B613A333A7B733A383A22696E7374616E6365223B723A3537343B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F73797374656D2F6170692F636F6E73756D6572223B613A333A7B733A383A22696E7374616E6365223B723A3537363B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A323A7B733A33303A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F65646974223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F65646974223B7D733A33323A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F64656C657465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F64656C657465223B7D7D7D733A33303A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F65646974223B613A333A7B733A383A22696E7374616E6365223B723A3539383B733A363A22706172656E74223B723A3537363B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73797374656D2F6170692F636F6E73756D65722F64656C657465223B613A333A7B733A383A22696E7374616E6365223B723A3630303B733A363A22706172656E74223B723A3537363B733A383A226368696C6472656E223B613A303A7B7D7D733A33333A2261646D696E2F73797374656D2F6170692F617574686F72697A6564546F6B656E73223B613A333A7B733A383A22696E7374616E6365223B723A3537383B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A303A7B7D7D733A33343A2261646D696E2F73797374656D2F6170692F6F617574685F61646D696E5F746F6B656E223B613A333A7B733A383A22696E7374616E6365223B723A3538303B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F73797374656D2F6170692F726573745F726F6C6573223B613A333A7B733A383A22696E7374616E6365223B723A3538323B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A333A7B733A33313A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F616464223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F616464223B7D733A33323A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F65646974223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F65646974223B7D733A33343A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F64656C657465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33343A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F64656C657465223B7D7D7D733A33313A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F616464223B613A333A7B733A383A22696E7374616E6365223B723A3632323B733A363A22706172656E74223B723A3538323B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F65646974223B613A333A7B733A383A22696E7374616E6365223B723A3632343B733A363A22706172656E74223B723A3538323B733A383A226368696C6472656E223B613A303A7B7D7D733A33343A2261646D696E2F73797374656D2F6170692F726573745F726F6C65732F64656C657465223B613A333A7B733A383A22696E7374616E6365223B723A3632363B733A363A22706172656E74223B723A3538323B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73797374656D2F6170692F726573745F61747472696275746573223B613A333A7B733A383A22696E7374616E6365223B723A3538343B733A363A22706172656E74223B723A3138323B733A383A226368696C6472656E223B613A313A7B733A33373A2261646D696E2F73797374656D2F6170692F726573745F617474726962757465732F65646974223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33373A2261646D696E2F73797374656D2F6170692F726573745F617474726962757465732F65646974223B7D7D7D733A33373A2261646D696E2F73797374656D2F6170692F726573745F617474726962757465732F65646974223B613A333A7B733A383A22696E7374616E6365223B723A3634343B733A363A22706172656E74223B723A3538343B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F676C6F62616C5F736561726368223B613A333A7B733A383A22696E7374616E6365223B723A3132323B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A303A7B7D7D733A393A2261646D696E2F636D73223B613A333A7B733A383A22696E7374616E6365223B723A3132343B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A353A7B733A31353A2261646D696E2F636D732F626C6F636B223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31353A2261646D696E2F636D732F626C6F636B223B7D733A31343A2261646D696E2F636D732F70616765223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31343A2261646D696E2F636D732F70616765223B7D733A32333A2261646D696E2F636D732F6D656469615F67616C6C657279223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F636D732F6D656469615F67616C6C657279223B7D733A31343A2261646D696E2F636D732F706F6C6C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31343A2261646D696E2F636D732F706F6C6C223B7D733A32353A2261646D696E2F636D732F7769646765745F696E7374616E6365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F636D732F7769646765745F696E7374616E6365223B7D7D7D733A31353A2261646D696E2F636D732F626C6F636B223B613A333A7B733A383A22696E7374616E6365223B723A3635383B733A363A22706172656E74223B723A3132343B733A383A226368696C6472656E223B613A303A7B7D7D733A31343A2261646D696E2F636D732F70616765223B613A333A7B733A383A22696E7374616E6365223B723A3636303B733A363A22706172656E74223B723A3132343B733A383A226368696C6472656E223B613A323A7B733A31393A2261646D696E2F636D732F706167652F73617665223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F636D732F706167652F73617665223B7D733A32313A2261646D696E2F636D732F706167652F64656C657465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F636D732F706167652F64656C657465223B7D7D7D733A31393A2261646D696E2F636D732F706167652F73617665223B613A333A7B733A383A22696E7374616E6365223B723A3637363B733A363A22706172656E74223B723A3636303B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F636D732F706167652F64656C657465223B613A333A7B733A383A22696E7374616E6365223B723A3637383B733A363A22706172656E74223B723A3636303B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F636D732F6D656469615F67616C6C657279223B613A333A7B733A383A22696E7374616E6365223B723A3636323B733A363A22706172656E74223B723A3132343B733A383A226368696C6472656E223B613A303A7B7D7D733A31343A2261646D696E2F636D732F706F6C6C223B613A333A7B733A383A22696E7374616E6365223B723A3636343B733A363A22706172656E74223B723A3132343B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F636D732F7769646765745F696E7374616E6365223B613A333A7B733A383A22696E7374616E6365223B723A3636363B733A363A22706172656E74223B723A3132343B733A383A226368696C6472656E223B613A303A7B7D7D733A31343A2261646D696E2F637573746F6D6572223B613A333A7B733A383A22696E7374616E6365223B723A3132363B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A333A7B733A32303A2261646D696E2F637573746F6D65722F67726F7570223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32303A2261646D696E2F637573746F6D65722F67726F7570223B7D733A32313A2261646D696E2F637573746F6D65722F6D616E616765223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F637573746F6D65722F6D616E616765223B7D733A32313A2261646D696E2F637573746F6D65722F6F6E6C696E65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F637573746F6D65722F6F6E6C696E65223B7D7D7D733A32303A2261646D696E2F637573746F6D65722F67726F7570223B613A333A7B733A383A22696E7374616E6365223B723A3730343B733A363A22706172656E74223B723A3132363B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F637573746F6D65722F6D616E616765223B613A333A7B733A383A22696E7374616E6365223B723A3730363B733A363A22706172656E74223B723A3132363B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F637573746F6D65722F6F6E6C696E65223B613A333A7B733A383A22696E7374616E6365223B723A3730383B733A363A22706172656E74223B723A3132363B733A383A226368696C6472656E223B613A303A7B7D7D733A31333A2261646D696E2F636174616C6F67223B613A333A7B733A383A22696E7374616E6365223B723A3132383B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A393A7B733A32343A2261646D696E2F636174616C6F672F61747472696275746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F636174616C6F672F61747472696275746573223B7D733A32343A2261646D696E2F636174616C6F672F63617465676F72696573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F636174616C6F672F63617465676F72696573223B7D733A32323A2261646D696E2F636174616C6F672F70726F6475637473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F636174616C6F672F70726F6475637473223B7D733A33313A2261646D696E2F636174616C6F672F7570646174655F61747472696275746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F636174616C6F672F7570646174655F61747472696275746573223B7D733A32343A2261646D696E2F636174616C6F672F75726C72657772697465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F636174616C6F672F75726C72657772697465223B7D733A32303A2261646D696E2F636174616C6F672F736561726368223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32303A2261646D696E2F636174616C6F672F736561726368223B7D733A32393A2261646D696E2F636174616C6F672F726576696577735F726174696E6773223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F636174616C6F672F726576696577735F726174696E6773223B7D733A31373A2261646D696E2F636174616C6F672F746167223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31373A2261646D696E2F636174616C6F672F746167223B7D733A32313A2261646D696E2F636174616C6F672F736974656D6170223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F636174616C6F672F736974656D6170223B7D7D7D733A32343A2261646D696E2F636174616C6F672F61747472696275746573223B613A333A7B733A383A22696E7374616E6365223B723A3732363B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A323A7B733A33353A2261646D696E2F636174616C6F672F617474726962757465732F61747472696275746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33353A2261646D696E2F636174616C6F672F617474726962757465732F61747472696275746573223B7D733A32393A2261646D696E2F636174616C6F672F617474726962757465732F73657473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F636174616C6F672F617474726962757465732F73657473223B7D7D7D733A33353A2261646D696E2F636174616C6F672F617474726962757465732F61747472696275746573223B613A333A7B733A383A22696E7374616E6365223B723A3734383B733A363A22706172656E74223B723A3732363B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F636174616C6F672F617474726962757465732F73657473223B613A333A7B733A383A22696E7374616E6365223B723A3735303B733A363A22706172656E74223B723A3732363B733A383A226368696C6472656E223B613A303A7B7D7D733A32343A2261646D696E2F636174616C6F672F63617465676F72696573223B613A333A7B733A383A22696E7374616E6365223B723A3732383B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F636174616C6F672F70726F6475637473223B613A333A7B733A383A22696E7374616E6365223B723A3733303B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F636174616C6F672F7570646174655F61747472696275746573223B613A333A7B733A383A22696E7374616E6365223B723A3733323B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A32343A2261646D696E2F636174616C6F672F75726C72657772697465223B613A333A7B733A383A22696E7374616E6365223B723A3733343B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A32303A2261646D696E2F636174616C6F672F736561726368223B613A333A7B733A383A22696E7374616E6365223B723A3733363B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F636174616C6F672F726576696577735F726174696E6773223B613A333A7B733A383A22696E7374616E6365223B723A3733383B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A323A7B733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F72657669657773223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F72657669657773223B7D733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726174696E6773223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726174696E6773223B7D7D7D733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F72657669657773223B613A333A7B733A383A22696E7374616E6365223B723A3738343B733A363A22706172656E74223B723A3733383B733A383A226368696C6472656E223B613A323A7B733A34313A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F616C6C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34313A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F616C6C223B7D733A34353A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F70656E64696E67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34353A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F70656E64696E67223B7D7D7D733A34313A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F616C6C223B613A333A7B733A383A22696E7374616E6365223B723A3739323B733A363A22706172656E74223B723A3738343B733A383A226368696C6472656E223B613A303A7B7D7D733A34353A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726576696577732F70656E64696E67223B613A333A7B733A383A22696E7374616E6365223B723A3739343B733A363A22706172656E74223B723A3738343B733A383A226368696C6472656E223B613A303A7B7D7D733A33373A2261646D696E2F636174616C6F672F726576696577735F726174696E67732F726174696E6773223B613A333A7B733A383A22696E7374616E6365223B723A3738363B733A363A22706172656E74223B723A3733383B733A383A226368696C6472656E223B613A303A7B7D7D733A31373A2261646D696E2F636174616C6F672F746167223B613A333A7B733A383A22696E7374616E6365223B723A3734303B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A323A7B733A32313A2261646D696E2F636174616C6F672F7461672F616C6C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F636174616C6F672F7461672F616C6C223B7D733A32353A2261646D696E2F636174616C6F672F7461672F70656E64696E67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F636174616C6F672F7461672F70656E64696E67223B7D7D7D733A32313A2261646D696E2F636174616C6F672F7461672F616C6C223B613A333A7B733A383A22696E7374616E6365223B723A3831323B733A363A22706172656E74223B723A3734303B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F636174616C6F672F7461672F70656E64696E67223B613A333A7B733A383A22696E7374616E6365223B723A3831343B733A363A22706172656E74223B723A3734303B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F636174616C6F672F736974656D6170223B613A333A7B733A383A22696E7374616E6365223B723A3734323B733A363A22706172656E74223B723A3132383B733A383A226368696C6472656E223B613A303A7B7D7D733A31313A2261646D696E2F70726F6D6F223B613A333A7B733A383A22696E7374616E6365223B723A3133303B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A323A7B733A31393A2261646D696E2F70726F6D6F2F636174616C6F67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F70726F6D6F2F636174616C6F67223B7D733A31373A2261646D696E2F70726F6D6F2F71756F7465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31373A2261646D696E2F70726F6D6F2F71756F7465223B7D7D7D733A31393A2261646D696E2F70726F6D6F2F636174616C6F67223B613A333A7B733A383A22696E7374616E6365223B723A3833323B733A363A22706172656E74223B723A3133303B733A383A226368696C6472656E223B613A303A7B7D7D733A31373A2261646D696E2F70726F6D6F2F71756F7465223B613A333A7B733A383A22696E7374616E6365223B723A3833343B733A363A22706172656E74223B723A3133303B733A383A226368696C6472656E223B613A303A7B7D7D733A31313A2261646D696E2F73616C6573223B613A333A7B733A383A22696E7374616E6365223B723A3133323B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A393A7B733A31373A2261646D696E2F73616C65732F6F72646572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31373A2261646D696E2F73616C65732F6F72646572223B7D733A31393A2261646D696E2F73616C65732F696E766F696365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F73616C65732F696E766F696365223B7D733A32303A2261646D696E2F73616C65732F736869706D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32303A2261646D696E2F73616C65732F736869706D656E74223B7D733A32323A2261646D696E2F73616C65732F6372656469746D656D6F223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F73616C65732F6372656469746D656D6F223B7D733A32343A2261646D696E2F73616C65732F7472616E73616374696F6E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F73616C65732F7472616E73616374696F6E73223B7D733A32393A2261646D696E2F73616C65732F726563757272696E675F70726F66696C65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73616C65732F726563757272696E675F70726F66696C65223B7D733A32393A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E74223B7D733A32393A2261646D696E2F73616C65732F636865636B6F757461677265656D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73616C65732F636865636B6F757461677265656D656E74223B7D733A31353A2261646D696E2F73616C65732F746178223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31353A2261646D696E2F73616C65732F746178223B7D7D7D733A31373A2261646D696E2F73616C65732F6F72646572223B613A333A7B733A383A22696E7374616E6365223B723A3834383B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A313A7B733A32353A2261646D696E2F73616C65732F6F726465722F616374696F6E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F73616C65732F6F726465722F616374696F6E73223B7D7D7D733A32353A2261646D696E2F73616C65732F6F726465722F616374696F6E73223B613A333A7B733A383A22696E7374616E6365223B723A3837303B733A363A22706172656E74223B723A3834383B733A383A226368696C6472656E223B613A31353A7B733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F637265617465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F637265617465223B7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F76696577223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F76696577223B7D733A33313A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C223B7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F72656F72646572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F72656F72646572223B7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F65646974223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F65646974223B7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63616E63656C223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63616E63656C223B7D733A34303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F7265766965775F7061796D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F7265766965775F7061796D656E74223B7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63617074757265223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63617074757265223B7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F696E766F696365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F696E766F696365223B7D733A33363A2261646D696E2F73616C65732F6F726465722F616374696F6E732F6372656469746D656D6F223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33363A2261646D696E2F73616C65732F6F726465722F616374696F6E732F6372656469746D656D6F223B7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F686F6C64223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F686F6C64223B7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F756E686F6C64223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F756E686F6C64223B7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F73686970223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F73686970223B7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F636F6D6D656E74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F636F6D6D656E74223B7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C73223B7D7D7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F637265617465223B613A333A7B733A383A22696E7374616E6365223B723A3837363B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F76696577223B613A333A7B733A383A22696E7374616E6365223B723A3837383B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C223B613A333A7B733A383A22696E7374616E6365223B723A3838303B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F72656F72646572223B613A333A7B733A383A22696E7374616E6365223B723A3838323B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F65646974223B613A333A7B733A383A22696E7374616E6365223B723A3838343B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63616E63656C223B613A333A7B733A383A22696E7374616E6365223B723A3838363B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A34303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F7265766965775F7061796D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3838383B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F63617074757265223B613A333A7B733A383A22696E7374616E6365223B723A3839303B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F696E766F696365223B613A333A7B733A383A22696E7374616E6365223B723A3839323B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33363A2261646D696E2F73616C65732F6F726465722F616374696F6E732F6372656469746D656D6F223B613A333A7B733A383A22696E7374616E6365223B723A3839343B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F686F6C64223B613A333A7B733A383A22696E7374616E6365223B723A3839363B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F756E686F6C64223B613A333A7B733A383A22696E7374616E6365223B723A3839383B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F73616C65732F6F726465722F616374696F6E732F73686970223B613A333A7B733A383A22696E7374616E6365223B723A3930303B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33333A2261646D696E2F73616C65732F6F726465722F616374696F6E732F636F6D6D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3930323B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A33323A2261646D696E2F73616C65732F6F726465722F616374696F6E732F656D61696C73223B613A333A7B733A383A22696E7374616E6365223B723A3930343B733A363A22706172656E74223B723A3837303B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F73616C65732F696E766F696365223B613A333A7B733A383A22696E7374616E6365223B723A3835303B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A303A7B7D7D733A32303A2261646D696E2F73616C65732F736869706D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3835323B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F73616C65732F6372656469746D656D6F223B613A333A7B733A383A22696E7374616E6365223B723A3835343B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A303A7B7D7D733A32343A2261646D696E2F73616C65732F7472616E73616374696F6E73223B613A333A7B733A383A22696E7374616E6365223B723A3835363B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A313A7B733A33303A2261646D696E2F73616C65732F7472616E73616374696F6E732F6665746368223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F73616C65732F7472616E73616374696F6E732F6665746368223B7D7D7D733A33303A2261646D696E2F73616C65732F7472616E73616374696F6E732F6665746368223B613A333A7B733A383A22696E7374616E6365223B723A3938323B733A363A22706172656E74223B723A3835363B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73616C65732F726563757272696E675F70726F66696C65223B613A333A7B733A383A22696E7374616E6365223B723A3835383B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3836303B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A313A7B733A33373A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33373A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E73223B7D7D7D733A33373A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E73223B613A333A7B733A383A22696E7374616E6365223B723A3939363B733A363A22706172656E74223B723A3836303B733A383A226368696C6472656E223B613A333A7B733A34323A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F76696577223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34323A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F76696577223B7D733A34343A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F6D616E616765223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34343A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F6D616E616765223B7D733A34313A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F757365223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34313A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F757365223B7D7D7D733A34323A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F76696577223B613A333A7B733A383A22696E7374616E6365223B723A313030323B733A363A22706172656E74223B723A3939363B733A383A226368696C6472656E223B613A303A7B7D7D733A34343A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F6D616E616765223B613A333A7B733A383A22696E7374616E6365223B723A313030343B733A363A22706172656E74223B723A3939363B733A383A226368696C6472656E223B613A303A7B7D7D733A34313A2261646D696E2F73616C65732F62696C6C696E675F61677265656D656E742F616374696F6E732F757365223B613A333A7B733A383A22696E7374616E6365223B723A313030363B733A363A22706172656E74223B723A3939363B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73616C65732F636865636B6F757461677265656D656E74223B613A333A7B733A383A22696E7374616E6365223B723A3836323B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A303A7B7D7D733A31353A2261646D696E2F73616C65732F746178223B613A333A7B733A383A22696E7374616E6365223B723A3836343B733A363A22706172656E74223B723A3133323B733A383A226368696C6472656E223B613A353A7B733A33323A2261646D696E2F73616C65732F7461782F636C61737365735F637573746F6D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33323A2261646D696E2F73616C65732F7461782F636C61737365735F637573746F6D6572223B7D733A33313A2261646D696E2F73616C65732F7461782F636C61737365735F70726F64756374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F73616C65732F7461782F636C61737365735F70726F64756374223B7D733A32393A2261646D696E2F73616C65732F7461782F696D706F72745F6578706F7274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F73616C65732F7461782F696D706F72745F6578706F7274223B7D733A32313A2261646D696E2F73616C65732F7461782F7261746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F73616C65732F7461782F7261746573223B7D733A32313A2261646D696E2F73616C65732F7461782F72756C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F73616C65732F7461782F72756C6573223B7D7D7D733A33323A2261646D696E2F73616C65732F7461782F636C61737365735F637573746F6D6572223B613A333A7B733A383A22696E7374616E6365223B723A313032383B733A363A22706172656E74223B723A3836343B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F73616C65732F7461782F636C61737365735F70726F64756374223B613A333A7B733A383A22696E7374616E6365223B723A313033303B733A363A22706172656E74223B723A3836343B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F73616C65732F7461782F696D706F72745F6578706F7274223B613A333A7B733A383A22696E7374616E6365223B723A313033323B733A363A22706172656E74223B723A3836343B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F73616C65732F7461782F7261746573223B613A333A7B733A383A22696E7374616E6365223B723A313033343B733A363A22706172656E74223B723A3836343B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F73616C65732F7461782F72756C6573223B613A333A7B733A383A22696E7374616E6365223B723A313033363B733A363A22706172656E74223B723A3836343B733A383A226368696C6472656E223B613A303A7B7D7D733A31323A2261646D696E2F7265706F7274223B613A333A7B733A383A22696E7374616E6365223B723A3133343B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A383A7B733A32323A2261646D696E2F7265706F72742F73616C6573726F6F74223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F7265706F72742F73616C6573726F6F74223B7D733A32313A2261646D696E2F7265706F72742F73686F7063617274223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F7265706F72742F73686F7063617274223B7D733A32313A2261646D696E2F7265706F72742F70726F6475637473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32313A2261646D696E2F7265706F72742F70726F6475637473223B7D733A32323A2261646D696E2F7265706F72742F637573746F6D657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F7265706F72742F637573746F6D657273223B7D733A31393A2261646D696E2F7265706F72742F726576696577223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F7265706F72742F726576696577223B7D733A31373A2261646D696E2F7265706F72742F74616773223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31373A2261646D696E2F7265706F72742F74616773223B7D733A31393A2261646D696E2F7265706F72742F736561726368223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A31393A2261646D696E2F7265706F72742F736561726368223B7D733A32333A2261646D696E2F7265706F72742F73746174697374696373223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F7265706F72742F73746174697374696373223B7D7D7D733A32323A2261646D696E2F7265706F72742F73616C6573726F6F74223B613A333A7B733A383A22696E7374616E6365223B723A313036323B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A373A7B733A34383A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F727473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A34383A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F727473223B7D733A32383A2261646D696E2F7265706F72742F73616C6573726F6F742F73616C6573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F7265706F72742F73616C6573726F6F742F73616C6573223B7D733A32363A2261646D696E2F7265706F72742F73616C6573726F6F742F746178223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F7265706F72742F73616C6573726F6F742F746178223B7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F7368697070696E67223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F7368697070696E67223B7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F696E766F69636564223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F696E766F69636564223B7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F726566756E646564223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F726566756E646564223B7D733A33303A2261646D696E2F7265706F72742F73616C6573726F6F742F636F75706F6E73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F7265706F72742F73616C6573726F6F742F636F75706F6E73223B7D7D7D733A34383A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F727473223B613A333A7B733A383A22696E7374616E6365223B723A313038323B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A323A7B733A35333A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F76696577223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A35333A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F76696577223B7D733A35343A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F6665746368223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A35343A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F6665746368223B7D7D7D733A35333A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F76696577223B613A333A7B733A383A22696E7374616E6365223B723A313130303B733A363A22706172656E74223B723A313038323B733A383A226368696C6472656E223B613A303A7B7D7D733A35343A2261646D696E2F7265706F72742F73616C6573726F6F742F70617970616C5F736574746C656D656E745F7265706F7274732F6665746368223B613A333A7B733A383A22696E7374616E6365223B723A313130323B733A363A22706172656E74223B723A313038323B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F7265706F72742F73616C6573726F6F742F73616C6573223B613A333A7B733A383A22696E7374616E6365223B723A313038343B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F7265706F72742F73616C6573726F6F742F746178223B613A333A7B733A383A22696E7374616E6365223B723A313038363B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F7368697070696E67223B613A333A7B733A383A22696E7374616E6365223B723A313038383B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F696E766F69636564223B613A333A7B733A383A22696E7374616E6365223B723A313039303B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F7265706F72742F73616C6573726F6F742F726566756E646564223B613A333A7B733A383A22696E7374616E6365223B723A313039323B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F7265706F72742F73616C6573726F6F742F636F75706F6E73223B613A333A7B733A383A22696E7374616E6365223B723A313039343B733A363A22706172656E74223B723A313036323B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F7265706F72742F73686F7063617274223B613A333A7B733A383A22696E7374616E6365223B723A313036343B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A323A7B733A32393A2261646D696E2F7265706F72742F73686F70636172742F70726F64756374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F7265706F72742F73686F70636172742F70726F64756374223B7D733A33313A2261646D696E2F7265706F72742F73686F70636172742F6162616E646F6E6564223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F73686F70636172742F6162616E646F6E6564223B7D7D7D733A32393A2261646D696E2F7265706F72742F73686F70636172742F70726F64756374223B613A333A7B733A383A22696E7374616E6365223B723A313134303B733A363A22706172656E74223B723A313036343B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F7265706F72742F73686F70636172742F6162616E646F6E6564223B613A333A7B733A383A22696E7374616E6365223B723A313134323B733A363A22706172656E74223B723A313036343B733A383A226368696C6472656E223B613A303A7B7D7D733A32313A2261646D696E2F7265706F72742F70726F6475637473223B613A333A7B733A383A22696E7374616E6365223B723A313036363B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A353A7B733A33333A2261646D696E2F7265706F72742F70726F64756374732F6265737473656C6C657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33333A2261646D696E2F7265706F72742F70726F64756374732F6265737473656C6C657273223B7D733A32363A2261646D696E2F7265706F72742F70726F64756374732F736F6C64223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F7265706F72742F70726F64756374732F736F6C64223B7D733A32383A2261646D696E2F7265706F72742F70726F64756374732F766965776564223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F7265706F72742F70726F64756374732F766965776564223B7D733A33303A2261646D696E2F7265706F72742F70726F64756374732F6C6F7773746F636B223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33303A2261646D696E2F7265706F72742F70726F64756374732F6C6F7773746F636B223B7D733A33313A2261646D696E2F7265706F72742F70726F64756374732F646F776E6C6F616473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F70726F64756374732F646F776E6C6F616473223B7D7D7D733A33333A2261646D696E2F7265706F72742F70726F64756374732F6265737473656C6C657273223B613A333A7B733A383A22696E7374616E6365223B723A313135363B733A363A22706172656E74223B723A313036363B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F7265706F72742F70726F64756374732F736F6C64223B613A333A7B733A383A22696E7374616E6365223B723A313135383B733A363A22706172656E74223B723A313036363B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F7265706F72742F70726F64756374732F766965776564223B613A333A7B733A383A22696E7374616E6365223B723A313136303B733A363A22706172656E74223B723A313036363B733A383A226368696C6472656E223B613A303A7B7D7D733A33303A2261646D696E2F7265706F72742F70726F64756374732F6C6F7773746F636B223B613A333A7B733A383A22696E7374616E6365223B723A313136323B733A363A22706172656E74223B723A313036363B733A383A226368696C6472656E223B613A303A7B7D7D733A33313A2261646D696E2F7265706F72742F70726F64756374732F646F776E6C6F616473223B613A333A7B733A383A22696E7374616E6365223B723A313136343B733A363A22706172656E74223B723A313036363B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F7265706F72742F637573746F6D657273223B613A333A7B733A383A22696E7374616E6365223B723A313036383B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A333A7B733A33313A2261646D696E2F7265706F72742F637573746F6D6572732F6163636F756E7473223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A33313A2261646D696E2F7265706F72742F637573746F6D6572732F6163636F756E7473223B7D733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F746F74616C73223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F746F74616C73223B7D733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F6F7264657273223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F6F7264657273223B7D7D7D733A33313A2261646D696E2F7265706F72742F637573746F6D6572732F6163636F756E7473223B613A333A7B733A383A22696E7374616E6365223B723A313139303B733A363A22706172656E74223B723A313036383B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F746F74616C73223B613A333A7B733A383A22696E7374616E6365223B723A313139323B733A363A22706172656E74223B723A313036383B733A383A226368696C6472656E223B613A303A7B7D7D733A32393A2261646D696E2F7265706F72742F637573746F6D6572732F6F7264657273223B613A333A7B733A383A22696E7374616E6365223B723A313139343B733A363A22706172656E74223B723A313036383B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F7265706F72742F726576696577223B613A333A7B733A383A22696E7374616E6365223B723A313037303B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A323A7B733A32383A2261646D696E2F7265706F72742F7265766965772F637573746F6D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32383A2261646D696E2F7265706F72742F7265766965772F637573746F6D6572223B7D733A32373A2261646D696E2F7265706F72742F7265766965772F70726F64756374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F7265706F72742F7265766965772F70726F64756374223B7D7D7D733A32383A2261646D696E2F7265706F72742F7265766965772F637573746F6D6572223B613A333A7B733A383A22696E7374616E6365223B723A313231323B733A363A22706172656E74223B723A313037303B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F7265706F72742F7265766965772F70726F64756374223B613A333A7B733A383A22696E7374616E6365223B723A313231343B733A363A22706172656E74223B723A313037303B733A383A226368696C6472656E223B613A303A7B7D7D733A31373A2261646D696E2F7265706F72742F74616773223B613A333A7B733A383A22696E7374616E6365223B723A313037323B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A333A7B733A32363A2261646D696E2F7265706F72742F746167732F637573746F6D6572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F7265706F72742F746167732F637573746F6D6572223B7D733A32353A2261646D696E2F7265706F72742F746167732F706F70756C6172223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F7265706F72742F746167732F706F70756C6172223B7D733A32353A2261646D696E2F7265706F72742F746167732F70726F64756374223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F7265706F72742F746167732F70726F64756374223B7D7D7D733A32363A2261646D696E2F7265706F72742F746167732F637573746F6D6572223B613A333A7B733A383A22696E7374616E6365223B723A313232383B733A363A22706172656E74223B723A313037323B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F7265706F72742F746167732F706F70756C6172223B613A333A7B733A383A22696E7374616E6365223B723A313233303B733A363A22706172656E74223B723A313037323B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F7265706F72742F746167732F70726F64756374223B613A333A7B733A383A22696E7374616E6365223B723A313233323B733A363A22706172656E74223B723A313037323B733A383A226368696C6472656E223B613A303A7B7D7D733A31393A2261646D696E2F7265706F72742F736561726368223B613A333A7B733A383A22696E7374616E6365223B723A313037343B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A303A7B7D7D733A32333A2261646D696E2F7265706F72742F73746174697374696373223B613A333A7B733A383A22696E7374616E6365223B723A313037363B733A363A22706172656E74223B723A3133343B733A383A226368696C6472656E223B613A303A7B7D7D733A31363A2261646D696E2F6E6577736C6574746572223B613A333A7B733A383A22696E7374616E6365223B723A3133363B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A343A7B733A32343A2261646D696E2F6E6577736C65747465722F70726F626C656D223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F6E6577736C65747465722F70726F626C656D223B7D733A32323A2261646D696E2F6E6577736C65747465722F7175657565223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F6E6577736C65747465722F7175657565223B7D733A32373A2261646D696E2F6E6577736C65747465722F73756273637269626572223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32373A2261646D696E2F6E6577736C65747465722F73756273637269626572223B7D733A32353A2261646D696E2F6E6577736C65747465722F74656D706C617465223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32353A2261646D696E2F6E6577736C65747465722F74656D706C617465223B7D7D7D733A32343A2261646D696E2F6E6577736C65747465722F70726F626C656D223B613A333A7B733A383A22696E7374616E6365223B723A313235383B733A363A22706172656E74223B723A3133363B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F6E6577736C65747465722F7175657565223B613A333A7B733A383A22696E7374616E6365223B723A313236303B733A363A22706172656E74223B723A3133363B733A383A226368696C6472656E223B613A303A7B7D7D733A32373A2261646D696E2F6E6577736C65747465722F73756273637269626572223B613A333A7B733A383A22696E7374616E6365223B723A313236323B733A363A22706172656E74223B723A3133363B733A383A226368696C6472656E223B613A303A7B7D7D733A32353A2261646D696E2F6E6577736C65747465722F74656D706C617465223B613A333A7B733A383A22696E7374616E6365223B723A313236343B733A363A22706172656E74223B723A3133363B733A383A226368696C6472656E223B613A303A7B7D7D733A31363A2261646D696E2F706167655F6361636865223B613A333A7B733A383A22696E7374616E6365223B723A3133383B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A303A7B7D7D733A31363A2261646D696E2F786D6C636F6E6E656374223B613A333A7B733A383A22696E7374616E6365223B723A3134303B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A343A7B733A32333A2261646D696E2F786D6C636F6E6E6563742F6D6F62696C65223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32333A2261646D696E2F786D6C636F6E6E6563742F6D6F62696C65223B7D733A32343A2261646D696E2F786D6C636F6E6E6563742F686973746F7279223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32343A2261646D696E2F786D6C636F6E6E6563742F686973746F7279223B7D733A32363A2261646D696E2F786D6C636F6E6E6563742F74656D706C61746573223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32363A2261646D696E2F786D6C636F6E6E6563742F74656D706C61746573223B7D733A32323A2261646D696E2F786D6C636F6E6E6563742F7175657565223B4F3A32393A224D6167655F41646D696E5F4D6F64656C5F41636C5F5265736F75726365223A313A7B733A31343A22002A005F7265736F757263654964223B733A32323A2261646D696E2F786D6C636F6E6E6563742F7175657565223B7D7D7D733A32333A2261646D696E2F786D6C636F6E6E6563742F6D6F62696C65223B613A333A7B733A383A22696E7374616E6365223B723A313239303B733A363A22706172656E74223B723A3134303B733A383A226368696C6472656E223B613A303A7B7D7D733A32343A2261646D696E2F786D6C636F6E6E6563742F686973746F7279223B613A333A7B733A383A22696E7374616E6365223B723A313239323B733A363A22706172656E74223B723A3134303B733A383A226368696C6472656E223B613A303A7B7D7D733A32363A2261646D696E2F786D6C636F6E6E6563742F74656D706C61746573223B613A333A7B733A383A22696E7374616E6365223B723A313239343B733A363A22706172656E74223B723A3134303B733A383A226368696C6472656E223B613A303A7B7D7D733A32323A2261646D696E2F786D6C636F6E6E6563742F7175657565223B613A333A7B733A383A22696E7374616E6365223B723A313239363B733A363A22706172656E74223B723A3134303B733A383A226368696C6472656E223B613A303A7B7D7D733A32383A2261646D696E2F4F6666695F437573746F6D6572417474726962757465223B613A333A7B733A383A22696E7374616E6365223B723A3134323B733A363A22706172656E74223B723A3131343B733A383A226368696C6472656E223B613A303A7B7D7D7D733A31373A22002A005F6973416C6C6F776564526F6C65223B723A3130303B733A32313A22002A005F6973416C6C6F7765645265736F75726365223B723A3137383B733A32323A22002A005F6973416C6C6F77656450726976696C656765223B4E3B733A393A22002A005F72756C6573223B613A323A7B733A31323A22616C6C5265736F7572636573223B613A323A7B733A383A22616C6C526F6C6573223B613A323A7B733A31333A22616C6C50726976696C65676573223B613A323A7B733A343A2274797065223B733A393A22545950455F44454E59223B733A363A22617373657274223B4E3B7D733A31333A22627950726976696C6567654964223B613A303A7B7D7D733A383A226279526F6C654964223B613A313A7B733A323A224731223B613A323A7B733A31333A22627950726976696C6567654964223B613A303A7B7D733A31333A22616C6C50726976696C65676573223B613A323A7B733A343A2274797065223B733A31303A22545950455F414C4C4F57223B733A363A22617373657274223B4E3B7D7D7D7D733A31323A2262795265736F757263654964223B613A313A7B733A333A22616C6C223B613A313A7B733A383A226279526F6C654964223B613A313A7B733A323A224731223B613A323A7B733A31333A22627950726976696C6567654964223B613A303A7B7D733A31333A22616C6C50726976696C65676573223B613A323A7B733A343A2274797065223B733A31303A22545950455F414C4C4F57223B733A363A22617373657274223B4E3B7D7D7D7D7D7D7D7D61646D696E68746D6C5F71756F74657C613A383A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A383A2273746F72655F6964223B733A313A2231223B733A383A226D65737361676573223B4F3A33343A224D6167655F436F72655F4D6F64656C5F4D6573736167655F436F6C6C656374696F6E223A323A7B733A31323A22002A005F6D65737361676573223B613A303A7B7D733A32303A22002A005F6C61737441646465644D657373616765223B4E3B7D733A31313A22637573746F6D65725F6964223B693A323B733A31313A2263757272656E63795F6964223B733A353A2266616C7365223B733A383A2271756F74655F6964223B733A323A223430223B733A33303A22616C6C6F775F71756F74655F6974656D735F676966745F6D657373616765223B613A303A7B7D7D73746F72655F64656661756C747C613A323A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D7D637573746F6D65725F61646D696E7C613A333A7B733A32333A225F73657373696F6E5F76616C696461746F725F64617461223B613A343A7B733A31313A2272656D6F74655F61646472223B733A393A223132372E302E302E31223B733A383A22687474705F766961223B733A303A22223B733A32303A22687474705F785F666F727761726465645F666F72223B733A303A22223B733A31353A22687474705F757365725F6167656E74223B733A38313A224D6F7A696C6C612F352E3020284D6163696E746F73683B20496E74656C204D6163204F5320582031302E383B2072763A32332E3029204765636B6F2F32303130303130312046697265666F782F32332E30223B7D733A31333A2273657373696F6E5F686F737473223B613A313A7B733A373A226D6167656E746F223B623A313B7D733A323A226964223B4E3B7D');

/*!40000 ALTER TABLE `mg_core_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_store`;

CREATE TABLE `mg_core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_MG_CORE_STORE_CODE` (`code`),
  KEY `IDX_MG_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_MG_CORE_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `FK_MG_CORE_STORE_GROUP_ID_MG_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `mg_core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CORE_STORE_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores';

LOCK TABLES `mg_core_store` WRITE;
/*!40000 ALTER TABLE `mg_core_store` DISABLE KEYS */;

INSERT INTO `mg_core_store` (`store_id`, `code`, `website_id`, `group_id`, `name`, `sort_order`, `is_active`)
VALUES
	(0,'admin',0,0,'Admin',0,1),
	(1,'default',1,1,'Default Store View',0,1);

/*!40000 ALTER TABLE `mg_core_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_store_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_store_group`;

CREATE TABLE `mg_core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_MG_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `FK_MG_CORE_STORE_GROUP_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store Groups';

LOCK TABLES `mg_core_store_group` WRITE;
/*!40000 ALTER TABLE `mg_core_store_group` DISABLE KEYS */;

INSERT INTO `mg_core_store_group` (`group_id`, `website_id`, `name`, `root_category_id`, `default_store_id`)
VALUES
	(0,0,'Default',0,0),
	(1,1,'Main Website Store',2,1);

/*!40000 ALTER TABLE `mg_core_store_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_translate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_translate`;

CREATE TABLE `mg_core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_MG_CORE_TRANSLATE_STORE_ID_LOCALE_STRING` (`store_id`,`locale`,`string`),
  KEY `IDX_MG_CORE_TRANSLATE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CORE_TRANSLATE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';



# Dump of table mg_core_url_rewrite
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_url_rewrite`;

CREATE TABLE `mg_core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_MG_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_MG_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_MG_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_MG_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_MG_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_MG_CORE_URL_REWRITE_CTGR_ID_MG_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_MG_CORE_URL_REWRITE_PRD_ID_MG_CAT_CTGR_ENTT_ENTT_ID` (`product_id`),
  CONSTRAINT `FK_MG_CORE_URL_REWRITE_CTGR_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mg_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CORE_URL_REWRITE_PRD_ID_MG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CORE_URL_REWRITE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';

LOCK TABLES `mg_core_url_rewrite` WRITE;
/*!40000 ALTER TABLE `mg_core_url_rewrite` DISABLE KEYS */;

INSERT INTO `mg_core_url_rewrite` (`url_rewrite_id`, `store_id`, `id_path`, `request_path`, `target_path`, `is_system`, `options`, `description`, `category_id`, `product_id`)
VALUES
	(2,1,'product/2','jonas.html','catalog/product/view/id/2',1,NULL,NULL,NULL,2),
	(4,1,'product/3','kuro-filtras.html','catalog/product/view/id/3',1,NULL,NULL,NULL,3);

/*!40000 ALTER TABLE `mg_core_url_rewrite` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_core_variable
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_variable`;

CREATE TABLE `mg_core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_MG_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';



# Dump of table mg_core_variable_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_variable_value`;

CREATE TABLE `mg_core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_MG_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_MG_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_CORE_VARIABLE_VALUE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CORE_VARIABLE_VAL_VARIABLE_ID_MG_CORE_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `mg_core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';



# Dump of table mg_core_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_core_website`;

CREATE TABLE `mg_core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_MG_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_MG_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_MG_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Websites';

LOCK TABLES `mg_core_website` WRITE;
/*!40000 ALTER TABLE `mg_core_website` DISABLE KEYS */;

INSERT INTO `mg_core_website` (`website_id`, `code`, `name`, `sort_order`, `default_group_id`, `is_default`)
VALUES
	(0,'admin','Admin',0,0,0),
	(1,'base','Main Website',0,1,1);

/*!40000 ALTER TABLE `mg_core_website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_coupon_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_coupon_aggregated`;

CREATE TABLE `mg_coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_COUPON_AGGRED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MG_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_MG_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MG_COUPON_AGGREGATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';



# Dump of table mg_coupon_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_coupon_aggregated_order`;

CREATE TABLE `mg_coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_COUPON_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MG_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_MG_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MG_COUPON_AGGREGATED_ORDER_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';



# Dump of table mg_coupon_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_coupon_aggregated_updated`;

CREATE TABLE `mg_coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `815F1B064BD39A72FFDC0A1547DD4909` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MG_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_MG_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MG_COUPON_AGGREGATED_UPDATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mg Coupon Aggregated Updated';



# Dump of table mg_cron_schedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_cron_schedule`;

CREATE TABLE `mg_cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_MG_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_MG_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';



# Dump of table mg_customer_address_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity`;

CREATE TABLE `mg_customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_PARENT_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';



# Dump of table mg_customer_address_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity_datetime`;

CREATE TABLE `mg_customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_0FBAAF0F7BE8B5AF7C82844656F517A2` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_DTIME_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_MG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';



# Dump of table mg_customer_address_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity_decimal`;

CREATE TABLE `mg_customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CSTR_ADDR_ENTT_DEC_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_FD5C63EED4CBB71CEF3D1473C636CB33` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_DEC_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_DEC_ENTT_ID_MG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';



# Dump of table mg_customer_address_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity_int`;

CREATE TABLE `mg_customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_D11FEDA0C1F560AC5E30BF7453F77FAB` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_INT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_INT_ENTT_ID_MG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';



# Dump of table mg_customer_address_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity_text`;

CREATE TABLE `mg_customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_3761216D8EF798CF4AE896616E646C71` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_TEXT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_TEXT_ENTT_ID_MG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';



# Dump of table mg_customer_address_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_address_entity_varchar`;

CREATE TABLE `mg_customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CSTR_ADDR_ENTT_VCHR_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_3FC96E6F8357F23F616A6C67FDC0AF5D` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_VCHR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ADDR_ENTT_VCHR_ENTT_ID_MG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';



# Dump of table mg_customer_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_eav_attribute`;

CREATE TABLE `mg_customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `FK_MG_CSTR_EAV_ATTR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';

LOCK TABLES `mg_customer_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mg_customer_eav_attribute` DISABLE KEYS */;

INSERT INTO `mg_customer_eav_attribute` (`attribute_id`, `is_visible`, `input_filter`, `multiline_count`, `validate_rules`, `is_system`, `sort_order`, `data_model`)
VALUES
	(1,0,NULL,0,NULL,0,21,NULL),
	(2,0,NULL,0,NULL,0,0,NULL),
	(3,0,NULL,0,NULL,0,20,NULL),
	(4,0,NULL,0,NULL,0,30,NULL),
	(5,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),
	(6,0,NULL,0,NULL,0,50,NULL),
	(7,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),
	(8,0,NULL,0,NULL,0,70,NULL),
	(9,1,NULL,0,'a:1:{s:16:\"input_validation\";s:5:\"email\";}',1,80,NULL),
	(10,1,NULL,0,NULL,1,25,NULL),
	(11,0,'date',0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',0,90,NULL),
	(12,0,NULL,0,NULL,1,0,NULL),
	(13,0,NULL,0,NULL,1,0,NULL),
	(14,0,NULL,0,NULL,1,0,NULL),
	(15,0,NULL,0,'a:1:{s:15:\"max_text_length\";i:255;}',0,100,NULL),
	(16,0,NULL,0,NULL,1,0,NULL),
	(17,0,NULL,0,NULL,0,0,NULL),
	(18,0,NULL,0,'a:0:{}',0,110,NULL),
	(19,0,NULL,0,NULL,0,10,NULL),
	(20,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,20,NULL),
	(21,0,NULL,0,NULL,0,30,NULL),
	(22,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),
	(23,0,NULL,0,NULL,0,50,NULL),
	(24,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),
	(25,1,NULL,2,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,70,NULL),
	(26,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,80,NULL),
	(27,1,NULL,0,NULL,1,90,NULL),
	(28,1,NULL,0,NULL,1,100,NULL),
	(29,1,NULL,0,NULL,1,100,NULL),
	(30,1,NULL,0,'a:0:{}',1,110,'customer/attribute_data_postcode'),
	(31,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,120,NULL),
	(32,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,130,NULL),
	(33,0,NULL,0,NULL,1,0,NULL),
	(34,0,NULL,0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',1,0,NULL),
	(35,1,NULL,0,NULL,1,28,NULL),
	(36,1,NULL,0,NULL,1,140,NULL),
	(37,0,NULL,0,NULL,1,0,NULL),
	(38,0,NULL,0,NULL,1,0,NULL),
	(39,0,NULL,0,NULL,1,0,NULL),
	(40,0,NULL,0,NULL,1,0,NULL),
	(139,1,NULL,0,NULL,1,1,NULL),
	(140,1,NULL,0,NULL,1,2,NULL),
	(141,1,NULL,0,NULL,1,3,NULL),
	(142,1,NULL,0,NULL,1,4,NULL),
	(143,1,NULL,0,NULL,1,5,NULL),
	(144,1,NULL,0,NULL,1,6,NULL),
	(145,1,NULL,0,NULL,1,7,NULL),
	(146,1,NULL,0,NULL,1,8,NULL),
	(147,1,NULL,0,NULL,1,9,NULL),
	(148,1,NULL,0,NULL,1,10,NULL),
	(150,1,NULL,0,NULL,1,11,NULL),
	(152,1,NULL,0,NULL,1,13,NULL),
	(153,1,NULL,0,NULL,1,14,NULL),
	(154,1,NULL,0,NULL,1,15,NULL),
	(157,1,NULL,1,NULL,0,0,NULL);

/*!40000 ALTER TABLE `mg_customer_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_eav_attribute_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_eav_attribute_website`;

CREATE TABLE `mg_customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_MG_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CSTR_EAV_ATTR_WS_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_EAV_ATTR_WS_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';

LOCK TABLES `mg_customer_eav_attribute_website` WRITE;
/*!40000 ALTER TABLE `mg_customer_eav_attribute_website` DISABLE KEYS */;

INSERT INTO `mg_customer_eav_attribute_website` (`attribute_id`, `website_id`, `is_visible`, `is_required`, `default_value`, `multiline_count`)
VALUES
	(1,0,1,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_customer_eav_attribute_website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity`;

CREATE TABLE `mg_customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_CUSTOMER_ENTITY_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CUSTOMER_ENTITY_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';

LOCK TABLES `mg_customer_entity` WRITE;
/*!40000 ALTER TABLE `mg_customer_entity` DISABLE KEYS */;

INSERT INTO `mg_customer_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `website_id`, `email`, `group_id`, `increment_id`, `store_id`, `created_at`, `updated_at`, `is_active`, `disable_auto_group_change`)
VALUES
	(1,1,0,0,NULL,3,NULL,0,'2013-08-15 02:18:59','2013-08-15 20:05:04',1,0),
	(2,1,0,0,NULL,0,NULL,0,'2013-08-15 20:08:19','2013-08-15 20:08:19',1,0);

/*!40000 ALTER TABLE `mg_customer_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity_datetime`;

CREATE TABLE `mg_customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MG_CSTR_ENTT_DTIME_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_DTIME_ENTT_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_DTIME_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';

LOCK TABLES `mg_customer_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mg_customer_entity_datetime` DISABLE KEYS */;

INSERT INTO `mg_customer_entity_datetime` (`value_id`, `entity_type_id`, `attribute_id`, `entity_id`, `value`)
VALUES
	(1,1,143,1,'2013-08-13 00:00:00'),
	(2,1,143,2,'2013-08-07 00:00:00');

/*!40000 ALTER TABLE `mg_customer_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity_decimal`;

CREATE TABLE `mg_customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MG_CSTR_ENTT_DEC_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_DEC_ENTT_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_DEC_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';



# Dump of table mg_customer_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity_int`;

CREATE TABLE `mg_customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MG_CSTR_ENTT_INT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_INT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CUSTOMER_ENTITY_INT_ENTITY_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';



# Dump of table mg_customer_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity_text`;

CREATE TABLE `mg_customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_CSTR_ENTT_TEXT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_TEXT_ENTT_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_TEXT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';



# Dump of table mg_customer_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_entity_varchar`;

CREATE TABLE `mg_customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MG_CSTR_ENTT_VCHR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_VCHR_ENTT_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_CSTR_ENTT_VCHR_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';

LOCK TABLES `mg_customer_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mg_customer_entity_varchar` DISABLE KEYS */;

INSERT INTO `mg_customer_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `entity_id`, `value`)
VALUES
	(1,1,5,1,'Asmuo'),
	(2,1,7,1,'Asmenaitis'),
	(3,1,9,1,'ddd@MAIL.COM'),
	(4,1,139,1,'mano adresas'),
	(5,1,140,1,'82938402384'),
	(6,1,141,1,'volvo'),
	(7,1,142,1,'s80'),
	(8,1,144,1,'CAT333'),
	(9,1,145,1,'123123123'),
	(10,1,146,1,'1233332'),
	(11,1,147,1,'D'),
	(12,1,148,1,'TR'),
	(13,1,150,1,'mano papildoma info'),
	(14,1,152,1,NULL),
	(15,1,153,1,NULL),
	(16,1,154,1,NULL),
	(17,1,12,1,'609aa2941f2e5debb7aa99bc5ccc7cfc:4b'),
	(18,1,10,1,'1'),
	(19,1,3,1,'Admin'),
	(20,1,157,1,'6'),
	(36,1,5,2,'Imonius'),
	(37,1,7,2,'Imonaitis'),
	(38,1,9,2,'email@mail.com'),
	(39,1,157,2,'5'),
	(40,1,139,2,'kainas'),
	(41,1,140,2,'131231'),
	(42,1,141,2,'Dodge'),
	(43,1,142,2,'Viper'),
	(44,1,144,2,'ZZZ000'),
	(45,1,145,2,'asfdasdf'),
	(46,1,146,2,'123123'),
	(47,1,147,2,'A'),
	(48,1,148,2,'TX'),
	(49,1,150,2,'extra info'),
	(50,1,152,2,'SIXT'),
	(51,1,153,2,'123123'),
	(52,1,154,2,'444444444'),
	(53,1,12,2,'4350f35185afc51c9d8e7f1b369f96bf:Je'),
	(54,1,10,2,'1'),
	(55,1,3,2,'Admin');

/*!40000 ALTER TABLE `mg_customer_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_form_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_form_attribute`;

CREATE TABLE `mg_customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_MG_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MG_CSTR_FORM_ATTR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';

LOCK TABLES `mg_customer_form_attribute` WRITE;
/*!40000 ALTER TABLE `mg_customer_form_attribute` DISABLE KEYS */;

INSERT INTO `mg_customer_form_attribute` (`form_code`, `attribute_id`)
VALUES
	('adminhtml_customer',1),
	('adminhtml_customer',3),
	('adminhtml_customer',4),
	('checkout_register',4),
	('customer_account_create',4),
	('customer_account_edit',4),
	('adminhtml_customer',5),
	('checkout_register',5),
	('customer_account_create',5),
	('customer_account_edit',5),
	('adminhtml_customer',6),
	('checkout_register',6),
	('customer_account_create',6),
	('customer_account_edit',6),
	('adminhtml_customer',7),
	('checkout_register',7),
	('customer_account_create',7),
	('customer_account_edit',7),
	('adminhtml_customer',8),
	('checkout_register',8),
	('customer_account_create',8),
	('customer_account_edit',8),
	('adminhtml_customer',9),
	('checkout_register',9),
	('customer_account_create',9),
	('customer_account_edit',9),
	('adminhtml_customer',10),
	('checkout_register',10),
	('customer_account_create',10),
	('customer_account_edit',10),
	('adminhtml_checkout',11),
	('adminhtml_customer',11),
	('checkout_register',11),
	('customer_account_create',11),
	('customer_account_edit',11),
	('adminhtml_checkout',15),
	('adminhtml_customer',15),
	('checkout_register',15),
	('customer_account_create',15),
	('customer_account_edit',15),
	('adminhtml_customer',17),
	('checkout_register',17),
	('customer_account_create',17),
	('customer_account_edit',17),
	('adminhtml_checkout',18),
	('adminhtml_customer',18),
	('checkout_register',18),
	('customer_account_create',18),
	('customer_account_edit',18),
	('adminhtml_customer_address',19),
	('customer_address_edit',19),
	('customer_register_address',19),
	('adminhtml_customer_address',20),
	('customer_address_edit',20),
	('customer_register_address',20),
	('adminhtml_customer_address',21),
	('customer_address_edit',21),
	('customer_register_address',21),
	('adminhtml_customer_address',22),
	('customer_address_edit',22),
	('customer_register_address',22),
	('adminhtml_customer_address',23),
	('customer_address_edit',23),
	('customer_register_address',23),
	('adminhtml_customer_address',24),
	('customer_address_edit',24),
	('customer_register_address',24),
	('adminhtml_customer_address',25),
	('customer_address_edit',25),
	('customer_register_address',25),
	('adminhtml_customer_address',26),
	('customer_address_edit',26),
	('customer_register_address',26),
	('adminhtml_customer_address',27),
	('customer_address_edit',27),
	('customer_register_address',27),
	('adminhtml_customer_address',28),
	('customer_address_edit',28),
	('customer_register_address',28),
	('adminhtml_customer_address',29),
	('customer_address_edit',29),
	('customer_register_address',29),
	('adminhtml_customer_address',30),
	('customer_address_edit',30),
	('customer_register_address',30),
	('adminhtml_customer_address',31),
	('customer_address_edit',31),
	('customer_register_address',31),
	('adminhtml_customer_address',32),
	('customer_address_edit',32),
	('customer_register_address',32),
	('adminhtml_customer',35),
	('adminhtml_customer_address',36),
	('customer_address_edit',36),
	('customer_register_address',36),
	('adminhtml_customer',139),
	('checkout_register',139),
	('customer_account_create',139),
	('customer_account_edit',139),
	('adminhtml_customer',140),
	('checkout_register',140),
	('customer_account_create',140),
	('customer_account_edit',140),
	('adminhtml_customer',141),
	('checkout_register',141),
	('customer_account_create',141),
	('customer_account_edit',141),
	('adminhtml_customer',142),
	('checkout_register',142),
	('customer_account_create',142),
	('customer_account_edit',142),
	('adminhtml_customer',143),
	('checkout_register',143),
	('customer_account_create',143),
	('customer_account_edit',143),
	('adminhtml_customer',144),
	('checkout_register',144),
	('customer_account_create',144),
	('customer_account_edit',144),
	('adminhtml_customer',145),
	('checkout_register',145),
	('customer_account_create',145),
	('customer_account_edit',145),
	('adminhtml_customer',146),
	('checkout_register',146),
	('customer_account_create',146),
	('customer_account_edit',146),
	('adminhtml_customer',147),
	('checkout_register',147),
	('customer_account_create',147),
	('customer_account_edit',147),
	('adminhtml_customer',148),
	('checkout_register',148),
	('customer_account_create',148),
	('customer_account_edit',148),
	('adminhtml_customer',150),
	('checkout_register',150),
	('customer_account_create',150),
	('customer_account_edit',150),
	('adminhtml_customer',152),
	('checkout_register',152),
	('customer_account_create',152),
	('customer_account_edit',152),
	('adminhtml_customer',153),
	('checkout_register',153),
	('customer_account_create',153),
	('customer_account_edit',153),
	('adminhtml_customer',154),
	('checkout_register',154),
	('customer_account_create',154),
	('customer_account_edit',154),
	('adminhtml_customer',157),
	('checkout_register',157),
	('customer_account_create',157),
	('customer_account_edit',157);

/*!40000 ALTER TABLE `mg_customer_form_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_customer_group`;

CREATE TABLE `mg_customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Group';

LOCK TABLES `mg_customer_group` WRITE;
/*!40000 ALTER TABLE `mg_customer_group` DISABLE KEYS */;

INSERT INTO `mg_customer_group` (`customer_group_id`, `customer_group_code`, `tax_class_id`)
VALUES
	(0,'NOT LOGGED IN',3),
	(1,'General',3),
	(2,'Wholesale',3),
	(3,'Retailer',3),
	(4,'Imone',3),
	(5,'Fizinis asmuo',3);

/*!40000 ALTER TABLE `mg_customer_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_dataflow_batch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_batch`;

CREATE TABLE `mg_dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_MG_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_MG_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_MG_DATAFLOW_BATCH_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_MG_DATAFLOW_BATCH_PROFILE_ID_MG_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `mg_dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_DATAFLOW_BATCH_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch';



# Dump of table mg_dataflow_batch_export
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_batch_export`;

CREATE TABLE `mg_dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_MG_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_MG_DATAFLOW_BATCH_EXPORT_BATCH_ID_MG_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `mg_dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export';



# Dump of table mg_dataflow_batch_import
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_batch_import`;

CREATE TABLE `mg_dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_MG_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_MG_DATAFLOW_BATCH_IMPORT_BATCH_ID_MG_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `mg_dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import';



# Dump of table mg_dataflow_import_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_import_data`;

CREATE TABLE `mg_dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_MG_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`),
  CONSTRAINT `FK_MG_DATAFLOW_IMPORT_DATA_SESS_ID_MG_DATAFLOW_SESS_SESS_ID` FOREIGN KEY (`session_id`) REFERENCES `mg_dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data';



# Dump of table mg_dataflow_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_profile`;

CREATE TABLE `mg_dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile';

LOCK TABLES `mg_dataflow_profile` WRITE;
/*!40000 ALTER TABLE `mg_dataflow_profile` DISABLE KEYS */;

INSERT INTO `mg_dataflow_profile` (`profile_id`, `name`, `created_at`, `updated_at`, `actions_xml`, `gui_data`, `direction`, `entity_type`, `store_id`, `data_transfer`)
VALUES
	(1,'Export All Products','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),
	(2,'Export Product Stocks','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:25:\"export_product_stocks.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:4:\"true\";s:7:\"product\";a:2:{s:2:\"db\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}s:4:\"file\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),
	(3,'Import All Products','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),
	(4,'Import Product Stocks','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:18:\"export_product.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),
	(5,'Export Customers','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"customer/convert_adapter_customer\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"filter/adressType\"><![CDATA[default_billing]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"customer/convert_parser_customer\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_customers.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:20:\"export_customers.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','customer',0,'file'),
	(6,'Import Customers','2013-08-09 22:43:26','2013-08-09 22:43:26','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">customer/convert_adapter_customer</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:19:\"export_customer.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','customer',0,'interactive');

/*!40000 ALTER TABLE `mg_dataflow_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_dataflow_profile_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_profile_history`;

CREATE TABLE `mg_dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_MG_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`),
  CONSTRAINT `FK_5288BB3CF36357474365D42DD74B6C48` FOREIGN KEY (`profile_id`) REFERENCES `mg_dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History';

LOCK TABLES `mg_dataflow_profile_history` WRITE;
/*!40000 ALTER TABLE `mg_dataflow_profile_history` DISABLE KEYS */;

INSERT INTO `mg_dataflow_profile_history` (`history_id`, `profile_id`, `action_code`, `user_id`, `performed_at`)
VALUES
	(1,1,'create',0,'2013-08-09 22:43:26'),
	(2,2,'create',0,'2013-08-09 22:43:26'),
	(3,3,'create',0,'2013-08-09 22:43:26'),
	(4,4,'create',0,'2013-08-09 22:43:26'),
	(5,5,'create',0,'2013-08-09 22:43:26'),
	(6,6,'create',0,'2013-08-09 22:43:26');

/*!40000 ALTER TABLE `mg_dataflow_profile_history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_dataflow_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_dataflow_session`;

CREATE TABLE `mg_dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session';



# Dump of table mg_design_change
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_design_change`;

CREATE TABLE `mg_design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_MG_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_DESIGN_CHANGE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';



# Dump of table mg_directory_country
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_directory_country`;

CREATE TABLE `mg_directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';

LOCK TABLES `mg_directory_country` WRITE;
/*!40000 ALTER TABLE `mg_directory_country` DISABLE KEYS */;

INSERT INTO `mg_directory_country` (`country_id`, `iso2_code`, `iso3_code`)
VALUES
	('AD','AD','AND'),
	('AE','AE','ARE'),
	('AF','AF','AFG'),
	('AG','AG','ATG'),
	('AI','AI','AIA'),
	('AL','AL','ALB'),
	('AM','AM','ARM'),
	('AN','AN','ANT'),
	('AO','AO','AGO'),
	('AQ','AQ','ATA'),
	('AR','AR','ARG'),
	('AS','AS','ASM'),
	('AT','AT','AUT'),
	('AU','AU','AUS'),
	('AW','AW','ABW'),
	('AX','AX','ALA'),
	('AZ','AZ','AZE'),
	('BA','BA','BIH'),
	('BB','BB','BRB'),
	('BD','BD','BGD'),
	('BE','BE','BEL'),
	('BF','BF','BFA'),
	('BG','BG','BGR'),
	('BH','BH','BHR'),
	('BI','BI','BDI'),
	('BJ','BJ','BEN'),
	('BL','BL','BLM'),
	('BM','BM','BMU'),
	('BN','BN','BRN'),
	('BO','BO','BOL'),
	('BR','BR','BRA'),
	('BS','BS','BHS'),
	('BT','BT','BTN'),
	('BV','BV','BVT'),
	('BW','BW','BWA'),
	('BY','BY','BLR'),
	('BZ','BZ','BLZ'),
	('CA','CA','CAN'),
	('CC','CC','CCK'),
	('CD','CD','COD'),
	('CF','CF','CAF'),
	('CG','CG','COG'),
	('CH','CH','CHE'),
	('CI','CI','CIV'),
	('CK','CK','COK'),
	('CL','CL','CHL'),
	('CM','CM','CMR'),
	('CN','CN','CHN'),
	('CO','CO','COL'),
	('CR','CR','CRI'),
	('CU','CU','CUB'),
	('CV','CV','CPV'),
	('CX','CX','CXR'),
	('CY','CY','CYP'),
	('CZ','CZ','CZE'),
	('DE','DE','DEU'),
	('DJ','DJ','DJI'),
	('DK','DK','DNK'),
	('DM','DM','DMA'),
	('DO','DO','DOM'),
	('DZ','DZ','DZA'),
	('EC','EC','ECU'),
	('EE','EE','EST'),
	('EG','EG','EGY'),
	('EH','EH','ESH'),
	('ER','ER','ERI'),
	('ES','ES','ESP'),
	('ET','ET','ETH'),
	('FI','FI','FIN'),
	('FJ','FJ','FJI'),
	('FK','FK','FLK'),
	('FM','FM','FSM'),
	('FO','FO','FRO'),
	('FR','FR','FRA'),
	('GA','GA','GAB'),
	('GB','GB','GBR'),
	('GD','GD','GRD'),
	('GE','GE','GEO'),
	('GF','GF','GUF'),
	('GG','GG','GGY'),
	('GH','GH','GHA'),
	('GI','GI','GIB'),
	('GL','GL','GRL'),
	('GM','GM','GMB'),
	('GN','GN','GIN'),
	('GP','GP','GLP'),
	('GQ','GQ','GNQ'),
	('GR','GR','GRC'),
	('GS','GS','SGS'),
	('GT','GT','GTM'),
	('GU','GU','GUM'),
	('GW','GW','GNB'),
	('GY','GY','GUY'),
	('HK','HK','HKG'),
	('HM','HM','HMD'),
	('HN','HN','HND'),
	('HR','HR','HRV'),
	('HT','HT','HTI'),
	('HU','HU','HUN'),
	('ID','ID','IDN'),
	('IE','IE','IRL'),
	('IL','IL','ISR'),
	('IM','IM','IMN'),
	('IN','IN','IND'),
	('IO','IO','IOT'),
	('IQ','IQ','IRQ'),
	('IR','IR','IRN'),
	('IS','IS','ISL'),
	('IT','IT','ITA'),
	('JE','JE','JEY'),
	('JM','JM','JAM'),
	('JO','JO','JOR'),
	('JP','JP','JPN'),
	('KE','KE','KEN'),
	('KG','KG','KGZ'),
	('KH','KH','KHM'),
	('KI','KI','KIR'),
	('KM','KM','COM'),
	('KN','KN','KNA'),
	('KP','KP','PRK'),
	('KR','KR','KOR'),
	('KW','KW','KWT'),
	('KY','KY','CYM'),
	('KZ','KZ','KAZ'),
	('LA','LA','LAO'),
	('LB','LB','LBN'),
	('LC','LC','LCA'),
	('LI','LI','LIE'),
	('LK','LK','LKA'),
	('LR','LR','LBR'),
	('LS','LS','LSO'),
	('LT','LT','LTU'),
	('LU','LU','LUX'),
	('LV','LV','LVA'),
	('LY','LY','LBY'),
	('MA','MA','MAR'),
	('MC','MC','MCO'),
	('MD','MD','MDA'),
	('ME','ME','MNE'),
	('MF','MF','MAF'),
	('MG','MG','MDG'),
	('MH','MH','MHL'),
	('MK','MK','MKD'),
	('ML','ML','MLI'),
	('MM','MM','MMR'),
	('MN','MN','MNG'),
	('MO','MO','MAC'),
	('MP','MP','MNP'),
	('MQ','MQ','MTQ'),
	('MR','MR','MRT'),
	('MS','MS','MSR'),
	('MT','MT','MLT'),
	('MU','MU','MUS'),
	('MV','MV','MDV'),
	('MW','MW','MWI'),
	('MX','MX','MEX'),
	('MY','MY','MYS'),
	('MZ','MZ','MOZ'),
	('NA','NA','NAM'),
	('NC','NC','NCL'),
	('NE','NE','NER'),
	('NF','NF','NFK'),
	('NG','NG','NGA'),
	('NI','NI','NIC'),
	('NL','NL','NLD'),
	('NO','NO','NOR'),
	('NP','NP','NPL'),
	('NR','NR','NRU'),
	('NU','NU','NIU'),
	('NZ','NZ','NZL'),
	('OM','OM','OMN'),
	('PA','PA','PAN'),
	('PE','PE','PER'),
	('PF','PF','PYF'),
	('PG','PG','PNG'),
	('PH','PH','PHL'),
	('PK','PK','PAK'),
	('PL','PL','POL'),
	('PM','PM','SPM'),
	('PN','PN','PCN'),
	('PR','PR','PRI'),
	('PS','PS','PSE'),
	('PT','PT','PRT'),
	('PW','PW','PLW'),
	('PY','PY','PRY'),
	('QA','QA','QAT'),
	('RE','RE','REU'),
	('RO','RO','ROU'),
	('RS','RS','SRB'),
	('RU','RU','RUS'),
	('RW','RW','RWA'),
	('SA','SA','SAU'),
	('SB','SB','SLB'),
	('SC','SC','SYC'),
	('SD','SD','SDN'),
	('SE','SE','SWE'),
	('SG','SG','SGP'),
	('SH','SH','SHN'),
	('SI','SI','SVN'),
	('SJ','SJ','SJM'),
	('SK','SK','SVK'),
	('SL','SL','SLE'),
	('SM','SM','SMR'),
	('SN','SN','SEN'),
	('SO','SO','SOM'),
	('SR','SR','SUR'),
	('ST','ST','STP'),
	('SV','SV','SLV'),
	('SY','SY','SYR'),
	('SZ','SZ','SWZ'),
	('TC','TC','TCA'),
	('TD','TD','TCD'),
	('TF','TF','ATF'),
	('TG','TG','TGO'),
	('TH','TH','THA'),
	('TJ','TJ','TJK'),
	('TK','TK','TKL'),
	('TL','TL','TLS'),
	('TM','TM','TKM'),
	('TN','TN','TUN'),
	('TO','TO','TON'),
	('TR','TR','TUR'),
	('TT','TT','TTO'),
	('TV','TV','TUV'),
	('TW','TW','TWN'),
	('TZ','TZ','TZA'),
	('UA','UA','UKR'),
	('UG','UG','UGA'),
	('UM','UM','UMI'),
	('US','US','USA'),
	('UY','UY','URY'),
	('UZ','UZ','UZB'),
	('VA','VA','VAT'),
	('VC','VC','VCT'),
	('VE','VE','VEN'),
	('VG','VG','VGB'),
	('VI','VI','VIR'),
	('VN','VN','VNM'),
	('VU','VU','VUT'),
	('WF','WF','WLF'),
	('WS','WS','WSM'),
	('YE','YE','YEM'),
	('YT','YT','MYT'),
	('ZA','ZA','ZAF'),
	('ZM','ZM','ZMB'),
	('ZW','ZW','ZWE');

/*!40000 ALTER TABLE `mg_directory_country` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_directory_country_format
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_directory_country_format`;

CREATE TABLE `mg_directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_MG_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';



# Dump of table mg_directory_country_region
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_directory_country_region`;

CREATE TABLE `mg_directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_MG_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';

LOCK TABLES `mg_directory_country_region` WRITE;
/*!40000 ALTER TABLE `mg_directory_country_region` DISABLE KEYS */;

INSERT INTO `mg_directory_country_region` (`region_id`, `country_id`, `code`, `default_name`)
VALUES
	(1,'US','AL','Alabama'),
	(2,'US','AK','Alaska'),
	(3,'US','AS','American Samoa'),
	(4,'US','AZ','Arizona'),
	(5,'US','AR','Arkansas'),
	(6,'US','AF','Armed Forces Africa'),
	(7,'US','AA','Armed Forces Americas'),
	(8,'US','AC','Armed Forces Canada'),
	(9,'US','AE','Armed Forces Europe'),
	(10,'US','AM','Armed Forces Middle East'),
	(11,'US','AP','Armed Forces Pacific'),
	(12,'US','CA','California'),
	(13,'US','CO','Colorado'),
	(14,'US','CT','Connecticut'),
	(15,'US','DE','Delaware'),
	(16,'US','DC','District of Columbia'),
	(17,'US','FM','Federated States Of Micronesia'),
	(18,'US','FL','Florida'),
	(19,'US','GA','Georgia'),
	(20,'US','GU','Guam'),
	(21,'US','HI','Hawaii'),
	(22,'US','ID','Idaho'),
	(23,'US','IL','Illinois'),
	(24,'US','IN','Indiana'),
	(25,'US','IA','Iowa'),
	(26,'US','KS','Kansas'),
	(27,'US','KY','Kentucky'),
	(28,'US','LA','Louisiana'),
	(29,'US','ME','Maine'),
	(30,'US','MH','Marshall Islands'),
	(31,'US','MD','Maryland'),
	(32,'US','MA','Massachusetts'),
	(33,'US','MI','Michigan'),
	(34,'US','MN','Minnesota'),
	(35,'US','MS','Mississippi'),
	(36,'US','MO','Missouri'),
	(37,'US','MT','Montana'),
	(38,'US','NE','Nebraska'),
	(39,'US','NV','Nevada'),
	(40,'US','NH','New Hampshire'),
	(41,'US','NJ','New Jersey'),
	(42,'US','NM','New Mexico'),
	(43,'US','NY','New York'),
	(44,'US','NC','North Carolina'),
	(45,'US','ND','North Dakota'),
	(46,'US','MP','Northern Mariana Islands'),
	(47,'US','OH','Ohio'),
	(48,'US','OK','Oklahoma'),
	(49,'US','OR','Oregon'),
	(50,'US','PW','Palau'),
	(51,'US','PA','Pennsylvania'),
	(52,'US','PR','Puerto Rico'),
	(53,'US','RI','Rhode Island'),
	(54,'US','SC','South Carolina'),
	(55,'US','SD','South Dakota'),
	(56,'US','TN','Tennessee'),
	(57,'US','TX','Texas'),
	(58,'US','UT','Utah'),
	(59,'US','VT','Vermont'),
	(60,'US','VI','Virgin Islands'),
	(61,'US','VA','Virginia'),
	(62,'US','WA','Washington'),
	(63,'US','WV','West Virginia'),
	(64,'US','WI','Wisconsin'),
	(65,'US','WY','Wyoming'),
	(66,'CA','AB','Alberta'),
	(67,'CA','BC','British Columbia'),
	(68,'CA','MB','Manitoba'),
	(69,'CA','NL','Newfoundland and Labrador'),
	(70,'CA','NB','New Brunswick'),
	(71,'CA','NS','Nova Scotia'),
	(72,'CA','NT','Northwest Territories'),
	(73,'CA','NU','Nunavut'),
	(74,'CA','ON','Ontario'),
	(75,'CA','PE','Prince Edward Island'),
	(76,'CA','QC','Quebec'),
	(77,'CA','SK','Saskatchewan'),
	(78,'CA','YT','Yukon Territory'),
	(79,'DE','NDS','Niedersachsen'),
	(80,'DE','BAW','Baden-Württemberg'),
	(81,'DE','BAY','Bayern'),
	(82,'DE','BER','Berlin'),
	(83,'DE','BRG','Brandenburg'),
	(84,'DE','BRE','Bremen'),
	(85,'DE','HAM','Hamburg'),
	(86,'DE','HES','Hessen'),
	(87,'DE','MEC','Mecklenburg-Vorpommern'),
	(88,'DE','NRW','Nordrhein-Westfalen'),
	(89,'DE','RHE','Rheinland-Pfalz'),
	(90,'DE','SAR','Saarland'),
	(91,'DE','SAS','Sachsen'),
	(92,'DE','SAC','Sachsen-Anhalt'),
	(93,'DE','SCN','Schleswig-Holstein'),
	(94,'DE','THE','Thüringen'),
	(95,'AT','WI','Wien'),
	(96,'AT','NO','Niederösterreich'),
	(97,'AT','OO','Oberösterreich'),
	(98,'AT','SB','Salzburg'),
	(99,'AT','KN','Kärnten'),
	(100,'AT','ST','Steiermark'),
	(101,'AT','TI','Tirol'),
	(102,'AT','BL','Burgenland'),
	(103,'AT','VB','Voralberg'),
	(104,'CH','AG','Aargau'),
	(105,'CH','AI','Appenzell Innerrhoden'),
	(106,'CH','AR','Appenzell Ausserrhoden'),
	(107,'CH','BE','Bern'),
	(108,'CH','BL','Basel-Landschaft'),
	(109,'CH','BS','Basel-Stadt'),
	(110,'CH','FR','Freiburg'),
	(111,'CH','GE','Genf'),
	(112,'CH','GL','Glarus'),
	(113,'CH','GR','Graubünden'),
	(114,'CH','JU','Jura'),
	(115,'CH','LU','Luzern'),
	(116,'CH','NE','Neuenburg'),
	(117,'CH','NW','Nidwalden'),
	(118,'CH','OW','Obwalden'),
	(119,'CH','SG','St. Gallen'),
	(120,'CH','SH','Schaffhausen'),
	(121,'CH','SO','Solothurn'),
	(122,'CH','SZ','Schwyz'),
	(123,'CH','TG','Thurgau'),
	(124,'CH','TI','Tessin'),
	(125,'CH','UR','Uri'),
	(126,'CH','VD','Waadt'),
	(127,'CH','VS','Wallis'),
	(128,'CH','ZG','Zug'),
	(129,'CH','ZH','Zürich'),
	(130,'ES','A Coruсa','A Coruña'),
	(131,'ES','Alava','Alava'),
	(132,'ES','Albacete','Albacete'),
	(133,'ES','Alicante','Alicante'),
	(134,'ES','Almeria','Almeria'),
	(135,'ES','Asturias','Asturias'),
	(136,'ES','Avila','Avila'),
	(137,'ES','Badajoz','Badajoz'),
	(138,'ES','Baleares','Baleares'),
	(139,'ES','Barcelona','Barcelona'),
	(140,'ES','Burgos','Burgos'),
	(141,'ES','Caceres','Caceres'),
	(142,'ES','Cadiz','Cadiz'),
	(143,'ES','Cantabria','Cantabria'),
	(144,'ES','Castellon','Castellon'),
	(145,'ES','Ceuta','Ceuta'),
	(146,'ES','Ciudad Real','Ciudad Real'),
	(147,'ES','Cordoba','Cordoba'),
	(148,'ES','Cuenca','Cuenca'),
	(149,'ES','Girona','Girona'),
	(150,'ES','Granada','Granada'),
	(151,'ES','Guadalajara','Guadalajara'),
	(152,'ES','Guipuzcoa','Guipuzcoa'),
	(153,'ES','Huelva','Huelva'),
	(154,'ES','Huesca','Huesca'),
	(155,'ES','Jaen','Jaen'),
	(156,'ES','La Rioja','La Rioja'),
	(157,'ES','Las Palmas','Las Palmas'),
	(158,'ES','Leon','Leon'),
	(159,'ES','Lleida','Lleida'),
	(160,'ES','Lugo','Lugo'),
	(161,'ES','Madrid','Madrid'),
	(162,'ES','Malaga','Malaga'),
	(163,'ES','Melilla','Melilla'),
	(164,'ES','Murcia','Murcia'),
	(165,'ES','Navarra','Navarra'),
	(166,'ES','Ourense','Ourense'),
	(167,'ES','Palencia','Palencia'),
	(168,'ES','Pontevedra','Pontevedra'),
	(169,'ES','Salamanca','Salamanca'),
	(170,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),
	(171,'ES','Segovia','Segovia'),
	(172,'ES','Sevilla','Sevilla'),
	(173,'ES','Soria','Soria'),
	(174,'ES','Tarragona','Tarragona'),
	(175,'ES','Teruel','Teruel'),
	(176,'ES','Toledo','Toledo'),
	(177,'ES','Valencia','Valencia'),
	(178,'ES','Valladolid','Valladolid'),
	(179,'ES','Vizcaya','Vizcaya'),
	(180,'ES','Zamora','Zamora'),
	(181,'ES','Zaragoza','Zaragoza'),
	(182,'FR','1','Ain'),
	(183,'FR','2','Aisne'),
	(184,'FR','3','Allier'),
	(185,'FR','4','Alpes-de-Haute-Provence'),
	(186,'FR','5','Hautes-Alpes'),
	(187,'FR','6','Alpes-Maritimes'),
	(188,'FR','7','Ardèche'),
	(189,'FR','8','Ardennes'),
	(190,'FR','9','Ariège'),
	(191,'FR','10','Aube'),
	(192,'FR','11','Aude'),
	(193,'FR','12','Aveyron'),
	(194,'FR','13','Bouches-du-Rhône'),
	(195,'FR','14','Calvados'),
	(196,'FR','15','Cantal'),
	(197,'FR','16','Charente'),
	(198,'FR','17','Charente-Maritime'),
	(199,'FR','18','Cher'),
	(200,'FR','19','Corrèze'),
	(201,'FR','2A','Corse-du-Sud'),
	(202,'FR','2B','Haute-Corse'),
	(203,'FR','21','Côte-d\'Or'),
	(204,'FR','22','Côtes-d\'Armor'),
	(205,'FR','23','Creuse'),
	(206,'FR','24','Dordogne'),
	(207,'FR','25','Doubs'),
	(208,'FR','26','Drôme'),
	(209,'FR','27','Eure'),
	(210,'FR','28','Eure-et-Loir'),
	(211,'FR','29','Finistère'),
	(212,'FR','30','Gard'),
	(213,'FR','31','Haute-Garonne'),
	(214,'FR','32','Gers'),
	(215,'FR','33','Gironde'),
	(216,'FR','34','Hérault'),
	(217,'FR','35','Ille-et-Vilaine'),
	(218,'FR','36','Indre'),
	(219,'FR','37','Indre-et-Loire'),
	(220,'FR','38','Isère'),
	(221,'FR','39','Jura'),
	(222,'FR','40','Landes'),
	(223,'FR','41','Loir-et-Cher'),
	(224,'FR','42','Loire'),
	(225,'FR','43','Haute-Loire'),
	(226,'FR','44','Loire-Atlantique'),
	(227,'FR','45','Loiret'),
	(228,'FR','46','Lot'),
	(229,'FR','47','Lot-et-Garonne'),
	(230,'FR','48','Lozère'),
	(231,'FR','49','Maine-et-Loire'),
	(232,'FR','50','Manche'),
	(233,'FR','51','Marne'),
	(234,'FR','52','Haute-Marne'),
	(235,'FR','53','Mayenne'),
	(236,'FR','54','Meurthe-et-Moselle'),
	(237,'FR','55','Meuse'),
	(238,'FR','56','Morbihan'),
	(239,'FR','57','Moselle'),
	(240,'FR','58','Nièvre'),
	(241,'FR','59','Nord'),
	(242,'FR','60','Oise'),
	(243,'FR','61','Orne'),
	(244,'FR','62','Pas-de-Calais'),
	(245,'FR','63','Puy-de-Dôme'),
	(246,'FR','64','Pyrénées-Atlantiques'),
	(247,'FR','65','Hautes-Pyrénées'),
	(248,'FR','66','Pyrénées-Orientales'),
	(249,'FR','67','Bas-Rhin'),
	(250,'FR','68','Haut-Rhin'),
	(251,'FR','69','Rhône'),
	(252,'FR','70','Haute-Saône'),
	(253,'FR','71','Saône-et-Loire'),
	(254,'FR','72','Sarthe'),
	(255,'FR','73','Savoie'),
	(256,'FR','74','Haute-Savoie'),
	(257,'FR','75','Paris'),
	(258,'FR','76','Seine-Maritime'),
	(259,'FR','77','Seine-et-Marne'),
	(260,'FR','78','Yvelines'),
	(261,'FR','79','Deux-Sèvres'),
	(262,'FR','80','Somme'),
	(263,'FR','81','Tarn'),
	(264,'FR','82','Tarn-et-Garonne'),
	(265,'FR','83','Var'),
	(266,'FR','84','Vaucluse'),
	(267,'FR','85','Vendée'),
	(268,'FR','86','Vienne'),
	(269,'FR','87','Haute-Vienne'),
	(270,'FR','88','Vosges'),
	(271,'FR','89','Yonne'),
	(272,'FR','90','Territoire-de-Belfort'),
	(273,'FR','91','Essonne'),
	(274,'FR','92','Hauts-de-Seine'),
	(275,'FR','93','Seine-Saint-Denis'),
	(276,'FR','94','Val-de-Marne'),
	(277,'FR','95','Val-d\'Oise'),
	(278,'RO','AB','Alba'),
	(279,'RO','AR','Arad'),
	(280,'RO','AG','Argeş'),
	(281,'RO','BC','Bacău'),
	(282,'RO','BH','Bihor'),
	(283,'RO','BN','Bistriţa-Năsăud'),
	(284,'RO','BT','Botoşani'),
	(285,'RO','BV','Braşov'),
	(286,'RO','BR','Brăila'),
	(287,'RO','B','Bucureşti'),
	(288,'RO','BZ','Buzău'),
	(289,'RO','CS','Caraş-Severin'),
	(290,'RO','CL','Călăraşi'),
	(291,'RO','CJ','Cluj'),
	(292,'RO','CT','Constanţa'),
	(293,'RO','CV','Covasna'),
	(294,'RO','DB','Dâmboviţa'),
	(295,'RO','DJ','Dolj'),
	(296,'RO','GL','Galaţi'),
	(297,'RO','GR','Giurgiu'),
	(298,'RO','GJ','Gorj'),
	(299,'RO','HR','Harghita'),
	(300,'RO','HD','Hunedoara'),
	(301,'RO','IL','Ialomiţa'),
	(302,'RO','IS','Iaşi'),
	(303,'RO','IF','Ilfov'),
	(304,'RO','MM','Maramureş'),
	(305,'RO','MH','Mehedinţi'),
	(306,'RO','MS','Mureş'),
	(307,'RO','NT','Neamţ'),
	(308,'RO','OT','Olt'),
	(309,'RO','PH','Prahova'),
	(310,'RO','SM','Satu-Mare'),
	(311,'RO','SJ','Sălaj'),
	(312,'RO','SB','Sibiu'),
	(313,'RO','SV','Suceava'),
	(314,'RO','TR','Teleorman'),
	(315,'RO','TM','Timiş'),
	(316,'RO','TL','Tulcea'),
	(317,'RO','VS','Vaslui'),
	(318,'RO','VL','Vâlcea'),
	(319,'RO','VN','Vrancea'),
	(320,'FI','Lappi','Lappi'),
	(321,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),
	(322,'FI','Kainuu','Kainuu'),
	(323,'FI','Pohjois-Karjala','Pohjois-Karjala'),
	(324,'FI','Pohjois-Savo','Pohjois-Savo'),
	(325,'FI','Etelä-Savo','Etelä-Savo'),
	(326,'FI','Etelä-Pohjanmaa','Etelä-Pohjanmaa'),
	(327,'FI','Pohjanmaa','Pohjanmaa'),
	(328,'FI','Pirkanmaa','Pirkanmaa'),
	(329,'FI','Satakunta','Satakunta'),
	(330,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),
	(331,'FI','Keski-Suomi','Keski-Suomi'),
	(332,'FI','Varsinais-Suomi','Varsinais-Suomi'),
	(333,'FI','Etelä-Karjala','Etelä-Karjala'),
	(334,'FI','Päijät-Häme','Päijät-Häme'),
	(335,'FI','Kanta-Häme','Kanta-Häme'),
	(336,'FI','Uusimaa','Uusimaa'),
	(337,'FI','Itä-Uusimaa','Itä-Uusimaa'),
	(338,'FI','Kymenlaakso','Kymenlaakso'),
	(339,'FI','Ahvenanmaa','Ahvenanmaa'),
	(340,'EE','EE-37','Harjumaa'),
	(341,'EE','EE-39','Hiiumaa'),
	(342,'EE','EE-44','Ida-Virumaa'),
	(343,'EE','EE-49','Jõgevamaa'),
	(344,'EE','EE-51','Järvamaa'),
	(345,'EE','EE-57','Läänemaa'),
	(346,'EE','EE-59','Lääne-Virumaa'),
	(347,'EE','EE-65','Põlvamaa'),
	(348,'EE','EE-67','Pärnumaa'),
	(349,'EE','EE-70','Raplamaa'),
	(350,'EE','EE-74','Saaremaa'),
	(351,'EE','EE-78','Tartumaa'),
	(352,'EE','EE-82','Valgamaa'),
	(353,'EE','EE-84','Viljandimaa'),
	(354,'EE','EE-86','Võrumaa'),
	(355,'LV','LV-DGV','Daugavpils'),
	(356,'LV','LV-JEL','Jelgava'),
	(357,'LV','Jēkabpils','Jēkabpils'),
	(358,'LV','LV-JUR','Jūrmala'),
	(359,'LV','LV-LPX','Liepāja'),
	(360,'LV','LV-LE','Liepājas novads'),
	(361,'LV','LV-REZ','Rēzekne'),
	(362,'LV','LV-RIX','Rīga'),
	(363,'LV','LV-RI','Rīgas novads'),
	(364,'LV','Valmiera','Valmiera'),
	(365,'LV','LV-VEN','Ventspils'),
	(366,'LV','Aglonas novads','Aglonas novads'),
	(367,'LV','LV-AI','Aizkraukles novads'),
	(368,'LV','Aizputes novads','Aizputes novads'),
	(369,'LV','Aknīstes novads','Aknīstes novads'),
	(370,'LV','Alojas novads','Alojas novads'),
	(371,'LV','Alsungas novads','Alsungas novads'),
	(372,'LV','LV-AL','Alūksnes novads'),
	(373,'LV','Amatas novads','Amatas novads'),
	(374,'LV','Apes novads','Apes novads'),
	(375,'LV','Auces novads','Auces novads'),
	(376,'LV','Babītes novads','Babītes novads'),
	(377,'LV','Baldones novads','Baldones novads'),
	(378,'LV','Baltinavas novads','Baltinavas novads'),
	(379,'LV','LV-BL','Balvu novads'),
	(380,'LV','LV-BU','Bauskas novads'),
	(381,'LV','Beverīnas novads','Beverīnas novads'),
	(382,'LV','Brocēnu novads','Brocēnu novads'),
	(383,'LV','Burtnieku novads','Burtnieku novads'),
	(384,'LV','Carnikavas novads','Carnikavas novads'),
	(385,'LV','Cesvaines novads','Cesvaines novads'),
	(386,'LV','Ciblas novads','Ciblas novads'),
	(387,'LV','LV-CE','Cēsu novads'),
	(388,'LV','Dagdas novads','Dagdas novads'),
	(389,'LV','LV-DA','Daugavpils novads'),
	(390,'LV','LV-DO','Dobeles novads'),
	(391,'LV','Dundagas novads','Dundagas novads'),
	(392,'LV','Durbes novads','Durbes novads'),
	(393,'LV','Engures novads','Engures novads'),
	(394,'LV','Garkalnes novads','Garkalnes novads'),
	(395,'LV','Grobiņas novads','Grobiņas novads'),
	(396,'LV','LV-GU','Gulbenes novads'),
	(397,'LV','Iecavas novads','Iecavas novads'),
	(398,'LV','Ikšķiles novads','Ikšķiles novads'),
	(399,'LV','Ilūkstes novads','Ilūkstes novads'),
	(400,'LV','Inčukalna novads','Inčukalna novads'),
	(401,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),
	(402,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),
	(403,'LV','Jaunpils novads','Jaunpils novads'),
	(404,'LV','LV-JL','Jelgavas novads'),
	(405,'LV','LV-JK','Jēkabpils novads'),
	(406,'LV','Kandavas novads','Kandavas novads'),
	(407,'LV','Kokneses novads','Kokneses novads'),
	(408,'LV','Krimuldas novads','Krimuldas novads'),
	(409,'LV','Krustpils novads','Krustpils novads'),
	(410,'LV','LV-KR','Krāslavas novads'),
	(411,'LV','LV-KU','Kuldīgas novads'),
	(412,'LV','Kārsavas novads','Kārsavas novads'),
	(413,'LV','Lielvārdes novads','Lielvārdes novads'),
	(414,'LV','LV-LM','Limbažu novads'),
	(415,'LV','Lubānas novads','Lubānas novads'),
	(416,'LV','LV-LU','Ludzas novads'),
	(417,'LV','Līgatnes novads','Līgatnes novads'),
	(418,'LV','Līvānu novads','Līvānu novads'),
	(419,'LV','LV-MA','Madonas novads'),
	(420,'LV','Mazsalacas novads','Mazsalacas novads'),
	(421,'LV','Mālpils novads','Mālpils novads'),
	(422,'LV','Mārupes novads','Mārupes novads'),
	(423,'LV','Naukšēnu novads','Naukšēnu novads'),
	(424,'LV','Neretas novads','Neretas novads'),
	(425,'LV','Nīcas novads','Nīcas novads'),
	(426,'LV','LV-OG','Ogres novads'),
	(427,'LV','Olaines novads','Olaines novads'),
	(428,'LV','Ozolnieku novads','Ozolnieku novads'),
	(429,'LV','LV-PR','Preiļu novads'),
	(430,'LV','Priekules novads','Priekules novads'),
	(431,'LV','Priekuļu novads','Priekuļu novads'),
	(432,'LV','Pārgaujas novads','Pārgaujas novads'),
	(433,'LV','Pāvilostas novads','Pāvilostas novads'),
	(434,'LV','Pļaviņu novads','Pļaviņu novads'),
	(435,'LV','Raunas novads','Raunas novads'),
	(436,'LV','Riebiņu novads','Riebiņu novads'),
	(437,'LV','Rojas novads','Rojas novads'),
	(438,'LV','Ropažu novads','Ropažu novads'),
	(439,'LV','Rucavas novads','Rucavas novads'),
	(440,'LV','Rugāju novads','Rugāju novads'),
	(441,'LV','Rundāles novads','Rundāles novads'),
	(442,'LV','LV-RE','Rēzeknes novads'),
	(443,'LV','Rūjienas novads','Rūjienas novads'),
	(444,'LV','Salacgrīvas novads','Salacgrīvas novads'),
	(445,'LV','Salas novads','Salas novads'),
	(446,'LV','Salaspils novads','Salaspils novads'),
	(447,'LV','LV-SA','Saldus novads'),
	(448,'LV','Saulkrastu novads','Saulkrastu novads'),
	(449,'LV','Siguldas novads','Siguldas novads'),
	(450,'LV','Skrundas novads','Skrundas novads'),
	(451,'LV','Skrīveru novads','Skrīveru novads'),
	(452,'LV','Smiltenes novads','Smiltenes novads'),
	(453,'LV','Stopiņu novads','Stopiņu novads'),
	(454,'LV','Strenču novads','Strenču novads'),
	(455,'LV','Sējas novads','Sējas novads'),
	(456,'LV','LV-TA','Talsu novads'),
	(457,'LV','LV-TU','Tukuma novads'),
	(458,'LV','Tērvetes novads','Tērvetes novads'),
	(459,'LV','Vaiņodes novads','Vaiņodes novads'),
	(460,'LV','LV-VK','Valkas novads'),
	(461,'LV','LV-VM','Valmieras novads'),
	(462,'LV','Varakļānu novads','Varakļānu novads'),
	(463,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),
	(464,'LV','Vecumnieku novads','Vecumnieku novads'),
	(465,'LV','LV-VE','Ventspils novads'),
	(466,'LV','Viesītes novads','Viesītes novads'),
	(467,'LV','Viļakas novads','Viļakas novads'),
	(468,'LV','Viļānu novads','Viļānu novads'),
	(469,'LV','Vārkavas novads','Vārkavas novads'),
	(470,'LV','Zilupes novads','Zilupes novads'),
	(471,'LV','Ādažu novads','Ādažu novads'),
	(472,'LV','Ērgļu novads','Ērgļu novads'),
	(473,'LV','Ķeguma novads','Ķeguma novads'),
	(474,'LV','Ķekavas novads','Ķekavas novads'),
	(475,'LT','LT-AL','Alytaus Apskritis'),
	(476,'LT','LT-KU','Kauno Apskritis'),
	(477,'LT','LT-KL','Klaipėdos Apskritis'),
	(478,'LT','LT-MR','Marijampolės Apskritis'),
	(479,'LT','LT-PN','Panevėžio Apskritis'),
	(480,'LT','LT-SA','Šiaulių Apskritis'),
	(481,'LT','LT-TA','Tauragės Apskritis'),
	(482,'LT','LT-TE','Telšių Apskritis'),
	(483,'LT','LT-UT','Utenos Apskritis'),
	(484,'LT','LT-VL','Vilniaus Apskritis');

/*!40000 ALTER TABLE `mg_directory_country_region` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_directory_country_region_name
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_directory_country_region_name`;

CREATE TABLE `mg_directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_MG_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_6A6A5D963124973EC754F67FE713657B` FOREIGN KEY (`region_id`) REFERENCES `mg_directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';

LOCK TABLES `mg_directory_country_region_name` WRITE;
/*!40000 ALTER TABLE `mg_directory_country_region_name` DISABLE KEYS */;

INSERT INTO `mg_directory_country_region_name` (`locale`, `region_id`, `name`)
VALUES
	('en_US',1,'Alabama'),
	('en_US',2,'Alaska'),
	('en_US',3,'American Samoa'),
	('en_US',4,'Arizona'),
	('en_US',5,'Arkansas'),
	('en_US',6,'Armed Forces Africa'),
	('en_US',7,'Armed Forces Americas'),
	('en_US',8,'Armed Forces Canada'),
	('en_US',9,'Armed Forces Europe'),
	('en_US',10,'Armed Forces Middle East'),
	('en_US',11,'Armed Forces Pacific'),
	('en_US',12,'California'),
	('en_US',13,'Colorado'),
	('en_US',14,'Connecticut'),
	('en_US',15,'Delaware'),
	('en_US',16,'District of Columbia'),
	('en_US',17,'Federated States Of Micronesia'),
	('en_US',18,'Florida'),
	('en_US',19,'Georgia'),
	('en_US',20,'Guam'),
	('en_US',21,'Hawaii'),
	('en_US',22,'Idaho'),
	('en_US',23,'Illinois'),
	('en_US',24,'Indiana'),
	('en_US',25,'Iowa'),
	('en_US',26,'Kansas'),
	('en_US',27,'Kentucky'),
	('en_US',28,'Louisiana'),
	('en_US',29,'Maine'),
	('en_US',30,'Marshall Islands'),
	('en_US',31,'Maryland'),
	('en_US',32,'Massachusetts'),
	('en_US',33,'Michigan'),
	('en_US',34,'Minnesota'),
	('en_US',35,'Mississippi'),
	('en_US',36,'Missouri'),
	('en_US',37,'Montana'),
	('en_US',38,'Nebraska'),
	('en_US',39,'Nevada'),
	('en_US',40,'New Hampshire'),
	('en_US',41,'New Jersey'),
	('en_US',42,'New Mexico'),
	('en_US',43,'New York'),
	('en_US',44,'North Carolina'),
	('en_US',45,'North Dakota'),
	('en_US',46,'Northern Mariana Islands'),
	('en_US',47,'Ohio'),
	('en_US',48,'Oklahoma'),
	('en_US',49,'Oregon'),
	('en_US',50,'Palau'),
	('en_US',51,'Pennsylvania'),
	('en_US',52,'Puerto Rico'),
	('en_US',53,'Rhode Island'),
	('en_US',54,'South Carolina'),
	('en_US',55,'South Dakota'),
	('en_US',56,'Tennessee'),
	('en_US',57,'Texas'),
	('en_US',58,'Utah'),
	('en_US',59,'Vermont'),
	('en_US',60,'Virgin Islands'),
	('en_US',61,'Virginia'),
	('en_US',62,'Washington'),
	('en_US',63,'West Virginia'),
	('en_US',64,'Wisconsin'),
	('en_US',65,'Wyoming'),
	('en_US',66,'Alberta'),
	('en_US',67,'British Columbia'),
	('en_US',68,'Manitoba'),
	('en_US',69,'Newfoundland and Labrador'),
	('en_US',70,'New Brunswick'),
	('en_US',71,'Nova Scotia'),
	('en_US',72,'Northwest Territories'),
	('en_US',73,'Nunavut'),
	('en_US',74,'Ontario'),
	('en_US',75,'Prince Edward Island'),
	('en_US',76,'Quebec'),
	('en_US',77,'Saskatchewan'),
	('en_US',78,'Yukon Territory'),
	('en_US',79,'Niedersachsen'),
	('en_US',80,'Baden-Württemberg'),
	('en_US',81,'Bayern'),
	('en_US',82,'Berlin'),
	('en_US',83,'Brandenburg'),
	('en_US',84,'Bremen'),
	('en_US',85,'Hamburg'),
	('en_US',86,'Hessen'),
	('en_US',87,'Mecklenburg-Vorpommern'),
	('en_US',88,'Nordrhein-Westfalen'),
	('en_US',89,'Rheinland-Pfalz'),
	('en_US',90,'Saarland'),
	('en_US',91,'Sachsen'),
	('en_US',92,'Sachsen-Anhalt'),
	('en_US',93,'Schleswig-Holstein'),
	('en_US',94,'Thüringen'),
	('en_US',95,'Wien'),
	('en_US',96,'Niederösterreich'),
	('en_US',97,'Oberösterreich'),
	('en_US',98,'Salzburg'),
	('en_US',99,'Kärnten'),
	('en_US',100,'Steiermark'),
	('en_US',101,'Tirol'),
	('en_US',102,'Burgenland'),
	('en_US',103,'Voralberg'),
	('en_US',104,'Aargau'),
	('en_US',105,'Appenzell Innerrhoden'),
	('en_US',106,'Appenzell Ausserrhoden'),
	('en_US',107,'Bern'),
	('en_US',108,'Basel-Landschaft'),
	('en_US',109,'Basel-Stadt'),
	('en_US',110,'Freiburg'),
	('en_US',111,'Genf'),
	('en_US',112,'Glarus'),
	('en_US',113,'Graubünden'),
	('en_US',114,'Jura'),
	('en_US',115,'Luzern'),
	('en_US',116,'Neuenburg'),
	('en_US',117,'Nidwalden'),
	('en_US',118,'Obwalden'),
	('en_US',119,'St. Gallen'),
	('en_US',120,'Schaffhausen'),
	('en_US',121,'Solothurn'),
	('en_US',122,'Schwyz'),
	('en_US',123,'Thurgau'),
	('en_US',124,'Tessin'),
	('en_US',125,'Uri'),
	('en_US',126,'Waadt'),
	('en_US',127,'Wallis'),
	('en_US',128,'Zug'),
	('en_US',129,'Zürich'),
	('en_US',130,'A Coruña'),
	('en_US',131,'Alava'),
	('en_US',132,'Albacete'),
	('en_US',133,'Alicante'),
	('en_US',134,'Almeria'),
	('en_US',135,'Asturias'),
	('en_US',136,'Avila'),
	('en_US',137,'Badajoz'),
	('en_US',138,'Baleares'),
	('en_US',139,'Barcelona'),
	('en_US',140,'Burgos'),
	('en_US',141,'Caceres'),
	('en_US',142,'Cadiz'),
	('en_US',143,'Cantabria'),
	('en_US',144,'Castellon'),
	('en_US',145,'Ceuta'),
	('en_US',146,'Ciudad Real'),
	('en_US',147,'Cordoba'),
	('en_US',148,'Cuenca'),
	('en_US',149,'Girona'),
	('en_US',150,'Granada'),
	('en_US',151,'Guadalajara'),
	('en_US',152,'Guipuzcoa'),
	('en_US',153,'Huelva'),
	('en_US',154,'Huesca'),
	('en_US',155,'Jaen'),
	('en_US',156,'La Rioja'),
	('en_US',157,'Las Palmas'),
	('en_US',158,'Leon'),
	('en_US',159,'Lleida'),
	('en_US',160,'Lugo'),
	('en_US',161,'Madrid'),
	('en_US',162,'Malaga'),
	('en_US',163,'Melilla'),
	('en_US',164,'Murcia'),
	('en_US',165,'Navarra'),
	('en_US',166,'Ourense'),
	('en_US',167,'Palencia'),
	('en_US',168,'Pontevedra'),
	('en_US',169,'Salamanca'),
	('en_US',170,'Santa Cruz de Tenerife'),
	('en_US',171,'Segovia'),
	('en_US',172,'Sevilla'),
	('en_US',173,'Soria'),
	('en_US',174,'Tarragona'),
	('en_US',175,'Teruel'),
	('en_US',176,'Toledo'),
	('en_US',177,'Valencia'),
	('en_US',178,'Valladolid'),
	('en_US',179,'Vizcaya'),
	('en_US',180,'Zamora'),
	('en_US',181,'Zaragoza'),
	('en_US',182,'Ain'),
	('en_US',183,'Aisne'),
	('en_US',184,'Allier'),
	('en_US',185,'Alpes-de-Haute-Provence'),
	('en_US',186,'Hautes-Alpes'),
	('en_US',187,'Alpes-Maritimes'),
	('en_US',188,'Ardèche'),
	('en_US',189,'Ardennes'),
	('en_US',190,'Ariège'),
	('en_US',191,'Aube'),
	('en_US',192,'Aude'),
	('en_US',193,'Aveyron'),
	('en_US',194,'Bouches-du-Rhône'),
	('en_US',195,'Calvados'),
	('en_US',196,'Cantal'),
	('en_US',197,'Charente'),
	('en_US',198,'Charente-Maritime'),
	('en_US',199,'Cher'),
	('en_US',200,'Corrèze'),
	('en_US',201,'Corse-du-Sud'),
	('en_US',202,'Haute-Corse'),
	('en_US',203,'Côte-d\'Or'),
	('en_US',204,'Côtes-d\'Armor'),
	('en_US',205,'Creuse'),
	('en_US',206,'Dordogne'),
	('en_US',207,'Doubs'),
	('en_US',208,'Drôme'),
	('en_US',209,'Eure'),
	('en_US',210,'Eure-et-Loir'),
	('en_US',211,'Finistère'),
	('en_US',212,'Gard'),
	('en_US',213,'Haute-Garonne'),
	('en_US',214,'Gers'),
	('en_US',215,'Gironde'),
	('en_US',216,'Hérault'),
	('en_US',217,'Ille-et-Vilaine'),
	('en_US',218,'Indre'),
	('en_US',219,'Indre-et-Loire'),
	('en_US',220,'Isère'),
	('en_US',221,'Jura'),
	('en_US',222,'Landes'),
	('en_US',223,'Loir-et-Cher'),
	('en_US',224,'Loire'),
	('en_US',225,'Haute-Loire'),
	('en_US',226,'Loire-Atlantique'),
	('en_US',227,'Loiret'),
	('en_US',228,'Lot'),
	('en_US',229,'Lot-et-Garonne'),
	('en_US',230,'Lozère'),
	('en_US',231,'Maine-et-Loire'),
	('en_US',232,'Manche'),
	('en_US',233,'Marne'),
	('en_US',234,'Haute-Marne'),
	('en_US',235,'Mayenne'),
	('en_US',236,'Meurthe-et-Moselle'),
	('en_US',237,'Meuse'),
	('en_US',238,'Morbihan'),
	('en_US',239,'Moselle'),
	('en_US',240,'Nièvre'),
	('en_US',241,'Nord'),
	('en_US',242,'Oise'),
	('en_US',243,'Orne'),
	('en_US',244,'Pas-de-Calais'),
	('en_US',245,'Puy-de-Dôme'),
	('en_US',246,'Pyrénées-Atlantiques'),
	('en_US',247,'Hautes-Pyrénées'),
	('en_US',248,'Pyrénées-Orientales'),
	('en_US',249,'Bas-Rhin'),
	('en_US',250,'Haut-Rhin'),
	('en_US',251,'Rhône'),
	('en_US',252,'Haute-Saône'),
	('en_US',253,'Saône-et-Loire'),
	('en_US',254,'Sarthe'),
	('en_US',255,'Savoie'),
	('en_US',256,'Haute-Savoie'),
	('en_US',257,'Paris'),
	('en_US',258,'Seine-Maritime'),
	('en_US',259,'Seine-et-Marne'),
	('en_US',260,'Yvelines'),
	('en_US',261,'Deux-Sèvres'),
	('en_US',262,'Somme'),
	('en_US',263,'Tarn'),
	('en_US',264,'Tarn-et-Garonne'),
	('en_US',265,'Var'),
	('en_US',266,'Vaucluse'),
	('en_US',267,'Vendée'),
	('en_US',268,'Vienne'),
	('en_US',269,'Haute-Vienne'),
	('en_US',270,'Vosges'),
	('en_US',271,'Yonne'),
	('en_US',272,'Territoire-de-Belfort'),
	('en_US',273,'Essonne'),
	('en_US',274,'Hauts-de-Seine'),
	('en_US',275,'Seine-Saint-Denis'),
	('en_US',276,'Val-de-Marne'),
	('en_US',277,'Val-d\'Oise'),
	('en_US',278,'Alba'),
	('en_US',279,'Arad'),
	('en_US',280,'Argeş'),
	('en_US',281,'Bacău'),
	('en_US',282,'Bihor'),
	('en_US',283,'Bistriţa-Năsăud'),
	('en_US',284,'Botoşani'),
	('en_US',285,'Braşov'),
	('en_US',286,'Brăila'),
	('en_US',287,'Bucureşti'),
	('en_US',288,'Buzău'),
	('en_US',289,'Caraş-Severin'),
	('en_US',290,'Călăraşi'),
	('en_US',291,'Cluj'),
	('en_US',292,'Constanţa'),
	('en_US',293,'Covasna'),
	('en_US',294,'Dâmboviţa'),
	('en_US',295,'Dolj'),
	('en_US',296,'Galaţi'),
	('en_US',297,'Giurgiu'),
	('en_US',298,'Gorj'),
	('en_US',299,'Harghita'),
	('en_US',300,'Hunedoara'),
	('en_US',301,'Ialomiţa'),
	('en_US',302,'Iaşi'),
	('en_US',303,'Ilfov'),
	('en_US',304,'Maramureş'),
	('en_US',305,'Mehedinţi'),
	('en_US',306,'Mureş'),
	('en_US',307,'Neamţ'),
	('en_US',308,'Olt'),
	('en_US',309,'Prahova'),
	('en_US',310,'Satu-Mare'),
	('en_US',311,'Sălaj'),
	('en_US',312,'Sibiu'),
	('en_US',313,'Suceava'),
	('en_US',314,'Teleorman'),
	('en_US',315,'Timiş'),
	('en_US',316,'Tulcea'),
	('en_US',317,'Vaslui'),
	('en_US',318,'Vâlcea'),
	('en_US',319,'Vrancea'),
	('en_US',320,'Lappi'),
	('en_US',321,'Pohjois-Pohjanmaa'),
	('en_US',322,'Kainuu'),
	('en_US',323,'Pohjois-Karjala'),
	('en_US',324,'Pohjois-Savo'),
	('en_US',325,'Etelä-Savo'),
	('en_US',326,'Etelä-Pohjanmaa'),
	('en_US',327,'Pohjanmaa'),
	('en_US',328,'Pirkanmaa'),
	('en_US',329,'Satakunta'),
	('en_US',330,'Keski-Pohjanmaa'),
	('en_US',331,'Keski-Suomi'),
	('en_US',332,'Varsinais-Suomi'),
	('en_US',333,'Etelä-Karjala'),
	('en_US',334,'Päijät-Häme'),
	('en_US',335,'Kanta-Häme'),
	('en_US',336,'Uusimaa'),
	('en_US',337,'Itä-Uusimaa'),
	('en_US',338,'Kymenlaakso'),
	('en_US',339,'Ahvenanmaa'),
	('en_US',340,'Harjumaa'),
	('en_US',341,'Hiiumaa'),
	('en_US',342,'Ida-Virumaa'),
	('en_US',343,'Jõgevamaa'),
	('en_US',344,'Järvamaa'),
	('en_US',345,'Läänemaa'),
	('en_US',346,'Lääne-Virumaa'),
	('en_US',347,'Põlvamaa'),
	('en_US',348,'Pärnumaa'),
	('en_US',349,'Raplamaa'),
	('en_US',350,'Saaremaa'),
	('en_US',351,'Tartumaa'),
	('en_US',352,'Valgamaa'),
	('en_US',353,'Viljandimaa'),
	('en_US',354,'Võrumaa'),
	('en_US',355,'Daugavpils'),
	('en_US',356,'Jelgava'),
	('en_US',357,'Jēkabpils'),
	('en_US',358,'Jūrmala'),
	('en_US',359,'Liepāja'),
	('en_US',360,'Liepājas novads'),
	('en_US',361,'Rēzekne'),
	('en_US',362,'Rīga'),
	('en_US',363,'Rīgas novads'),
	('en_US',364,'Valmiera'),
	('en_US',365,'Ventspils'),
	('en_US',366,'Aglonas novads'),
	('en_US',367,'Aizkraukles novads'),
	('en_US',368,'Aizputes novads'),
	('en_US',369,'Aknīstes novads'),
	('en_US',370,'Alojas novads'),
	('en_US',371,'Alsungas novads'),
	('en_US',372,'Alūksnes novads'),
	('en_US',373,'Amatas novads'),
	('en_US',374,'Apes novads'),
	('en_US',375,'Auces novads'),
	('en_US',376,'Babītes novads'),
	('en_US',377,'Baldones novads'),
	('en_US',378,'Baltinavas novads'),
	('en_US',379,'Balvu novads'),
	('en_US',380,'Bauskas novads'),
	('en_US',381,'Beverīnas novads'),
	('en_US',382,'Brocēnu novads'),
	('en_US',383,'Burtnieku novads'),
	('en_US',384,'Carnikavas novads'),
	('en_US',385,'Cesvaines novads'),
	('en_US',386,'Ciblas novads'),
	('en_US',387,'Cēsu novads'),
	('en_US',388,'Dagdas novads'),
	('en_US',389,'Daugavpils novads'),
	('en_US',390,'Dobeles novads'),
	('en_US',391,'Dundagas novads'),
	('en_US',392,'Durbes novads'),
	('en_US',393,'Engures novads'),
	('en_US',394,'Garkalnes novads'),
	('en_US',395,'Grobiņas novads'),
	('en_US',396,'Gulbenes novads'),
	('en_US',397,'Iecavas novads'),
	('en_US',398,'Ikšķiles novads'),
	('en_US',399,'Ilūkstes novads'),
	('en_US',400,'Inčukalna novads'),
	('en_US',401,'Jaunjelgavas novads'),
	('en_US',402,'Jaunpiebalgas novads'),
	('en_US',403,'Jaunpils novads'),
	('en_US',404,'Jelgavas novads'),
	('en_US',405,'Jēkabpils novads'),
	('en_US',406,'Kandavas novads'),
	('en_US',407,'Kokneses novads'),
	('en_US',408,'Krimuldas novads'),
	('en_US',409,'Krustpils novads'),
	('en_US',410,'Krāslavas novads'),
	('en_US',411,'Kuldīgas novads'),
	('en_US',412,'Kārsavas novads'),
	('en_US',413,'Lielvārdes novads'),
	('en_US',414,'Limbažu novads'),
	('en_US',415,'Lubānas novads'),
	('en_US',416,'Ludzas novads'),
	('en_US',417,'Līgatnes novads'),
	('en_US',418,'Līvānu novads'),
	('en_US',419,'Madonas novads'),
	('en_US',420,'Mazsalacas novads'),
	('en_US',421,'Mālpils novads'),
	('en_US',422,'Mārupes novads'),
	('en_US',423,'Naukšēnu novads'),
	('en_US',424,'Neretas novads'),
	('en_US',425,'Nīcas novads'),
	('en_US',426,'Ogres novads'),
	('en_US',427,'Olaines novads'),
	('en_US',428,'Ozolnieku novads'),
	('en_US',429,'Preiļu novads'),
	('en_US',430,'Priekules novads'),
	('en_US',431,'Priekuļu novads'),
	('en_US',432,'Pārgaujas novads'),
	('en_US',433,'Pāvilostas novads'),
	('en_US',434,'Pļaviņu novads'),
	('en_US',435,'Raunas novads'),
	('en_US',436,'Riebiņu novads'),
	('en_US',437,'Rojas novads'),
	('en_US',438,'Ropažu novads'),
	('en_US',439,'Rucavas novads'),
	('en_US',440,'Rugāju novads'),
	('en_US',441,'Rundāles novads'),
	('en_US',442,'Rēzeknes novads'),
	('en_US',443,'Rūjienas novads'),
	('en_US',444,'Salacgrīvas novads'),
	('en_US',445,'Salas novads'),
	('en_US',446,'Salaspils novads'),
	('en_US',447,'Saldus novads'),
	('en_US',448,'Saulkrastu novads'),
	('en_US',449,'Siguldas novads'),
	('en_US',450,'Skrundas novads'),
	('en_US',451,'Skrīveru novads'),
	('en_US',452,'Smiltenes novads'),
	('en_US',453,'Stopiņu novads'),
	('en_US',454,'Strenču novads'),
	('en_US',455,'Sējas novads'),
	('en_US',456,'Talsu novads'),
	('en_US',457,'Tukuma novads'),
	('en_US',458,'Tērvetes novads'),
	('en_US',459,'Vaiņodes novads'),
	('en_US',460,'Valkas novads'),
	('en_US',461,'Valmieras novads'),
	('en_US',462,'Varakļānu novads'),
	('en_US',463,'Vecpiebalgas novads'),
	('en_US',464,'Vecumnieku novads'),
	('en_US',465,'Ventspils novads'),
	('en_US',466,'Viesītes novads'),
	('en_US',467,'Viļakas novads'),
	('en_US',468,'Viļānu novads'),
	('en_US',469,'Vārkavas novads'),
	('en_US',470,'Zilupes novads'),
	('en_US',471,'Ādažu novads'),
	('en_US',472,'Ērgļu novads'),
	('en_US',473,'Ķeguma novads'),
	('en_US',474,'Ķekavas novads'),
	('en_US',475,'Alytaus Apskritis'),
	('en_US',476,'Kauno Apskritis'),
	('en_US',477,'Klaipėdos Apskritis'),
	('en_US',478,'Marijampolės Apskritis'),
	('en_US',479,'Panevėžio Apskritis'),
	('en_US',480,'Šiaulių Apskritis'),
	('en_US',481,'Tauragės Apskritis'),
	('en_US',482,'Telšių Apskritis'),
	('en_US',483,'Utenos Apskritis'),
	('en_US',484,'Vilniaus Apskritis');

/*!40000 ALTER TABLE `mg_directory_country_region_name` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_directory_currency_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_directory_currency_rate`;

CREATE TABLE `mg_directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_MG_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';

LOCK TABLES `mg_directory_currency_rate` WRITE;
/*!40000 ALTER TABLE `mg_directory_currency_rate` DISABLE KEYS */;

INSERT INTO `mg_directory_currency_rate` (`currency_from`, `currency_to`, `rate`)
VALUES
	('EUR','EUR',1.000000000000),
	('EUR','USD',1.415000000000),
	('USD','EUR',0.706700000000),
	('USD','USD',1.000000000000);

/*!40000 ALTER TABLE `mg_directory_currency_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_downloadable_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_link`;

CREATE TABLE `mg_downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `FK_MG_DL_LNK_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';



# Dump of table mg_downloadable_link_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_link_price`;

CREATE TABLE `mg_downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_DL_LNK_PRICE_LNK_ID_MG_DL_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mg_downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_DL_LNK_PRICE_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';



# Dump of table mg_downloadable_link_purchased
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_link_purchased`;

CREATE TABLE `mg_downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_MG_DL_LNK_PURCHASED_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_DL_LNK_PURCHASED_ORDER_ID_MG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';



# Dump of table mg_downloadable_link_purchased_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_link_purchased_item`;

CREATE TABLE `mg_downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_9CE53D86AF3E987F074E6E975F48B58C` FOREIGN KEY (`purchased_id`) REFERENCES `mg_downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B235119BEAE7DC9F9B423F9A11BE0A42` FOREIGN KEY (`order_item_id`) REFERENCES `mg_sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';



# Dump of table mg_downloadable_link_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_link_title`;

CREATE TABLE `mg_downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_MG_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_MG_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_DL_LNK_TTL_LNK_ID_MG_DL_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mg_downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_DOWNLOADABLE_LINK_TITLE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';



# Dump of table mg_downloadable_sample
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_sample`;

CREATE TABLE `mg_downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_MG_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_DL_SAMPLE_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';



# Dump of table mg_downloadable_sample_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_downloadable_sample_title`;

CREATE TABLE `mg_downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_MG_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_MG_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_MG_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_DL_SAMPLE_TTL_SAMPLE_ID_MG_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `mg_downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';



# Dump of table mg_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute`;

CREATE TABLE `mg_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_MG_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_MG_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_MG_EAV_ATTR_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';

LOCK TABLES `mg_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute` (`attribute_id`, `entity_type_id`, `attribute_code`, `attribute_model`, `backend_model`, `backend_type`, `backend_table`, `frontend_model`, `frontend_input`, `frontend_label`, `frontend_class`, `source_model`, `is_required`, `is_user_defined`, `default_value`, `is_unique`, `note`)
VALUES
	(1,1,'website_id',NULL,'customer/customer_attribute_backend_website','static',NULL,NULL,'select','Associate to Website',NULL,'eav/entity_attribute_source_table',0,0,NULL,0,NULL),
	(2,1,'store_id',NULL,'customer/customer_attribute_backend_store','static',NULL,NULL,'select','Create In',NULL,'customer/customer_attribute_source_store',1,0,NULL,0,NULL),
	(3,1,'created_in',NULL,NULL,'varchar',NULL,NULL,'text','Created From',NULL,NULL,0,0,NULL,0,NULL),
	(4,1,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),
	(5,1,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,0,0,NULL,0,NULL),
	(6,1,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),
	(7,1,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,0,0,NULL,0,NULL),
	(8,1,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),
	(9,1,'email',NULL,NULL,'varchar',NULL,NULL,'text','Email',NULL,NULL,0,0,NULL,0,NULL),
	(10,1,'group_id',NULL,NULL,'varchar',NULL,NULL,'select','Group',NULL,'eav/entity_attribute_source_table',0,0,NULL,0,NULL),
	(11,1,'dob',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,'eav/entity_attribute_frontend_datetime','date','Date Of Birth',NULL,NULL,0,0,NULL,0,NULL),
	(12,1,'password_hash',NULL,'customer/customer_attribute_backend_password','varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(13,1,'default_billing',NULL,'customer/customer_attribute_backend_billing','int',NULL,NULL,'text','Default Billing Address',NULL,NULL,0,0,NULL,0,NULL),
	(14,1,'default_shipping',NULL,'customer/customer_attribute_backend_shipping','int',NULL,NULL,'text','Default Shipping Address',NULL,NULL,0,0,NULL,0,NULL),
	(15,1,'taxvat',NULL,NULL,'varchar',NULL,NULL,'text','Tax/VAT Number',NULL,NULL,0,0,NULL,0,NULL),
	(16,1,'confirmation',NULL,NULL,'varchar',NULL,NULL,'text','Is Confirmed',NULL,NULL,0,0,NULL,0,NULL),
	(17,1,'created_at',NULL,NULL,'static',NULL,NULL,'date','Created At',NULL,NULL,0,0,NULL,0,NULL),
	(18,1,'gender',NULL,NULL,'int',NULL,NULL,'select','Gender',NULL,'eav/entity_attribute_source_table',0,0,NULL,0,NULL),
	(19,2,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),
	(20,2,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),
	(21,2,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),
	(22,2,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),
	(23,2,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),
	(24,2,'company',NULL,NULL,'varchar',NULL,NULL,'text','Company',NULL,NULL,0,0,NULL,0,NULL),
	(25,2,'street',NULL,'customer/entity_address_attribute_backend_street','text',NULL,NULL,'multiline','Street Address',NULL,NULL,1,0,NULL,0,NULL),
	(26,2,'city',NULL,NULL,'varchar',NULL,NULL,'text','City',NULL,NULL,1,0,NULL,0,NULL),
	(27,2,'country_id',NULL,NULL,'varchar',NULL,NULL,'select','Country',NULL,'customer/entity_address_attribute_source_country',1,0,NULL,0,NULL),
	(28,2,'region',NULL,'customer/entity_address_attribute_backend_region','varchar',NULL,NULL,'text','State/Province',NULL,NULL,0,0,NULL,0,NULL),
	(29,2,'region_id',NULL,NULL,'int',NULL,NULL,'hidden','State/Province',NULL,'customer/entity_address_attribute_source_region',0,0,NULL,0,NULL),
	(30,2,'postcode',NULL,NULL,'varchar',NULL,NULL,'text','Zip/Postal Code',NULL,NULL,1,0,NULL,0,NULL),
	(31,2,'telephone',NULL,NULL,'varchar',NULL,NULL,'text','Telephone',NULL,NULL,1,0,NULL,0,NULL),
	(32,2,'fax',NULL,NULL,'varchar',NULL,NULL,'text','Fax',NULL,NULL,0,0,NULL,0,NULL),
	(33,1,'rp_token',NULL,NULL,'varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(34,1,'rp_token_created_at',NULL,NULL,'datetime',NULL,NULL,'date',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(35,1,'disable_auto_group_change',NULL,'customer/attribute_backend_data_boolean','static',NULL,NULL,'boolean','Disable Automatic Group Change Based on VAT ID',NULL,NULL,0,0,NULL,0,NULL),
	(36,2,'vat_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number',NULL,NULL,0,0,NULL,0,NULL),
	(37,2,'vat_is_valid',NULL,NULL,'int',NULL,NULL,'text','VAT number validity',NULL,NULL,0,0,NULL,0,NULL),
	(38,2,'vat_request_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request ID',NULL,NULL,0,0,NULL,0,NULL),
	(39,2,'vat_request_date',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request date',NULL,NULL,0,0,NULL,0,NULL),
	(40,2,'vat_request_success',NULL,NULL,'int',NULL,NULL,'text','VAT number validation request success',NULL,NULL,0,0,NULL,0,NULL),
	(41,3,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),
	(42,3,'is_active',NULL,NULL,'int',NULL,NULL,'select','Is Active',NULL,'eav/entity_attribute_source_boolean',1,0,NULL,0,NULL),
	(43,3,'url_key',NULL,'catalog/category_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),
	(44,3,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),
	(45,3,'image',NULL,'catalog/category_attribute_backend_image','varchar',NULL,NULL,'image','Image',NULL,NULL,0,0,NULL,0,NULL),
	(46,3,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Page Title',NULL,NULL,0,0,NULL,0,NULL),
	(47,3,'meta_keywords',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),
	(48,3,'meta_description',NULL,NULL,'text',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,NULL),
	(49,3,'display_mode',NULL,NULL,'varchar',NULL,NULL,'select','Display Mode',NULL,'catalog/category_attribute_source_mode',0,0,NULL,0,NULL),
	(50,3,'landing_page',NULL,NULL,'int',NULL,NULL,'select','CMS Block',NULL,'catalog/category_attribute_source_page',0,0,NULL,0,NULL),
	(51,3,'is_anchor',NULL,NULL,'int',NULL,NULL,'select','Is Anchor',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(52,3,'path',NULL,NULL,'static',NULL,NULL,'text','Path',NULL,NULL,0,0,NULL,0,NULL),
	(53,3,'position',NULL,NULL,'static',NULL,NULL,'text','Position',NULL,NULL,0,0,NULL,0,NULL),
	(54,3,'all_children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(55,3,'path_in_store',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(56,3,'children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(57,3,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(58,3,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),
	(59,3,'custom_design_from',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),
	(60,3,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),
	(61,3,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/category_attribute_source_layout',0,0,NULL,0,NULL),
	(62,3,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),
	(63,3,'level',NULL,NULL,'static',NULL,NULL,'text','Level',NULL,NULL,0,0,NULL,0,NULL),
	(64,3,'children_count',NULL,NULL,'static',NULL,NULL,'text','Children Count',NULL,NULL,0,0,NULL,0,NULL),
	(65,3,'available_sort_by',NULL,'catalog/category_attribute_backend_sortby','text',NULL,NULL,'multiselect','Available Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),
	(66,3,'default_sort_by',NULL,'catalog/category_attribute_backend_sortby','varchar',NULL,NULL,'select','Default Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),
	(67,3,'include_in_menu',NULL,NULL,'int',NULL,NULL,'select','Include in Navigation Menu',NULL,'eav/entity_attribute_source_boolean',1,0,'1',0,NULL),
	(68,3,'custom_use_parent_settings',NULL,NULL,'int',NULL,NULL,'select','Use Parent Category Settings',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(69,3,'custom_apply_to_products',NULL,NULL,'int',NULL,NULL,'select','Apply To Products',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(70,3,'filter_price_range',NULL,NULL,'decimal',NULL,NULL,'text','Layered Navigation Price Step',NULL,NULL,0,0,NULL,0,NULL),
	(71,4,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,0,0,NULL,0,NULL),
	(72,4,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),
	(73,4,'short_description',NULL,NULL,'text',NULL,NULL,'textarea','Short Description',NULL,NULL,0,0,NULL,0,NULL),
	(74,4,'sku',NULL,'catalog/product_attribute_backend_sku','static',NULL,NULL,'text','SKU',NULL,NULL,0,0,NULL,1,NULL),
	(75,4,'price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Lentynos kaina',NULL,NULL,0,0,NULL,0,NULL),
	(76,4,'special_price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Special Price',NULL,NULL,0,0,NULL,0,NULL),
	(77,4,'special_from_date',NULL,'catalog/product_attribute_backend_startdate','datetime',NULL,NULL,'date','Special Price From Date',NULL,NULL,0,0,NULL,0,NULL),
	(78,4,'special_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Special Price To Date',NULL,NULL,0,0,NULL,0,NULL),
	(79,4,'cost',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Cost',NULL,NULL,0,1,NULL,0,NULL),
	(80,4,'weight',NULL,NULL,'decimal',NULL,NULL,'weight','Weight',NULL,NULL,0,0,NULL,0,NULL),
	(81,4,'manufacturer',NULL,NULL,'int',NULL,NULL,'select','Manufacturer',NULL,NULL,0,1,NULL,0,NULL),
	(82,4,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Meta Title',NULL,NULL,0,0,NULL,0,NULL),
	(83,4,'meta_keyword',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),
	(84,4,'meta_description',NULL,NULL,'varchar',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,'Maximum 255 chars'),
	(85,4,'image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Base Image',NULL,NULL,0,0,NULL,0,NULL),
	(86,4,'small_image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Small Image',NULL,NULL,0,0,NULL,0,NULL),
	(87,4,'thumbnail',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Thumbnail',NULL,NULL,0,0,NULL,0,NULL),
	(88,4,'media_gallery',NULL,'catalog/product_attribute_backend_media','varchar',NULL,NULL,'gallery','Media Gallery',NULL,NULL,0,0,NULL,0,NULL),
	(89,4,'old_id',NULL,NULL,'int',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(90,4,'group_price',NULL,'catalog/product_attribute_backend_groupprice','decimal',NULL,NULL,'text','Group Price',NULL,NULL,0,0,NULL,0,NULL),
	(91,4,'tier_price',NULL,'catalog/product_attribute_backend_tierprice','decimal',NULL,NULL,'text','Tier Price',NULL,NULL,0,0,NULL,0,NULL),
	(92,4,'color',NULL,NULL,'int',NULL,NULL,'select','Color',NULL,NULL,0,1,NULL,0,NULL),
	(93,4,'news_from_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Set Product as New from Date',NULL,NULL,0,0,NULL,0,NULL),
	(94,4,'news_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Set Product as New to Date',NULL,NULL,0,0,NULL,0,NULL),
	(95,4,'gallery',NULL,NULL,'varchar',NULL,NULL,'gallery','Image Gallery',NULL,NULL,0,0,NULL,0,NULL),
	(96,4,'status',NULL,NULL,'int',NULL,NULL,'select','Status',NULL,'catalog/product_status',0,0,NULL,0,NULL),
	(97,4,'url_key',NULL,'catalog/product_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),
	(98,4,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(99,4,'minimal_price',NULL,NULL,'decimal',NULL,NULL,'price','Minimal Price',NULL,NULL,0,0,NULL,0,NULL),
	(100,4,'is_recurring',NULL,NULL,'int',NULL,NULL,'select','Enable Recurring Profile',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,'Products with recurring profile participate in catalog as nominal items.'),
	(101,4,'recurring_profile',NULL,'catalog/product_attribute_backend_recurring','text',NULL,NULL,'text','Recurring Payment Profile',NULL,NULL,0,0,NULL,0,NULL),
	(102,4,'visibility',NULL,NULL,'int',NULL,NULL,'select','Visibility',NULL,'catalog/product_visibility',0,0,'4',0,NULL),
	(103,4,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),
	(104,4,'custom_design_from',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),
	(105,4,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),
	(106,4,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),
	(107,4,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/product_attribute_source_layout',0,0,NULL,0,NULL),
	(108,4,'category_ids',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(109,4,'options_container',NULL,NULL,'varchar',NULL,NULL,'select','Display Product Options In',NULL,'catalog/entity_product_attribute_design_options_container',0,0,'container2',0,NULL),
	(110,4,'required_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(111,4,'has_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(112,4,'image_label',NULL,NULL,'varchar',NULL,NULL,'text','Image Label',NULL,NULL,0,0,NULL,0,NULL),
	(113,4,'small_image_label',NULL,NULL,'varchar',NULL,NULL,'text','Small Image Label',NULL,NULL,0,0,NULL,0,NULL),
	(114,4,'thumbnail_label',NULL,NULL,'varchar',NULL,NULL,'text','Thumbnail Label',NULL,NULL,0,0,NULL,0,NULL),
	(115,4,'created_at',NULL,'eav/entity_attribute_backend_time_created','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(116,4,'updated_at',NULL,'eav/entity_attribute_backend_time_updated','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(117,4,'country_of_manufacture',NULL,NULL,'varchar',NULL,NULL,'select','Country of Manufacture',NULL,'catalog/product_attribute_source_countryofmanufacture',0,0,NULL,0,NULL),
	(118,4,'msrp_enabled',NULL,'catalog/product_attribute_backend_msrp','varchar',NULL,NULL,'select','Apply MAP',NULL,'catalog/product_attribute_source_msrp_type_enabled',0,0,'2',0,NULL),
	(119,4,'msrp_display_actual_price_type',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Display Actual Price',NULL,'catalog/product_attribute_source_msrp_type_price',0,0,'4',0,NULL),
	(120,4,'msrp',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Manufacturer\'s Suggested Retail Price',NULL,NULL,0,0,NULL,0,NULL),
	(121,4,'enable_googlecheckout',NULL,NULL,'int',NULL,NULL,'select','Is Product Available for Purchase with Google Checkout',NULL,'eav/entity_attribute_source_boolean',0,0,'1',0,NULL),
	(122,4,'tax_class_id',NULL,NULL,'int',NULL,NULL,'select','Tax Class',NULL,'tax/class_source_product',0,0,NULL,0,NULL),
	(123,4,'gift_message_available',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Allow Gift Message',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(124,4,'price_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(125,4,'sku_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(126,4,'weight_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(127,4,'price_view',NULL,NULL,'int',NULL,NULL,'select','Price View',NULL,'bundle/product_attribute_source_price_view',0,0,NULL,0,NULL),
	(128,4,'shipment_type',NULL,NULL,'int',NULL,NULL,NULL,'Shipment',NULL,NULL,1,0,NULL,0,NULL),
	(129,4,'links_purchased_separately',NULL,NULL,'int',NULL,NULL,NULL,'Links can be purchased separately',NULL,NULL,1,0,NULL,0,NULL),
	(130,4,'samples_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Samples title',NULL,NULL,1,0,NULL,0,NULL),
	(131,4,'links_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Links title',NULL,NULL,1,0,NULL,0,NULL),
	(132,4,'links_exist',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,0,0,'0',0,NULL),
	(133,3,'thumbnail',NULL,'catalog/category_attribute_backend_image','varchar',NULL,NULL,'image','Thumbnail Image',NULL,NULL,0,0,NULL,0,NULL),
	(134,4,'worker_name',NULL,NULL,'varchar',NULL,NULL,'text','Vardas',NULL,NULL,0,1,NULL,0,NULL),
	(135,4,'producer',NULL,NULL,'varchar',NULL,NULL,'text','Tiekejas',NULL,NULL,0,1,NULL,0,NULL),
	(136,4,'date_bought',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,'eav/entity_attribute_frontend_datetime','date','Data',NULL,NULL,0,1,NULL,0,NULL),
	(138,4,'cost1',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Pirkimo kaina',NULL,NULL,0,1,NULL,0,NULL),
	(139,1,'adress',NULL,NULL,'varchar',NULL,NULL,'text','Adresas',NULL,NULL,0,1,NULL,0,NULL),
	(140,1,'phone_nr',NULL,NULL,'varchar',NULL,NULL,'text','Tel. nr',NULL,NULL,0,1,NULL,0,NULL),
	(141,1,'auto_mark',NULL,NULL,'varchar',NULL,NULL,'text','Automobilio marke',NULL,NULL,0,1,NULL,0,NULL),
	(142,1,'auto_model',NULL,NULL,'varchar',NULL,NULL,'text','Automobilio modelis',NULL,NULL,0,1,NULL,0,NULL),
	(143,1,'manufacture_year',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,'eav/entity_attribute_frontend_datetime','date','Pagaminimo metai',NULL,NULL,0,1,NULL,0,NULL),
	(144,1,'auto_rn',NULL,NULL,'varchar',NULL,NULL,'text','Valstybinis numeris',NULL,NULL,0,1,NULL,0,NULL),
	(145,1,'frame_nr',NULL,NULL,'varchar',NULL,NULL,'text','Kebulo numeris',NULL,NULL,0,1,NULL,0,NULL),
	(146,1,'ride',NULL,NULL,'varchar',NULL,NULL,'text','Rida',NULL,NULL,0,1,NULL,0,NULL),
	(147,1,'engine',NULL,NULL,'varchar',NULL,NULL,'text','Variklis',NULL,NULL,0,1,NULL,0,NULL),
	(148,1,'transmission_box',NULL,NULL,'varchar',NULL,NULL,'text','Pavaru deze',NULL,NULL,0,1,NULL,0,NULL),
	(149,4,'mato_vnt',NULL,NULL,'varchar',NULL,NULL,'text','Mato vnt',NULL,NULL,0,1,NULL,0,NULL),
	(150,1,'extra_info',NULL,NULL,'varchar',NULL,NULL,'text','Papildoma info',NULL,NULL,0,1,NULL,0,NULL),
	(152,1,'company_name',NULL,NULL,'varchar',NULL,NULL,'text','Imones vardas',NULL,NULL,0,1,NULL,0,NULL),
	(153,1,'company_code',NULL,NULL,'varchar',NULL,NULL,'text','Imones kodas',NULL,NULL,0,1,NULL,0,NULL),
	(154,1,'tax_code',NULL,NULL,'varchar',NULL,NULL,'text','PVM kodas',NULL,NULL,0,1,NULL,0,NULL),
	(155,4,'price_tax',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Lentynos kaina (su PVM)',NULL,NULL,0,1,NULL,0,NULL),
	(156,4,'cost1_tax',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Pirkimo kaina (su PVM)',NULL,NULL,0,1,NULL,0,NULL),
	(157,1,'person_or_company',NULL,'','varchar',NULL,NULL,'select','Kliento tipas',NULL,'eav/entity_attribute_source_table',0,1,'6',0,NULL);

/*!40000 ALTER TABLE `mg_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_attribute_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute_group`;

CREATE TABLE `mg_eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_MG_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_MG_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `FK_MG_EAV_ATTR_GROUP_ATTR_SET_ID_MG_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `mg_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';

LOCK TABLES `mg_eav_attribute_group` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute_group` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute_group` (`attribute_group_id`, `attribute_set_id`, `attribute_group_name`, `sort_order`, `default_id`)
VALUES
	(1,1,'General',1,1),
	(2,2,'General',1,1),
	(3,3,'General',10,1),
	(4,3,'General Information',2,0),
	(5,3,'Display Settings',20,0),
	(6,3,'Custom Design',30,0),
	(7,4,'General',1,1),
	(8,4,'Prices',2,0),
	(9,4,'Meta Information',3,0),
	(10,4,'Images',4,0),
	(11,4,'Recurring Profile',5,0),
	(12,4,'Design',6,0),
	(13,5,'General',1,1),
	(14,6,'General',1,1),
	(15,7,'General',1,1),
	(16,8,'General',1,1),
	(17,4,'Gift Options',7,0),
	(22,9,'.',4,0),
	(23,9,'Prices',3,0),
	(24,9,'General',1,1),
	(29,10,'.',2,0),
	(31,10,'General',1,1),
	(32,9,'Detales info',2,0);

/*!40000 ALTER TABLE `mg_eav_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_attribute_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute_label`;

CREATE TABLE `mg_eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `FK_MG_EAV_ATTRIBUTE_LABEL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ATTR_LBL_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';

LOCK TABLES `mg_eav_attribute_label` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute_label` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute_label` (`attribute_label_id`, `attribute_id`, `store_id`, `value`)
VALUES
	(16,134,1,'Vardas'),
	(18,139,1,'Adresas'),
	(22,142,1,'Automobilio modelis'),
	(24,143,1,'Pagaminimo metai'),
	(26,144,1,'Valstybinis numeris'),
	(28,145,1,'Kebulo numeris'),
	(30,146,1,'Rida'),
	(32,147,1,'Variklis'),
	(34,148,1,'Pavaru deze'),
	(42,150,1,'Papildoma info'),
	(46,152,1,'Imones vardas'),
	(48,153,1,'Imones kodas'),
	(50,154,1,'PVM kodas'),
	(53,135,1,'Tiekejas'),
	(54,136,1,'Data'),
	(55,149,1,'Mato vnt'),
	(56,75,1,'Lentynos kaina'),
	(57,138,1,'Pirkimo kaina'),
	(58,155,1,'Lentynos kaina (su PVM)'),
	(59,156,1,'Pirkimo kaina (su PVM)'),
	(61,157,1,'Kliento tipas');

/*!40000 ALTER TABLE `mg_eav_attribute_label` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_attribute_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute_option`;

CREATE TABLE `mg_eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MG_EAV_ATTR_OPT_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';

LOCK TABLES `mg_eav_attribute_option` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute_option` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute_option` (`option_id`, `attribute_id`, `sort_order`)
VALUES
	(1,18,0),
	(2,18,1),
	(5,157,21),
	(6,157,20);

/*!40000 ALTER TABLE `mg_eav_attribute_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_attribute_option_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute_option_value`;

CREATE TABLE `mg_eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_MG_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ATTR_OPT_VAL_OPT_ID_MG_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';

LOCK TABLES `mg_eav_attribute_option_value` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute_option_value` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute_option_value` (`value_id`, `option_id`, `store_id`, `value`)
VALUES
	(1,1,0,'Male'),
	(2,2,0,'Female'),
	(5,5,0,'Imone'),
	(6,5,1,'Imone'),
	(7,6,0,'Asmuo'),
	(8,6,1,'Asmuo');

/*!40000 ALTER TABLE `mg_eav_attribute_option_value` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_attribute_set
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_attribute_set`;

CREATE TABLE `mg_eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_MG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_MG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `FK_MG_EAV_ATTR_SET_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';

LOCK TABLES `mg_eav_attribute_set` WRITE;
/*!40000 ALTER TABLE `mg_eav_attribute_set` DISABLE KEYS */;

INSERT INTO `mg_eav_attribute_set` (`attribute_set_id`, `entity_type_id`, `attribute_set_name`, `sort_order`)
VALUES
	(1,1,'Default',1),
	(2,2,'Default',1),
	(3,3,'Default',1),
	(4,4,'Default',1),
	(5,5,'Default',1),
	(6,6,'Default',1),
	(7,7,'Default',1),
	(8,8,'Default',1),
	(9,4,'Detales',0),
	(10,4,'Darbuotojas',0);

/*!40000 ALTER TABLE `mg_eav_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity`;

CREATE TABLE `mg_eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_EAV_ENTITY_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';



# Dump of table mg_eav_entity_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_attribute`;

CREATE TABLE `mg_eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_MG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_9C0321A28848B176F99C362D0FA5BE8D` FOREIGN KEY (`attribute_group_id`) REFERENCES `mg_eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_ATTR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';

LOCK TABLES `mg_eav_entity_attribute` WRITE;
/*!40000 ALTER TABLE `mg_eav_entity_attribute` DISABLE KEYS */;

INSERT INTO `mg_eav_entity_attribute` (`entity_attribute_id`, `entity_type_id`, `attribute_set_id`, `attribute_group_id`, `attribute_id`, `sort_order`)
VALUES
	(2,1,1,1,2,0),
	(3,1,1,1,3,20),
	(4,1,1,1,4,30),
	(6,1,1,1,6,50),
	(8,1,1,1,8,70),
	(11,1,1,1,11,90),
	(12,1,1,1,12,0),
	(13,1,1,1,13,0),
	(14,1,1,1,14,0),
	(15,1,1,1,15,100),
	(16,1,1,1,16,0),
	(17,1,1,1,17,86),
	(18,1,1,1,18,110),
	(19,2,2,2,19,10),
	(20,2,2,2,20,20),
	(21,2,2,2,21,30),
	(22,2,2,2,22,40),
	(23,2,2,2,23,50),
	(24,2,2,2,24,60),
	(25,2,2,2,25,70),
	(26,2,2,2,26,80),
	(27,2,2,2,27,90),
	(28,2,2,2,28,100),
	(29,2,2,2,29,100),
	(30,2,2,2,30,110),
	(31,2,2,2,31,120),
	(32,2,2,2,32,130),
	(33,1,1,1,33,111),
	(34,1,1,1,34,112),
	(35,1,1,1,35,28),
	(36,2,2,2,36,140),
	(37,2,2,2,37,132),
	(38,2,2,2,38,133),
	(39,2,2,2,39,134),
	(40,2,2,2,40,135),
	(41,3,3,4,41,1),
	(42,3,3,4,42,2),
	(43,3,3,4,43,3),
	(44,3,3,4,44,4),
	(45,3,3,4,45,5),
	(46,3,3,4,46,6),
	(47,3,3,4,47,7),
	(48,3,3,4,48,8),
	(49,3,3,5,49,10),
	(50,3,3,5,50,20),
	(51,3,3,5,51,30),
	(52,3,3,4,52,12),
	(53,3,3,4,53,13),
	(54,3,3,4,54,14),
	(55,3,3,4,55,15),
	(56,3,3,4,56,16),
	(57,3,3,4,57,17),
	(58,3,3,6,58,10),
	(59,3,3,6,59,30),
	(60,3,3,6,60,40),
	(61,3,3,6,61,50),
	(62,3,3,6,62,60),
	(63,3,3,4,63,24),
	(64,3,3,4,64,25),
	(65,3,3,5,65,40),
	(66,3,3,5,66,50),
	(67,3,3,4,67,10),
	(68,3,3,6,68,5),
	(69,3,3,6,69,6),
	(70,3,3,5,70,51),
	(71,4,4,7,71,1),
	(72,4,4,7,72,2),
	(73,4,4,7,73,3),
	(74,4,4,7,74,4),
	(75,4,4,8,75,1),
	(76,4,4,8,76,3),
	(77,4,4,8,77,4),
	(78,4,4,8,78,5),
	(79,4,4,8,79,6),
	(80,4,4,7,80,5),
	(81,4,4,9,82,1),
	(82,4,4,9,83,2),
	(83,4,4,9,84,3),
	(84,4,4,10,85,1),
	(85,4,4,10,86,2),
	(86,4,4,10,87,3),
	(87,4,4,10,88,4),
	(88,4,4,7,89,6),
	(89,4,4,8,90,2),
	(90,4,4,8,91,7),
	(91,4,4,7,93,7),
	(92,4,4,7,94,8),
	(93,4,4,10,95,5),
	(94,4,4,7,96,9),
	(95,4,4,7,97,10),
	(96,4,4,7,98,11),
	(97,4,4,8,99,8),
	(98,4,4,11,100,1),
	(99,4,4,11,101,2),
	(100,4,4,7,102,12),
	(101,4,4,12,103,1),
	(102,4,4,12,104,2),
	(103,4,4,12,105,3),
	(104,4,4,12,106,4),
	(105,4,4,12,107,5),
	(106,4,4,7,108,13),
	(107,4,4,12,109,6),
	(108,4,4,7,110,14),
	(109,4,4,7,111,15),
	(110,4,4,7,112,16),
	(111,4,4,7,113,17),
	(112,4,4,7,114,18),
	(113,4,4,7,115,19),
	(114,4,4,7,116,20),
	(115,4,4,7,117,21),
	(116,4,4,8,118,9),
	(117,4,4,8,119,10),
	(118,4,4,8,120,11),
	(119,4,4,8,121,12),
	(120,4,4,8,122,13),
	(121,4,4,17,123,1),
	(122,4,4,7,124,22),
	(123,4,4,7,125,23),
	(124,4,4,7,126,24),
	(125,4,4,8,127,14),
	(126,4,4,7,128,25),
	(127,4,4,7,129,26),
	(128,4,4,7,130,27),
	(129,4,4,7,131,28),
	(130,4,4,7,132,29),
	(131,3,3,4,133,4),
	(181,4,9,23,99,8),
	(205,4,9,24,89,6),
	(215,4,9,24,98,11),
	(219,4,9,24,108,13),
	(221,4,9,24,110,14),
	(223,4,9,24,111,15),
	(225,4,9,24,112,16),
	(227,4,9,24,113,17),
	(229,4,9,24,114,18),
	(231,4,9,24,115,19),
	(233,4,9,24,116,20),
	(237,4,9,24,124,22),
	(239,4,9,24,125,23),
	(241,4,9,24,126,24),
	(243,4,9,24,128,25),
	(245,4,9,24,129,26),
	(247,4,9,24,130,27),
	(249,4,9,24,131,28),
	(251,4,9,24,132,29),
	(407,4,10,31,89,6),
	(417,4,10,31,98,11),
	(421,4,10,31,108,13),
	(423,4,10,31,110,14),
	(425,4,10,31,111,15),
	(427,4,10,31,112,16),
	(429,4,10,31,113,17),
	(431,4,10,31,114,18),
	(433,4,10,31,115,19),
	(435,4,10,31,116,20),
	(439,4,10,31,124,22),
	(441,4,10,31,125,23),
	(443,4,10,31,126,24),
	(445,4,10,31,128,25),
	(447,4,10,31,129,26),
	(449,4,10,31,130,27),
	(451,4,10,31,131,28),
	(453,4,10,31,132,29),
	(877,4,10,31,71,1),
	(879,4,10,29,72,24),
	(881,4,10,29,73,13),
	(883,4,10,29,74,15),
	(885,4,10,29,75,1),
	(887,4,10,29,76,9),
	(889,4,10,29,77,16),
	(891,4,10,29,78,18),
	(893,4,10,29,79,6),
	(895,4,10,29,80,4),
	(897,4,10,29,82,29),
	(899,4,10,29,83,19),
	(901,4,10,29,84,25),
	(903,4,10,29,85,39),
	(905,4,10,29,86,30),
	(907,4,10,29,87,26),
	(909,4,10,29,88,27),
	(911,4,10,29,90,5),
	(913,4,10,29,91,17),
	(915,4,10,29,93,10),
	(917,4,10,29,94,12),
	(919,4,10,29,95,28),
	(921,4,10,29,96,2),
	(923,4,10,29,97,11),
	(925,4,10,29,100,35),
	(927,4,10,29,101,31),
	(929,4,10,29,102,8),
	(931,4,10,29,103,32),
	(933,4,10,29,104,40),
	(935,4,10,29,105,37),
	(937,4,10,29,106,36),
	(939,4,10,29,107,33),
	(941,4,10,29,109,34),
	(943,4,10,29,117,7),
	(945,4,10,29,118,21),
	(947,4,10,29,119,22),
	(949,4,10,29,120,20),
	(951,4,10,29,121,14),
	(953,4,10,29,122,23),
	(955,4,10,29,123,38),
	(957,4,10,29,127,41),
	(959,4,10,29,134,3),
	(961,1,1,1,9,80),
	(963,1,1,1,5,40),
	(967,1,1,1,7,60),
	(969,1,1,1,1,10),
	(971,1,1,1,139,0),
	(977,1,1,1,142,0),
	(979,1,1,1,141,0),
	(981,1,1,1,140,0),
	(983,1,1,1,143,0),
	(985,1,1,1,144,0),
	(987,1,1,1,145,0),
	(989,1,1,1,146,0),
	(991,1,1,1,147,0),
	(993,1,1,1,148,0),
	(1087,1,1,1,150,0),
	(1091,1,1,1,152,0),
	(1093,1,1,1,153,0),
	(1095,1,1,1,154,0),
	(1101,1,1,1,10,25),
	(1103,4,9,24,71,1),
	(1105,4,9,24,80,2),
	(1107,4,9,24,117,3),
	(1109,4,9,32,135,2),
	(1111,4,9,32,136,3),
	(1113,4,9,32,149,1),
	(1115,4,9,23,75,1),
	(1117,4,9,23,138,3),
	(1119,4,9,23,155,2),
	(1121,4,9,23,156,4),
	(1123,4,9,22,72,6),
	(1125,4,9,22,73,5),
	(1127,4,9,22,74,9),
	(1129,4,9,22,76,12),
	(1131,4,9,22,77,10),
	(1133,4,9,22,78,13),
	(1135,4,9,22,79,15),
	(1137,4,9,22,81,38),
	(1139,4,9,22,82,2),
	(1141,4,9,22,83,17),
	(1143,4,9,22,84,36),
	(1145,4,9,22,85,22),
	(1147,4,9,22,86,26),
	(1149,4,9,22,87,34),
	(1151,4,9,22,88,25),
	(1153,4,9,22,90,11),
	(1155,4,9,22,91,8),
	(1157,4,9,22,93,4),
	(1159,4,9,22,94,3),
	(1161,4,9,22,95,29),
	(1163,4,9,22,96,1),
	(1165,4,9,22,97,7),
	(1167,4,9,22,100,23),
	(1169,4,9,22,101,24),
	(1171,4,9,22,102,37),
	(1173,4,9,22,103,27),
	(1175,4,9,22,104,28),
	(1177,4,9,22,105,35),
	(1179,4,9,22,106,33),
	(1181,4,9,22,107,32),
	(1183,4,9,22,109,30),
	(1185,4,9,22,118,14),
	(1187,4,9,22,119,16),
	(1189,4,9,22,120,19),
	(1191,4,9,22,121,20),
	(1193,4,9,22,122,18),
	(1195,4,9,22,123,31),
	(1197,4,9,22,127,21),
	(1199,1,1,1,157,0);

/*!40000 ALTER TABLE `mg_eav_entity_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_datetime`;

CREATE TABLE `mg_eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MG_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MG_EAV_ENTITY_DATETIME_ENTITY_ID_MG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTITY_DATETIME_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_DTIME_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table mg_eav_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_decimal`;

CREATE TABLE `mg_eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MG_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MG_EAV_ENTITY_DECIMAL_ENTITY_ID_MG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTITY_DECIMAL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_DEC_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table mg_eav_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_int`;

CREATE TABLE `mg_eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MG_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MG_EAV_ENTITY_INT_ENTITY_ID_MG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTITY_INT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_INT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table mg_eav_entity_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_store`;

CREATE TABLE `mg_eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_MG_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_EAV_ENTITY_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_STORE_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';



# Dump of table mg_eav_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_text`;

CREATE TABLE `mg_eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_EAV_ENTITY_TEXT_ENTITY_ID_MG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTITY_TEXT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_TEXT_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table mg_eav_entity_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_type`;

CREATE TABLE `mg_eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';

LOCK TABLES `mg_eav_entity_type` WRITE;
/*!40000 ALTER TABLE `mg_eav_entity_type` DISABLE KEYS */;

INSERT INTO `mg_eav_entity_type` (`entity_type_id`, `entity_type_code`, `entity_model`, `attribute_model`, `entity_table`, `value_table_prefix`, `entity_id_field`, `is_data_sharing`, `data_sharing_key`, `default_attribute_set_id`, `increment_model`, `increment_per_store`, `increment_pad_length`, `increment_pad_char`, `additional_attribute_table`, `entity_attribute_collection`)
VALUES
	(1,'customer','customer/customer','customer/attribute','customer/entity',NULL,NULL,1,'default',1,'eav/entity_increment_numeric',0,8,'0','customer/eav_attribute','customer/attribute_collection'),
	(2,'customer_address','customer/address','customer/attribute','customer/address_entity',NULL,NULL,1,'default',2,NULL,0,8,'0','customer/eav_attribute','customer/address_attribute_collection'),
	(3,'catalog_category','catalog/category','catalog/resource_eav_attribute','catalog/category',NULL,NULL,1,'default',3,NULL,0,8,'0','catalog/eav_attribute','catalog/category_attribute_collection'),
	(4,'catalog_product','catalog/product','catalog/resource_eav_attribute','catalog/product',NULL,NULL,1,'default',4,NULL,0,8,'0','catalog/eav_attribute','catalog/product_attribute_collection'),
	(5,'order','sales/order',NULL,'sales/order',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(6,'invoice','sales/order_invoice',NULL,'sales/invoice',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(7,'creditmemo','sales/order_creditmemo',NULL,'sales/creditmemo',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(8,'shipment','sales/order_shipment',NULL,'sales/shipment',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL);

/*!40000 ALTER TABLE `mg_eav_entity_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_entity_varchar`;

CREATE TABLE `mg_eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MG_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MG_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MG_EAV_ENTITY_VARCHAR_ENTITY_ID_MG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTITY_VARCHAR_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_ENTT_VCHR_ENTT_TYPE_ID_MG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table mg_eav_form_element
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_form_element`;

CREATE TABLE `mg_eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_MG_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_MG_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_MG_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_MG_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MG_EAV_FORM_ELEMENT_TYPE_ID_MG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mg_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_FORM_ELM_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_FORM_ELM_FSET_ID_MG_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `mg_eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';

LOCK TABLES `mg_eav_form_element` WRITE;
/*!40000 ALTER TABLE `mg_eav_form_element` DISABLE KEYS */;

INSERT INTO `mg_eav_form_element` (`element_id`, `type_id`, `fieldset_id`, `attribute_id`, `sort_order`)
VALUES
	(1,1,NULL,20,0),
	(2,1,NULL,22,1),
	(3,1,NULL,24,2),
	(4,1,NULL,9,3),
	(5,1,NULL,25,4),
	(6,1,NULL,26,5),
	(7,1,NULL,28,6),
	(8,1,NULL,30,7),
	(9,1,NULL,27,8),
	(10,1,NULL,31,9),
	(11,1,NULL,32,10),
	(12,2,NULL,20,0),
	(13,2,NULL,22,1),
	(14,2,NULL,24,2),
	(15,2,NULL,9,3),
	(16,2,NULL,25,4),
	(17,2,NULL,26,5),
	(18,2,NULL,28,6),
	(19,2,NULL,30,7),
	(20,2,NULL,27,8),
	(21,2,NULL,31,9),
	(22,2,NULL,32,10),
	(23,3,NULL,20,0),
	(24,3,NULL,22,1),
	(25,3,NULL,24,2),
	(26,3,NULL,25,3),
	(27,3,NULL,26,4),
	(28,3,NULL,28,5),
	(29,3,NULL,30,6),
	(30,3,NULL,27,7),
	(31,3,NULL,31,8),
	(32,3,NULL,32,9),
	(33,4,NULL,20,0),
	(34,4,NULL,22,1),
	(35,4,NULL,24,2),
	(36,4,NULL,25,3),
	(37,4,NULL,26,4),
	(38,4,NULL,28,5),
	(39,4,NULL,30,6),
	(40,4,NULL,27,7),
	(41,4,NULL,31,8),
	(42,4,NULL,32,9),
	(43,5,1,5,0),
	(44,5,1,7,1),
	(45,5,1,9,2),
	(46,5,2,24,0),
	(47,5,2,31,1),
	(48,5,2,25,2),
	(49,5,2,26,3),
	(50,5,2,28,4),
	(51,5,2,30,5),
	(52,5,2,27,6);

/*!40000 ALTER TABLE `mg_eav_form_element` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_form_fieldset
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_form_fieldset`;

CREATE TABLE `mg_eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_MG_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_MG_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_MG_EAV_FORM_FIELDSET_TYPE_ID_MG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mg_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';

LOCK TABLES `mg_eav_form_fieldset` WRITE;
/*!40000 ALTER TABLE `mg_eav_form_fieldset` DISABLE KEYS */;

INSERT INTO `mg_eav_form_fieldset` (`fieldset_id`, `type_id`, `code`, `sort_order`)
VALUES
	(1,5,'general',1),
	(2,5,'address',2);

/*!40000 ALTER TABLE `mg_eav_form_fieldset` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_form_fieldset_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_form_fieldset_label`;

CREATE TABLE `mg_eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_MG_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_MG_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_EAV_FORM_FIELDSET_LABEL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_FORM_FSET_LBL_FSET_ID_MG_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `mg_eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';

LOCK TABLES `mg_eav_form_fieldset_label` WRITE;
/*!40000 ALTER TABLE `mg_eav_form_fieldset_label` DISABLE KEYS */;

INSERT INTO `mg_eav_form_fieldset_label` (`fieldset_id`, `store_id`, `label`)
VALUES
	(1,0,'Personal Information'),
	(2,0,'Address Information');

/*!40000 ALTER TABLE `mg_eav_form_fieldset_label` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_form_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_form_type`;

CREATE TABLE `mg_eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_MG_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_MG_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_EAV_FORM_TYPE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';

LOCK TABLES `mg_eav_form_type` WRITE;
/*!40000 ALTER TABLE `mg_eav_form_type` DISABLE KEYS */;

INSERT INTO `mg_eav_form_type` (`type_id`, `code`, `label`, `is_system`, `theme`, `store_id`)
VALUES
	(1,'checkout_onepage_register','checkout_onepage_register',1,'',0),
	(2,'checkout_onepage_register_guest','checkout_onepage_register_guest',1,'',0),
	(3,'checkout_onepage_billing_address','checkout_onepage_billing_address',1,'',0),
	(4,'checkout_onepage_shipping_address','checkout_onepage_shipping_address',1,'',0),
	(5,'checkout_multishipping_register','checkout_multishipping_register',1,'',0);

/*!40000 ALTER TABLE `mg_eav_form_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_eav_form_type_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_eav_form_type_entity`;

CREATE TABLE `mg_eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_MG_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_665D3691CA1CF6254187EC28E23D868B` FOREIGN KEY (`entity_type_id`) REFERENCES `mg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_EAV_FORM_TYPE_ENTITY_TYPE_ID_MG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mg_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';

LOCK TABLES `mg_eav_form_type_entity` WRITE;
/*!40000 ALTER TABLE `mg_eav_form_type_entity` DISABLE KEYS */;

INSERT INTO `mg_eav_form_type_entity` (`type_id`, `entity_type_id`)
VALUES
	(1,1),
	(2,1),
	(5,1),
	(1,2),
	(2,2),
	(3,2),
	(4,2),
	(5,2);

/*!40000 ALTER TABLE `mg_eav_form_type_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_gift_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_gift_message`;

CREATE TABLE `mg_gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';



# Dump of table mg_googlecheckout_notification
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_googlecheckout_notification`;

CREATE TABLE `mg_googlecheckout_notification` (
  `serial_number` varchar(64) NOT NULL COMMENT 'Serial Number',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Checkout Notification Table';



# Dump of table mg_importexport_importdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_importexport_importdata`;

CREATE TABLE `mg_importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';



# Dump of table mg_index_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_index_event`;

CREATE TABLE `mg_index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_MG_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Event';

LOCK TABLES `mg_index_event` WRITE;
/*!40000 ALTER TABLE `mg_index_event` DISABLE KEYS */;

INSERT INTO `mg_index_event` (`event_id`, `type`, `entity`, `entity_pk`, `created_at`, `old_data`, `new_data`)
VALUES
	(1,'save','catalog_category',1,'2013-08-09 22:43:30',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(2,'save','catalog_category',2,'2013-08-09 22:43:30',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(3,'save','catalog_eav_attribute',72,'2013-08-12 20:35:49',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(4,'save','catalog_eav_attribute',71,'2013-08-12 20:35:59',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(5,'save','catalog_eav_attribute',75,'2013-08-12 20:36:09',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(6,'save','catalog_eav_attribute',127,'2013-08-12 20:36:18',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(7,'save','catalog_eav_attribute',73,'2013-08-12 20:36:26',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(8,'save','catalog_eav_attribute',74,'2013-08-12 20:36:34',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(9,'save','catalog_eav_attribute',96,'2013-08-12 20:36:42',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(10,'save','catalog_eav_attribute',122,'2013-08-12 20:36:50',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(11,'save','catalog_eav_attribute',102,'2013-08-12 20:36:58',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(12,'save','catalog_eav_attribute',80,'2013-08-12 20:37:07',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(13,'save','catalog_eav_attribute',134,'2013-08-12 20:53:37',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(14,'save','catalog_eav_attribute',135,'2013-08-12 20:57:05',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(15,'save','catalog_eav_attribute',136,'2013-08-12 20:57:38',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(16,'save','catalog_eav_attribute',137,'2013-08-12 20:59:34',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(17,'delete','catalog_eav_attribute',137,'2013-08-12 21:00:04',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";s:1:\"0\";}'),
	(18,'save','catalog_eav_attribute',138,'2013-08-12 21:00:27',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(19,'save','cataloginventory_stock_item',1,'2013-08-12 21:05:11',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(20,'save','catalog_product',1,'2013-08-12 21:05:12',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:1;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(21,'catalog_reindex_price','catalog_product',1,'2013-08-12 21:05:12',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(22,'save','catalog_category',3,'2013-08-12 21:05:39',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(23,'save','catalog_category',4,'2013-08-12 21:05:55',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(24,'delete','catalog_product',1,'2013-08-12 21:06:46',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(25,'save','cataloginventory_stock_item',2,'2013-08-12 21:07:03',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(26,'save','catalog_product',2,'2013-08-12 21:07:03',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:1;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(27,'catalog_reindex_price','catalog_product',2,'2013-08-12 21:07:03',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(28,'save','cataloginventory_stock_item',3,'2013-08-12 21:07:46',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(29,'save','catalog_product',3,'2013-08-12 21:07:46',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:1;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:1;s:33:\"catalog_product_flat_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(30,'catalog_reindex_price','catalog_product',3,'2013-08-12 21:07:46',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(31,'save','catalog_eav_attribute',149,'2013-08-12 21:29:05',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(32,'save','customer_group',4,'2013-08-14 22:50:42',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(33,'save','customer_group',5,'2013-08-14 22:51:01',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:1;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:0;}'),
	(34,'save','catalog_eav_attribute',155,'2013-08-14 23:56:37',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(35,'save','catalog_eav_attribute',156,'2013-08-14 23:57:15',NULL,'a:6:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:0;s:33:\"catalog_product_flat_match_result\";b:0;s:37:\"catalog_category_product_match_result\";b:0;s:35:\"catalogsearch_fulltext_match_result\";b:1;}');

/*!40000 ALTER TABLE `mg_index_event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_index_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_index_process`;

CREATE TABLE `mg_index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_MG_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process';

LOCK TABLES `mg_index_process` WRITE;
/*!40000 ALTER TABLE `mg_index_process` DISABLE KEYS */;

INSERT INTO `mg_index_process` (`process_id`, `indexer_code`, `status`, `started_at`, `ended_at`, `mode`)
VALUES
	(1,'catalog_product_attribute','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(2,'catalog_product_price','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(3,'catalog_url','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(4,'catalog_product_flat','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(5,'catalog_category_flat','pending','2013-08-12 20:34:06','2013-08-12 20:34:06','real_time'),
	(6,'catalog_category_product','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(7,'catalogsearch_fulltext','pending','2013-08-15 19:59:55','2013-08-15 19:59:55','real_time'),
	(8,'cataloginventory_stock','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time'),
	(9,'tag_summary','pending','2013-08-15 00:00:21','2013-08-15 00:00:21','real_time');

/*!40000 ALTER TABLE `mg_index_process` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_index_process_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_index_process_event`;

CREATE TABLE `mg_index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_MG_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_MG_INDEX_PROCESS_EVENT_EVENT_ID_MG_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `mg_index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_INDEX_PROCESS_EVENT_PROCESS_ID_MG_INDEX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `mg_index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';



# Dump of table mg_log_customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_customer`;

CREATE TABLE `mg_log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_MG_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Customers Table';



# Dump of table mg_log_quote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_quote`;

CREATE TABLE `mg_log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';



# Dump of table mg_log_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_summary`;

CREATE TABLE `mg_log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table';



# Dump of table mg_log_summary_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_summary_type`;

CREATE TABLE `mg_log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table';

LOCK TABLES `mg_log_summary_type` WRITE;
/*!40000 ALTER TABLE `mg_log_summary_type` DISABLE KEYS */;

INSERT INTO `mg_log_summary_type` (`type_id`, `type_code`, `period`, `period_type`)
VALUES
	(1,'hour',1,'HOUR'),
	(2,'day',1,'DAY');

/*!40000 ALTER TABLE `mg_log_summary_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_log_url
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_url`;

CREATE TABLE `mg_log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Visit Time',
  PRIMARY KEY (`url_id`),
  KEY `IDX_MG_LOG_URL_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';

LOCK TABLES `mg_log_url` WRITE;
/*!40000 ALTER TABLE `mg_log_url` DISABLE KEYS */;

INSERT INTO `mg_log_url` (`url_id`, `visitor_id`, `visit_time`)
VALUES
	(1,1,'2013-08-09 22:44:46'),
	(2,2,'2013-08-10 00:04:45'),
	(3,2,'2013-08-10 00:05:09'),
	(4,2,'2013-08-10 00:05:13'),
	(5,2,'2013-08-10 00:10:33'),
	(6,3,'2013-08-10 22:06:35'),
	(7,4,'2013-08-13 21:12:52'),
	(8,4,'2013-08-13 21:13:05'),
	(9,5,'2013-08-14 22:24:35'),
	(10,6,'2013-08-15 19:59:04'),
	(11,7,'2013-08-19 21:29:23'),
	(12,8,'2013-08-20 20:21:42'),
	(13,9,'2013-08-21 21:24:13'),
	(14,10,'2013-08-23 23:14:00'),
	(15,11,'2013-08-24 13:32:35');

/*!40000 ALTER TABLE `mg_log_url` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_log_url_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_url_info`;

CREATE TABLE `mg_log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table';

LOCK TABLES `mg_log_url_info` WRITE;
/*!40000 ALTER TABLE `mg_log_url_info` DISABLE KEYS */;

INSERT INTO `mg_log_url_info` (`url_id`, `url`, `referer`)
VALUES
	(1,'http://magento/index.php/','http://magento/index.php/install/wizard/end/'),
	(2,'http://magento/',NULL),
	(3,'http://magento/',NULL),
	(4,'http://magento/index.php/customer/account/login/','http://magento/'),
	(5,'http://magento/',NULL),
	(6,'http://magento/',NULL),
	(7,'http://magento/',NULL),
	(8,'http://magento/index.php/adminh',NULL),
	(9,'http://magento/',NULL),
	(10,'http://magento/',NULL),
	(11,'http://magento/',NULL),
	(12,'http://magento/',NULL),
	(13,'http://magento/index.php',NULL),
	(14,'http://magento/',NULL),
	(15,'http://magento/',NULL);

/*!40000 ALTER TABLE `mg_log_url_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_log_visitor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_visitor`;

CREATE TABLE `mg_log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table';

LOCK TABLES `mg_log_visitor` WRITE;
/*!40000 ALTER TABLE `mg_log_visitor` DISABLE KEYS */;

INSERT INTO `mg_log_visitor` (`visitor_id`, `session_id`, `first_visit_at`, `last_visit_at`, `last_url_id`, `store_id`)
VALUES
	(1,'4b2ce969132e21f85ed4c4476ca9ae12','2013-08-09 22:44:45','2013-08-09 22:44:46',1,1),
	(2,'a7c6aa97cbf70b41d407e00c8785fa9c','2013-08-10 00:04:45','2013-08-10 00:10:33',5,1),
	(3,'f6cb66e775366f43842e539173ce78de','2013-08-10 22:06:34','2013-08-10 22:06:35',6,1),
	(4,'a1affe45bdab084b437f5d8a1ee57093','2013-08-13 21:12:46','2013-08-13 21:13:05',8,1),
	(5,'ef33fffab90f6ba48644d54ec0862c56','2013-08-14 22:24:34','2013-08-14 22:24:35',9,1),
	(6,'8c0a0040095641d9b14db1338cc26c7f','2013-08-15 19:59:03','2013-08-15 19:59:04',10,1),
	(7,'3ce255cf0bdab74211a0e3ac90f4b0bc','2013-08-19 21:29:21','2013-08-19 21:29:23',11,1),
	(8,'49f4b4959843c6a1af4bbb9572f0b6e7','2013-08-20 20:21:40','2013-08-20 20:21:42',12,1),
	(9,'4bb706c7a10bd4d1488637e98902733a','2013-08-21 21:24:11','2013-08-21 21:24:13',13,1),
	(10,'aa87241836a3d70892be848a9f941b78','2013-08-23 23:13:58','2013-08-23 23:14:00',14,1),
	(11,'8eec568550f03ca5c6c554b78d9d23bf','2013-08-24 13:32:33','2013-08-24 13:32:35',15,1);

/*!40000 ALTER TABLE `mg_log_visitor` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_log_visitor_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_visitor_info`;

CREATE TABLE `mg_log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` bigint(20) DEFAULT NULL COMMENT 'Server Address',
  `remote_addr` bigint(20) DEFAULT NULL COMMENT 'Remote Address',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';

LOCK TABLES `mg_log_visitor_info` WRITE;
/*!40000 ALTER TABLE `mg_log_visitor_info` DISABLE KEYS */;

INSERT INTO `mg_log_visitor_info` (`visitor_id`, `http_referer`, `http_user_agent`, `http_accept_charset`, `http_accept_language`, `server_addr`, `remote_addr`)
VALUES
	(1,'http://magento/index.php/install/wizard/end/','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(2,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(3,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(4,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(5,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(6,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(7,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(8,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(9,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(10,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433),
	(11,NULL,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0',NULL,'en-US,en;q=0.5',2130706433,2130706433);

/*!40000 ALTER TABLE `mg_log_visitor_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_log_visitor_online
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_log_visitor_online`;

CREATE TABLE `mg_log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` bigint(20) NOT NULL COMMENT 'Remote Address',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_MG_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_MG_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_MG_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table';

LOCK TABLES `mg_log_visitor_online` WRITE;
/*!40000 ALTER TABLE `mg_log_visitor_online` DISABLE KEYS */;

INSERT INTO `mg_log_visitor_online` (`visitor_id`, `visitor_type`, `remote_addr`, `first_visit_at`, `last_visit_at`, `customer_id`, `last_url`)
VALUES
	(3,'v',2130706433,'2013-08-10 22:06:34','2013-08-10 22:06:35',NULL,'http://magento/');

/*!40000 ALTER TABLE `mg_log_visitor_online` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_newsletter_problem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_problem`;

CREATE TABLE `mg_newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_MG_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_MG_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `FK_6BDCF392A2CCC81CE37A06E592E044DE` FOREIGN KEY (`subscriber_id`) REFERENCES `mg_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_NEWSLETTER_PROBLEM_QUEUE_ID_MG_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mg_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';



# Dump of table mg_newsletter_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_queue`;

CREATE TABLE `mg_newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_MG_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_MG_NLTTR_QUEUE_TEMPLATE_ID_MG_NLTTR_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `mg_newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';



# Dump of table mg_newsletter_queue_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_queue_link`;

CREATE TABLE `mg_newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_MG_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_MG_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_MG_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `FK_D8FD38FB1EB36B24D71B41B531373E43` FOREIGN KEY (`subscriber_id`) REFERENCES `mg_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_NLTTR_QUEUE_LNK_QUEUE_ID_MG_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mg_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';



# Dump of table mg_newsletter_queue_store_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_queue_store_link`;

CREATE TABLE `mg_newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_MG_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_MG_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mg_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_NLTTR_QUEUE_STORE_LNK_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';



# Dump of table mg_newsletter_subscriber
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_subscriber`;

CREATE TABLE `mg_newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_MG_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_NEWSLETTER_SUBSCRIBER_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';



# Dump of table mg_newsletter_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_newsletter_template`;

CREATE TABLE `mg_newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_MG_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_MG_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_MG_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';



# Dump of table mg_oauth_consumer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_oauth_consumer`;

CREATE TABLE `mg_oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_MG_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_MG_MG_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_MG_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_MG_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';



# Dump of table mg_oauth_nonce
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_oauth_nonce`;

CREATE TABLE `mg_oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_MG_MG_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='mg_oauth_nonce';



# Dump of table mg_oauth_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_oauth_token`;

CREATE TABLE `mg_oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_MG_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_MG_MG_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_MG_OAUTH_TOKEN_ADMIN_ID_MG_MG_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_MG_OAUTH_TOKEN_CUSTOMER_ID_MG_MG_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `FK_MG_OAUTH_TOKEN_ADMIN_ID_MG_MG_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `mg_admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_OAUTH_TOKEN_CONSUMER_ID_MG_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `mg_oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_OAUTH_TOKEN_CUSTOMER_ID_MG_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';



# Dump of table mg_paypal_cert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_paypal_cert`;

CREATE TABLE `mg_paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_MG_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_PAYPAL_CERT_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';



# Dump of table mg_paypal_payment_transaction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_paypal_payment_transaction`;

CREATE TABLE `mg_paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_MG_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';



# Dump of table mg_paypal_settlement_report
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_paypal_settlement_report`;

CREATE TABLE `mg_paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_MG_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';



# Dump of table mg_paypal_settlement_report_row
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_paypal_settlement_report_row`;

CREATE TABLE `mg_paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_MG_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_B0234CCA0A59BECD0BF179CC6B28399C` FOREIGN KEY (`report_id`) REFERENCES `mg_paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';



# Dump of table mg_persistent_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_persistent_session`;

CREATE TABLE `mg_persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_MG_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_MG_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_MG_PERSISTENT_SESSION_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_PERSISTENT_SESSION_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_PERSISTENT_SESS_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';



# Dump of table mg_poll
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_poll`;

CREATE TABLE `mg_poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_MG_POLL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_POLL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll';

LOCK TABLES `mg_poll` WRITE;
/*!40000 ALTER TABLE `mg_poll` DISABLE KEYS */;

INSERT INTO `mg_poll` (`poll_id`, `poll_title`, `votes_count`, `store_id`, `date_posted`, `date_closed`, `active`, `closed`, `answers_display`)
VALUES
	(1,'What is your favorite color',7,0,'2013-08-10 01:43:30',NULL,1,0,NULL);

/*!40000 ALTER TABLE `mg_poll` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_poll_answer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_poll_answer`;

CREATE TABLE `mg_poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_MG_POLL_ANSWER_POLL_ID` (`poll_id`),
  CONSTRAINT `FK_MG_POLL_ANSWER_POLL_ID_MG_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `mg_poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Answers';

LOCK TABLES `mg_poll_answer` WRITE;
/*!40000 ALTER TABLE `mg_poll_answer` DISABLE KEYS */;

INSERT INTO `mg_poll_answer` (`answer_id`, `poll_id`, `answer_title`, `votes_count`, `answer_order`)
VALUES
	(1,1,'Green',4,0),
	(2,1,'Red',1,0),
	(3,1,'Black',0,0),
	(4,1,'Magenta',2,0);

/*!40000 ALTER TABLE `mg_poll_answer` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_poll_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_poll_store`;

CREATE TABLE `mg_poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_MG_POLL_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_POLL_STORE_POLL_ID_MG_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `mg_poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_POLL_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';

LOCK TABLES `mg_poll_store` WRITE;
/*!40000 ALTER TABLE `mg_poll_store` DISABLE KEYS */;

INSERT INTO `mg_poll_store` (`poll_id`, `store_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `mg_poll_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_poll_vote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_poll_vote`;

CREATE TABLE `mg_poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` bigint(20) DEFAULT NULL COMMENT 'Poll answer id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_MG_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`),
  CONSTRAINT `FK_MG_POLL_VOTE_POLL_ANSWER_ID_MG_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `mg_poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Vote';



# Dump of table mg_product_alert_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_product_alert_price`;

CREATE TABLE `mg_product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_MG_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_PRD_ALERT_PRICE_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_PRD_ALERT_PRICE_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_PRODUCT_ALERT_PRICE_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';



# Dump of table mg_product_alert_stock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_product_alert_stock`;

CREATE TABLE `mg_product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_MG_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_PRD_ALERT_STOCK_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_PRD_ALERT_STOCK_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_PRODUCT_ALERT_STOCK_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';



# Dump of table mg_rating
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating`;

CREATE TABLE `mg_rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_MG_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_MG_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MG_RATING_ENTITY_ID_MG_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ratings';

LOCK TABLES `mg_rating` WRITE;
/*!40000 ALTER TABLE `mg_rating` DISABLE KEYS */;

INSERT INTO `mg_rating` (`rating_id`, `entity_id`, `rating_code`, `position`)
VALUES
	(1,1,'Quality',0),
	(2,1,'Value',0),
	(3,1,'Price',0);

/*!40000 ALTER TABLE `mg_rating` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_rating_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_entity`;

CREATE TABLE `mg_rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating entities';

LOCK TABLES `mg_rating_entity` WRITE;
/*!40000 ALTER TABLE `mg_rating_entity` DISABLE KEYS */;

INSERT INTO `mg_rating_entity` (`entity_id`, `entity_code`)
VALUES
	(1,'product'),
	(2,'product_review'),
	(3,'review');

/*!40000 ALTER TABLE `mg_rating_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_rating_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_option`;

CREATE TABLE `mg_rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MG_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `FK_MG_RATING_OPTION_RATING_ID_MG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mg_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating options';

LOCK TABLES `mg_rating_option` WRITE;
/*!40000 ALTER TABLE `mg_rating_option` DISABLE KEYS */;

INSERT INTO `mg_rating_option` (`option_id`, `rating_id`, `code`, `value`, `position`)
VALUES
	(1,1,'1',1,1),
	(2,1,'2',2,2),
	(3,1,'3',3,3),
	(4,1,'4',4,4),
	(5,1,'5',5,5),
	(6,2,'1',1,1),
	(7,2,'2',2,2),
	(8,2,'3',3,3),
	(9,2,'4',4,4),
	(10,2,'5',5,5),
	(11,3,'1',1,1),
	(12,3,'2',2,2),
	(13,3,'3',3,3),
	(14,3,'4',4,4),
	(15,3,'5',5,5);

/*!40000 ALTER TABLE `mg_rating_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_rating_option_vote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_option_vote`;

CREATE TABLE `mg_rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_MG_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_MG_RATING_OPTION_VOTE_REVIEW_ID_MG_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `FK_MG_RATING_OPTION_VOTE_OPTION_ID_MG_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `mg_rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_RATING_OPTION_VOTE_REVIEW_ID_MG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mg_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';



# Dump of table mg_rating_option_vote_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_option_vote_aggregated`;

CREATE TABLE `mg_rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_MG_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_MG_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_RATING_OPT_VOTE_AGGRED_RATING_ID_MG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mg_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_RATING_OPT_VOTE_AGGRED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';



# Dump of table mg_rating_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_store`;

CREATE TABLE `mg_rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_MG_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_RATING_STORE_RATING_ID_MG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mg_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_RATING_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';



# Dump of table mg_rating_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_rating_title`;

CREATE TABLE `mg_rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_MG_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_RATING_TITLE_RATING_ID_MG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mg_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_RATING_TITLE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';



# Dump of table mg_report_compared_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_compared_product_index`;

CREATE TABLE `mg_report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_MG_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_MG_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MG_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_MG_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_MG_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_REPORT_CMPD_PRD_IDX_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REPORT_CMPD_PRD_IDX_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REPORT_CMPD_PRD_IDX_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';



# Dump of table mg_report_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_event`;

CREATE TABLE `mg_report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_MG_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_MG_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_MG_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_MG_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_MG_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_7FB0045BED6FAB7156FAC80981D0BBBD` FOREIGN KEY (`event_type_id`) REFERENCES `mg_report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REPORT_EVENT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';



# Dump of table mg_report_event_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_event_types`;

CREATE TABLE `mg_report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';

LOCK TABLES `mg_report_event_types` WRITE;
/*!40000 ALTER TABLE `mg_report_event_types` DISABLE KEYS */;

INSERT INTO `mg_report_event_types` (`event_type_id`, `event_name`, `customer_login`)
VALUES
	(1,'catalog_product_view',0),
	(2,'sendfriend_product',0),
	(3,'catalog_product_compare_add_product',0),
	(4,'checkout_cart_add_product',0),
	(5,'wishlist_add_product',0),
	(6,'wishlist_share',0);

/*!40000 ALTER TABLE `mg_report_event_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_report_viewed_product_aggregated_daily
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_viewed_product_aggregated_daily`;

CREATE TABLE `mg_report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_1EF3543D030461BF5D0B6005D17486A5` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_C0A3C4FDE6FF39EC1D4D4EAFCC79B9B9` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';



# Dump of table mg_report_viewed_product_aggregated_monthly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_viewed_product_aggregated_monthly`;

CREATE TABLE `mg_report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_A2E75A181734B2B0F2888AED6784A7B8` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_F11D1EA64FDB54FD1B2A36F9C3E282F0` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';



# Dump of table mg_report_viewed_product_aggregated_yearly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_viewed_product_aggregated_yearly`;

CREATE TABLE `mg_report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_396A409172FCF1266E16A15CEF86D227` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_8BBFD267A2B27E5164883845EA2F130E` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';



# Dump of table mg_report_viewed_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_report_viewed_product_index`;

CREATE TABLE `mg_report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_MG_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_MG_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_MG_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MG_REPORT_VIEWED_PRD_IDX_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REPORT_VIEWED_PRD_IDX_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REPORT_VIEWED_PRD_IDX_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';



# Dump of table mg_review
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review`;

CREATE TABLE `mg_review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_MG_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_MG_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `FK_MG_REVIEW_ENTITY_ID_MG_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REVIEW_STATUS_ID_MG_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `mg_review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';



# Dump of table mg_review_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review_detail`;

CREATE TABLE `mg_review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_MG_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_MG_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_MG_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_MG_REVIEW_DETAIL_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REVIEW_DETAIL_REVIEW_ID_MG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mg_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REVIEW_DETAIL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';



# Dump of table mg_review_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review_entity`;

CREATE TABLE `mg_review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review entities';

LOCK TABLES `mg_review_entity` WRITE;
/*!40000 ALTER TABLE `mg_review_entity` DISABLE KEYS */;

INSERT INTO `mg_review_entity` (`entity_id`, `entity_code`)
VALUES
	(1,'product'),
	(2,'customer'),
	(3,'category');

/*!40000 ALTER TABLE `mg_review_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_review_entity_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review_entity_summary`;

CREATE TABLE `mg_review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_MG_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_REVIEW_ENTITY_SUMMARY_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';



# Dump of table mg_review_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review_status`;

CREATE TABLE `mg_review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review statuses';

LOCK TABLES `mg_review_status` WRITE;
/*!40000 ALTER TABLE `mg_review_status` DISABLE KEYS */;

INSERT INTO `mg_review_status` (`status_id`, `status_code`)
VALUES
	(1,'Approved'),
	(2,'Pending'),
	(3,'Not Approved');

/*!40000 ALTER TABLE `mg_review_status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_review_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_review_store`;

CREATE TABLE `mg_review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_MG_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_REVIEW_STORE_REVIEW_ID_MG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mg_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_REVIEW_STORE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';



# Dump of table mg_sales_bestsellers_aggregated_daily
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_bestsellers_aggregated_daily`;

CREATE TABLE `mg_sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_44AE06384CF50236725E0B88859802C6` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_8639794DCA69188A0C011824EC3F7190` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';



# Dump of table mg_sales_bestsellers_aggregated_monthly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_bestsellers_aggregated_monthly`;

CREATE TABLE `mg_sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_2038EC237428B5977F4B30F5C9BBB0DF` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_9944B45581E671CFCDB46079647E36CF` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';



# Dump of table mg_sales_bestsellers_aggregated_yearly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_bestsellers_aggregated_yearly`;

CREATE TABLE `mg_sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_87133022E26DB3056A20A60218F9F85D` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_D9AEE21187B9770F184B046E80B8E698` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';



# Dump of table mg_sales_billing_agreement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_billing_agreement`;

CREATE TABLE `mg_sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_MG_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_BILLING_AGREEMENT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_BILLING_AGRT_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';



# Dump of table mg_sales_billing_agreement_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_billing_agreement_order`;

CREATE TABLE `mg_sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_MG_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_31670F14AFC78FB0A478CCF2660E5E02` FOREIGN KEY (`agreement_id`) REFERENCES `mg_sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_338889E55466AEFA52ACD8F9C26B050E` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';



# Dump of table mg_sales_flat_creditmemo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_creditmemo`;

CREATE TABLE `mg_sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_MG_SALES_FLAT_CREDITMEMO_ORDER_ID_MG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_CREDITMEMO_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';



# Dump of table mg_sales_flat_creditmemo_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_creditmemo_comment`;

CREATE TABLE `mg_sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_52F34EBAA818FC05C65C6C270CD5FB7F` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';



# Dump of table mg_sales_flat_creditmemo_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_creditmemo_grid`;

CREATE TABLE `mg_sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_0E714B16D5D6BFEF0A15E5C73DBA022F` FOREIGN KEY (`entity_id`) REFERENCES `mg_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_CREDITMEMO_GRID_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';



# Dump of table mg_sales_flat_creditmemo_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_creditmemo_item`;

CREATE TABLE `mg_sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_BFDB94E8F8CB2F7C937600724BA9BEE8` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';



# Dump of table mg_sales_flat_invoice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_invoice`;

CREATE TABLE `mg_sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_MG_SALES_FLAT_INVOICE_ORDER_ID_MG_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_INVOICE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';



# Dump of table mg_sales_flat_invoice_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_invoice_comment`;

CREATE TABLE `mg_sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_24D51E774A79F61137C14D4A416998C6` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';



# Dump of table mg_sales_flat_invoice_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_invoice_grid`;

CREATE TABLE `mg_sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_4B12C38DDB06CF50E60522DF95C15D2F` FOREIGN KEY (`entity_id`) REFERENCES `mg_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_INVOICE_GRID_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';



# Dump of table mg_sales_flat_invoice_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_invoice_item`;

CREATE TABLE `mg_sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_3CD912263FB8C41AE5BF24B6B03C01ED` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';



# Dump of table mg_sales_flat_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order`;

CREATE TABLE `mg_sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_MG_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_MG_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';



# Dump of table mg_sales_flat_order_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order_address`;

CREATE TABLE `mg_sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_46BBB74C318187269F1E8248884A2824` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';



# Dump of table mg_sales_flat_order_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order_grid`;

CREATE TABLE `mg_sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_GRID_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_GRID_ENTT_ID_MG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_GRID_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';



# Dump of table mg_sales_flat_order_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order_item`;

CREATE TABLE `mg_sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_ITEM_ORDER_ID_MG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_ORDER_ITEM_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';



# Dump of table mg_sales_flat_order_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order_payment`;

CREATE TABLE `mg_sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_6A9A4EB2AB30FAB767172556DC97B00A` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';



# Dump of table mg_sales_flat_order_status_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_order_status_history`;

CREATE TABLE `mg_sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_MG_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_5BA9729A87A2E86CC1C33560DC3FC202` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';



# Dump of table mg_sales_flat_quote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote`;

CREATE TABLE `mg_sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_FLAT_QUOTE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';

LOCK TABLES `mg_sales_flat_quote` WRITE;
/*!40000 ALTER TABLE `mg_sales_flat_quote` DISABLE KEYS */;

INSERT INTO `mg_sales_flat_quote` (`entity_id`, `store_id`, `created_at`, `updated_at`, `converted_at`, `is_active`, `is_virtual`, `is_multi_shipping`, `items_count`, `items_qty`, `orig_order_id`, `store_to_base_rate`, `store_to_quote_rate`, `base_currency_code`, `store_currency_code`, `quote_currency_code`, `grand_total`, `base_grand_total`, `checkout_method`, `customer_id`, `customer_tax_class_id`, `customer_group_id`, `customer_email`, `customer_prefix`, `customer_firstname`, `customer_middlename`, `customer_lastname`, `customer_suffix`, `customer_dob`, `customer_note`, `customer_note_notify`, `customer_is_guest`, `remote_ip`, `applied_rule_ids`, `reserved_order_id`, `password_hash`, `coupon_code`, `global_currency_code`, `base_to_global_rate`, `base_to_quote_rate`, `customer_taxvat`, `customer_gender`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `is_changed`, `trigger_recollect`, `ext_shipping_info`, `gift_message_id`, `is_persistent`)
VALUES
	(1,1,'2013-08-15 01:41:30','2013-08-14 22:26:17',NULL,0,0,0,2,3.0000,0,1.0000,1.0000,'LTL','LTL','LTL',24.0000,24.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'sadfasdf',NULL,'asdfasdf',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,24.0000,24.0000,24.0000,24.0000,1,1,NULL,NULL,0),
	(2,1,'2013-08-14 22:25:41','2013-08-14 22:25:41',NULL,1,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'sadfasdf',NULL,'asdfasdf',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,NULL,0),
	(3,1,'2013-08-15 20:13:21','2013-08-15 20:13:23',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(4,1,'2013-08-15 20:13:23','2013-08-15 20:13:23',NULL,1,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,NULL,0),
	(5,1,'2013-08-15 21:03:10','2013-08-15 21:26:00',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(6,1,'2013-08-15 21:40:19','2013-08-15 21:42:03',NULL,0,0,0,2,2.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(7,1,'2013-08-15 21:46:24','2013-08-15 22:50:56',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(8,1,'2013-08-15 22:52:31','2013-08-15 23:17:58',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(9,1,'2013-08-15 23:18:22','2013-08-15 23:19:00',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(10,1,'2013-08-15 23:22:57','2013-08-15 23:30:49',NULL,0,0,0,1,2.0000,0,1.0000,1.0000,'LTL','LTL','LTL',28.0000,28.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,28.0000,28.0000,28.0000,28.0000,1,0,NULL,NULL,0),
	(11,1,'2013-08-15 23:31:07','2013-08-15 23:31:21',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(12,1,'2013-08-15 23:33:01','2013-08-15 23:33:09',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(13,1,'2013-08-15 23:33:27','2013-08-15 23:33:34',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(14,1,'2013-08-15 23:34:28','2013-08-15 23:34:29',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(15,1,'2013-08-15 23:34:49','2013-08-15 23:34:57',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',15.0000,15.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,15.0000,15.0000,15.0000,15.0000,1,0,NULL,NULL,0),
	(16,1,'2013-08-15 23:35:19','2013-08-15 23:35:26',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(17,1,'2013-08-15 23:37:17','2013-08-15 23:37:25',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(18,1,'2013-08-15 23:39:30','2013-08-15 23:39:45',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(19,1,'2013-08-15 23:39:59','2013-08-15 23:40:08',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(20,1,'2013-08-15 23:40:23','2013-08-15 23:40:32',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',15.0000,15.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,15.0000,15.0000,15.0000,15.0000,1,0,NULL,NULL,0),
	(21,1,'2013-08-19 21:03:56','2013-08-19 21:03:57',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(22,1,'2013-08-19 21:08:08','2013-08-19 21:08:10',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(23,1,'2013-08-19 21:08:33','2013-08-19 21:08:34',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,NULL,3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(24,1,'2013-08-19 21:08:47','2013-08-19 21:09:25',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(25,1,'2013-08-19 21:10:37','2013-08-19 21:31:15',NULL,0,0,0,1,5.0000,0,1.0000,1.0000,'LTL','LTL','LTL',70.0000,70.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,70.0000,70.0000,70.0000,70.0000,1,0,NULL,NULL,0),
	(26,1,'2013-08-19 21:33:52','2013-08-19 21:33:55',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(27,1,'2013-08-19 21:35:45','2013-08-19 21:35:47',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(28,1,'2013-08-19 21:36:45','2013-08-19 21:36:56',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(29,1,'2013-08-19 21:37:10','2013-08-19 21:37:19',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',15.0000,15.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,15.0000,15.0000,15.0000,15.0000,1,0,NULL,NULL,0),
	(30,1,'2013-08-19 21:37:32','2013-08-19 21:37:40',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(31,1,'2013-08-19 21:37:56','2013-08-19 21:44:22',NULL,0,0,0,2,2.0000,0,1.0000,1.0000,'LTL','LTL','LTL',15.0000,15.0000,NULL,1,3,1,'ddd@MAIL.COM',NULL,'Asmuo',NULL,'Asmenaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,15.0000,15.0000,15.0000,15.0000,1,0,NULL,NULL,0),
	(32,1,'2013-08-20 20:23:02','2013-08-20 20:23:04',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(33,1,'2013-08-20 20:55:19','2013-08-20 20:55:40',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(34,1,'2013-08-20 21:46:16','2013-08-20 21:46:29',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(35,1,'2013-08-21 21:25:07','2013-08-21 21:25:09',NULL,0,0,0,0,0.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(36,1,'2013-08-21 22:16:26','2013-08-21 22:16:58',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(37,1,'2013-08-21 22:51:01','2013-08-21 22:59:20',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(38,1,'2013-08-23 23:15:13','2013-08-23 23:17:12',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',0.0000,0.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,1,0,NULL,NULL,0),
	(39,1,'2013-08-24 13:42:32','2013-08-24 13:42:47',NULL,0,0,0,1,1.0000,0,1.0000,1.0000,'LTL','LTL','LTL',14.0000,14.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,14.0000,14.0000,14.0000,14.0000,1,0,NULL,NULL,0),
	(40,1,'2013-08-24 13:56:20','2013-08-24 14:06:21',NULL,0,0,0,3,3.0000,0,1.0000,1.0000,'LTL','LTL','LTL',28.0000,28.0000,NULL,2,3,1,'email@mail.com',NULL,'Imonius',NULL,'Imonaitis',NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,'LTL',1.0000,1.0000,NULL,NULL,28.0000,28.0000,28.0000,28.0000,1,0,NULL,NULL,0);

/*!40000 ALTER TABLE `mg_sales_flat_quote` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_flat_quote_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_address`;

CREATE TABLE `mg_sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_MG_SALES_FLAT_QUOTE_ADDR_QUOTE_ID_MG_SALES_FLAT_QUOTE_ENTT_ID` FOREIGN KEY (`quote_id`) REFERENCES `mg_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';

LOCK TABLES `mg_sales_flat_quote_address` WRITE;
/*!40000 ALTER TABLE `mg_sales_flat_quote_address` DISABLE KEYS */;

INSERT INTO `mg_sales_flat_quote_address` (`address_id`, `quote_id`, `created_at`, `updated_at`, `customer_id`, `save_in_address_book`, `customer_address_id`, `address_type`, `email`, `prefix`, `firstname`, `middlename`, `lastname`, `suffix`, `company`, `street`, `city`, `region`, `region_id`, `postcode`, `country_id`, `telephone`, `fax`, `same_as_billing`, `free_shipping`, `collect_shipping_rates`, `shipping_method`, `shipping_description`, `weight`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `tax_amount`, `base_tax_amount`, `shipping_amount`, `base_shipping_amount`, `shipping_tax_amount`, `base_shipping_tax_amount`, `discount_amount`, `base_discount_amount`, `grand_total`, `base_grand_total`, `customer_notes`, `applied_taxes`, `discount_description`, `shipping_discount_amount`, `base_shipping_discount_amount`, `subtotal_incl_tax`, `base_subtotal_total_incl_tax`, `hidden_tax_amount`, `base_hidden_tax_amount`, `shipping_hidden_tax_amount`, `base_shipping_hidden_tax_amnt`, `shipping_incl_tax`, `base_shipping_incl_tax`, `vat_id`, `vat_is_valid`, `vat_request_id`, `vat_request_date`, `vat_request_success`, `gift_message_id`)
VALUES
	(1,1,'2013-08-14 22:25:39','2013-08-14 22:26:17',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,24.0000,24.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,24.0000,24.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,24.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,1,'2013-08-14 22:25:39','2013-08-14 22:26:17',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,2,'2013-08-14 22:25:41','2013-08-14 22:25:41',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,3,'2013-08-15 20:13:21','2013-08-15 20:13:23',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,3,'2013-08-15 20:13:21','2013-08-15 20:13:23',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,4,'2013-08-15 20:13:23','2013-08-15 20:13:23',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,5,'2013-08-15 21:03:10','2013-08-15 21:26:00',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,5,'2013-08-15 21:03:10','2013-08-15 21:26:00',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,6,'2013-08-15 21:40:19','2013-08-15 21:42:03',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,6,'2013-08-15 21:40:19','2013-08-15 21:42:03',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,7,'2013-08-15 21:46:24','2013-08-15 22:50:56',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,7,'2013-08-15 21:46:24','2013-08-15 22:50:56',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,8,'2013-08-15 22:52:31','2013-08-15 23:17:58',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,8,'2013-08-15 22:52:31','2013-08-15 23:17:58',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,9,'2013-08-15 23:18:22','2013-08-15 23:19:00',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,9,'2013-08-15 23:18:22','2013-08-15 23:19:00',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,10,'2013-08-15 23:22:58','2013-08-15 23:30:49',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,28.0000,28.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,28.0000,28.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,28.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,10,'2013-08-15 23:22:58','2013-08-15 23:30:49',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,11,'2013-08-15 23:31:07','2013-08-15 23:31:21',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,11,'2013-08-15 23:31:07','2013-08-15 23:31:21',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,12,'2013-08-15 23:33:01','2013-08-15 23:33:09',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,12,'2013-08-15 23:33:01','2013-08-15 23:33:09',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,13,'2013-08-15 23:33:27','2013-08-15 23:33:34',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(24,13,'2013-08-15 23:33:27','2013-08-15 23:33:34',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,14,'2013-08-15 23:34:28','2013-08-15 23:34:29',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(26,14,'2013-08-15 23:34:28','2013-08-15 23:34:29',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(27,15,'2013-08-15 23:34:49','2013-08-15 23:34:57',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,15.0000,15.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,15.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,15,'2013-08-15 23:34:49','2013-08-15 23:34:57',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(29,16,'2013-08-15 23:35:19','2013-08-15 23:35:26',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(30,16,'2013-08-15 23:35:19','2013-08-15 23:35:26',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(31,17,'2013-08-15 23:37:17','2013-08-15 23:37:25',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,17,'2013-08-15 23:37:17','2013-08-15 23:37:25',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,18,'2013-08-15 23:39:30','2013-08-15 23:39:45',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(34,18,'2013-08-15 23:39:30','2013-08-15 23:39:45',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,19,'2013-08-15 23:39:59','2013-08-15 23:40:08',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(36,19,'2013-08-15 23:39:59','2013-08-15 23:40:08',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(37,20,'2013-08-15 23:40:23','2013-08-15 23:40:32',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,15.0000,15.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,15.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(38,20,'2013-08-15 23:40:23','2013-08-15 23:40:32',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(39,21,'2013-08-19 21:03:56','2013-08-19 21:03:57',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(40,21,'2013-08-19 21:03:56','2013-08-19 21:03:57',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(41,22,'2013-08-19 21:08:08','2013-08-19 21:08:10',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(42,22,'2013-08-19 21:08:08','2013-08-19 21:08:10',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(43,23,'2013-08-19 21:08:33','2013-08-19 21:08:34',NULL,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(44,23,'2013-08-19 21:08:33','2013-08-19 21:08:34',NULL,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(45,24,'2013-08-19 21:08:47','2013-08-19 21:09:25',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(46,24,'2013-08-19 21:08:47','2013-08-19 21:09:25',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,25,'2013-08-19 21:10:37','2013-08-19 21:31:15',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,70.0000,70.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,70.0000,70.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,70.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(48,25,'2013-08-19 21:10:37','2013-08-19 21:31:15',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(49,26,'2013-08-19 21:33:52','2013-08-19 21:33:55',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(50,26,'2013-08-19 21:33:52','2013-08-19 21:33:55',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,27,'2013-08-19 21:35:46','2013-08-19 21:35:47',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(52,27,'2013-08-19 21:35:46','2013-08-19 21:35:47',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(53,28,'2013-08-19 21:36:45','2013-08-19 21:36:56',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(54,28,'2013-08-19 21:36:45','2013-08-19 21:36:56',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(55,29,'2013-08-19 21:37:10','2013-08-19 21:37:19',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,15.0000,15.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,15.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(56,29,'2013-08-19 21:37:10','2013-08-19 21:37:19',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(57,30,'2013-08-19 21:37:33','2013-08-19 21:37:40',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(58,30,'2013-08-19 21:37:33','2013-08-19 21:37:40',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(59,31,'2013-08-19 21:37:56','2013-08-19 21:44:22',1,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,15.0000,15.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,15.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(60,31,'2013-08-19 21:37:56','2013-08-19 21:44:23',1,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(61,32,'2013-08-20 20:23:03','2013-08-20 20:23:04',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(62,32,'2013-08-20 20:23:03','2013-08-20 20:23:04',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(63,33,'2013-08-20 20:55:19','2013-08-20 20:55:40',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(64,33,'2013-08-20 20:55:19','2013-08-20 20:55:40',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(65,34,'2013-08-20 21:46:17','2013-08-20 21:46:29',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(66,34,'2013-08-20 21:46:17','2013-08-20 21:46:29',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(67,35,'2013-08-21 21:25:07','2013-08-21 21:25:09',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(68,35,'2013-08-21 21:25:07','2013-08-21 21:25:09',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(69,36,'2013-08-21 22:16:26','2013-08-21 22:16:58',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(70,36,'2013-08-21 22:16:26','2013-08-21 22:16:58',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(71,37,'2013-08-21 22:51:01','2013-08-21 22:59:20',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(72,37,'2013-08-21 22:51:01','2013-08-21 22:59:20',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(73,38,'2013-08-23 23:15:14','2013-08-23 23:17:12',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(74,38,'2013-08-23 23:15:14','2013-08-23 23:17:12',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(75,39,'2013-08-24 13:42:32','2013-08-24 13:42:47',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,14.0000,14.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,14.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(76,39,'2013-08-24 13:42:32','2013-08-24 13:42:47',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(77,40,'2013-08-24 13:56:21','2013-08-24 14:06:21',2,0,NULL,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,0.0000,28.0000,28.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,28.0000,28.0000,NULL,'a:0:{}',NULL,0.0000,0.0000,28.0000,NULL,0.0000,0.0000,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL),
	(78,40,'2013-08-24 13:56:21','2013-08-24 14:06:21',2,0,NULL,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'a:0:{}',NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_sales_flat_quote_address` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_flat_quote_address_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_address_item`;

CREATE TABLE `mg_sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `FK_4C1146A013B0DCEA37C0E62B31FC3239` FOREIGN KEY (`quote_item_id`) REFERENCES `mg_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_6BCC931EBBF202977F2D359127EEF2C6` FOREIGN KEY (`parent_item_id`) REFERENCES `mg_sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_FB0643954A7EEB64340BD9AA3E8471B4` FOREIGN KEY (`quote_address_id`) REFERENCES `mg_sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';



# Dump of table mg_sales_flat_quote_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_item`;

CREATE TABLE `mg_sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_A9FB1A2DC36FE6685F59E13CEB9087D9` FOREIGN KEY (`parent_item_id`) REFERENCES `mg_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_QUOTE_ITEM_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_QUOTE_ITEM_QUOTE_ID_MG_SALES_FLAT_QUOTE_ENTT_ID` FOREIGN KEY (`quote_id`) REFERENCES `mg_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_QUOTE_ITEM_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';

LOCK TABLES `mg_sales_flat_quote_item` WRITE;
/*!40000 ALTER TABLE `mg_sales_flat_quote_item` DISABLE KEYS */;

INSERT INTO `mg_sales_flat_quote_item` (`item_id`, `quote_id`, `created_at`, `updated_at`, `product_id`, `store_id`, `parent_item_id`, `is_virtual`, `sku`, `name`, `description`, `applied_rule_ids`, `additional_data`, `free_shipping`, `is_qty_decimal`, `no_discount`, `weight`, `qty`, `price`, `base_price`, `custom_price`, `discount_percent`, `discount_amount`, `base_discount_amount`, `tax_percent`, `tax_amount`, `base_tax_amount`, `row_total`, `base_row_total`, `row_total_with_discount`, `row_weight`, `product_type`, `base_tax_before_discount`, `tax_before_discount`, `original_custom_price`, `redirect_url`, `base_cost`, `price_incl_tax`, `base_price_incl_tax`, `row_total_incl_tax`, `base_row_total_incl_tax`, `hidden_tax_amount`, `base_hidden_tax_amount`, `gift_message_id`, `weee_tax_disposition`, `weee_tax_row_disposition`, `base_weee_tax_disposition`, `base_weee_tax_row_disposition`, `weee_tax_applied`, `weee_tax_applied_amount`, `weee_tax_applied_row_amount`, `base_weee_tax_applied_amount`, `base_weee_tax_applied_row_amnt`)
VALUES
	(1,1,'2013-08-14 22:26:17','2013-08-14 22:26:17',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(2,1,'2013-08-14 22:26:17','2013-08-14 22:26:17',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,2.0000,12.0000,12.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,24.0000,24.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,12.0000,12.0000,24.0000,24.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(4,5,'2013-08-15 21:14:04','2013-08-15 21:14:04',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(5,6,'2013-08-15 21:41:51','2013-08-15 21:41:51',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(6,6,'2013-08-15 21:42:03','2013-08-15 21:42:03',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(17,7,'2013-08-15 22:50:56','2013-08-15 22:50:56',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(20,9,'2013-08-15 23:19:00','2013-08-15 23:19:00',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(21,10,'2013-08-15 23:23:05','2013-08-15 23:30:49',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,2.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,28.0000,28.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,28.0000,28.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(22,11,'2013-08-15 23:31:21','2013-08-15 23:31:21',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(23,12,'2013-08-15 23:33:09','2013-08-15 23:33:09',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(24,13,'2013-08-15 23:33:34','2013-08-15 23:33:34',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(25,15,'2013-08-15 23:34:57','2013-08-15 23:34:57',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,15.0000,15.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,15.0000,15.0000,15.0000,15.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(26,16,'2013-08-15 23:35:26','2013-08-15 23:35:26',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(27,17,'2013-08-15 23:37:25','2013-08-15 23:37:25',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(29,19,'2013-08-15 23:40:08','2013-08-15 23:40:08',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(30,20,'2013-08-15 23:40:32','2013-08-15 23:40:32',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,15.0000,15.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,15.0000,15.0000,15.0000,15.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(32,25,'2013-08-19 21:10:46','2013-08-19 21:31:15',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,5.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,70.0000,70.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,70.0000,70.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(33,28,'2013-08-19 21:36:56','2013-08-19 21:36:56',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(34,29,'2013-08-19 21:37:19','2013-08-19 21:37:19',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,15.0000,15.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,15.0000,15.0000,15.0000,15.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(35,30,'2013-08-19 21:37:40','2013-08-19 21:37:40',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(36,31,'2013-08-19 21:38:04','2013-08-19 21:38:04',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(37,31,'2013-08-19 21:44:23','2013-08-19 21:44:23',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,15.0000,15.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.0000,15.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,15.0000,15.0000,15.0000,15.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(38,33,'2013-08-20 20:55:40','2013-08-20 20:55:40',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(39,34,'2013-08-20 21:46:29','2013-08-20 21:46:29',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(40,36,'2013-08-21 22:16:58','2013-08-21 22:16:58',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(41,37,'2013-08-21 22:51:11','2013-08-21 22:51:11',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(42,38,'2013-08-23 23:17:12','2013-08-23 23:17:12',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(43,39,'2013-08-24 13:42:47','2013-08-24 13:42:47',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(47,40,'2013-08-24 14:04:57','2013-08-24 14:04:57',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(48,40,'2013-08-24 14:06:12','2013-08-24 14:06:12',3,1,NULL,0,NULL,'Kuro filtras',NULL,NULL,NULL,0,0,0,NULL,1.0000,14.0000,14.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.0000,14.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,14.0000,14.0000,14.0000,14.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL),
	(49,40,'2013-08-24 14:06:21','2013-08-24 14:06:21',2,1,NULL,0,NULL,'Jonas',NULL,NULL,NULL,0,0,0,NULL,1.0000,0.0000,0.0000,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'simple',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,'a:0:{}',0.0000,0.0000,0.0000,NULL);

/*!40000 ALTER TABLE `mg_sales_flat_quote_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_flat_quote_item_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_item_option`;

CREATE TABLE `mg_sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_ECBBA2B10ACCAFA3FA3D5C4BD768DCD8` FOREIGN KEY (`item_id`) REFERENCES `mg_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';

LOCK TABLES `mg_sales_flat_quote_item_option` WRITE;
/*!40000 ALTER TABLE `mg_sales_flat_quote_item_option` DISABLE KEYS */;

INSERT INTO `mg_sales_flat_quote_item_option` (`option_id`, `item_id`, `product_id`, `code`, `value`)
VALUES
	(1,1,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(2,2,3,'info_buyRequest','a:1:{s:3:\"qty\";i:2;}'),
	(4,4,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(5,5,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(6,6,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(17,17,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(20,20,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(21,21,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(22,22,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(23,23,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(24,24,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(25,25,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(26,26,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(27,27,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(29,29,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(30,30,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(32,32,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(33,33,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(34,34,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(35,35,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(36,36,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(37,37,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(38,38,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(39,39,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(40,40,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(41,41,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(42,42,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(43,42,0,'',NULL),
	(44,43,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(45,43,0,'percent','30'),
	(52,47,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(53,47,3,'percent','30'),
	(54,48,3,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(55,48,3,'percent','30'),
	(56,49,2,'info_buyRequest','a:1:{s:3:\"qty\";i:1;}'),
	(57,49,0,'percent','30');

/*!40000 ALTER TABLE `mg_sales_flat_quote_item_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_flat_quote_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_payment`;

CREATE TABLE `mg_sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_E3EE0976D8F01C00DA44F7F41E1E2797` FOREIGN KEY (`quote_id`) REFERENCES `mg_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';

LOCK TABLES `mg_sales_flat_quote_payment` WRITE;
/*!40000 ALTER TABLE `mg_sales_flat_quote_payment` DISABLE KEYS */;

INSERT INTO `mg_sales_flat_quote_payment` (`payment_id`, `quote_id`, `created_at`, `updated_at`, `method`, `cc_type`, `cc_number_enc`, `cc_last4`, `cc_cid_enc`, `cc_owner`, `cc_exp_month`, `cc_exp_year`, `cc_ss_owner`, `cc_ss_start_month`, `cc_ss_start_year`, `po_number`, `additional_data`, `cc_ss_issue`, `additional_information`, `paypal_payer_id`, `paypal_payer_status`, `paypal_correlation_id`)
VALUES
	(1,1,'2013-08-14 22:25:39','2013-08-14 22:26:17','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,3,'2013-08-15 20:13:21','2013-08-15 20:13:23','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,5,'2013-08-15 21:03:10','2013-08-15 21:14:04','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,6,'2013-08-15 21:40:19','2013-08-15 21:41:51','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,7,'2013-08-15 21:46:24','2013-08-15 22:50:56','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,8,'2013-08-15 22:52:31','2013-08-15 23:17:58','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,9,'2013-08-15 23:18:22','2013-08-15 23:19:00','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,10,'2013-08-15 23:22:58','2013-08-15 23:30:49','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,11,'2013-08-15 23:31:07','2013-08-15 23:31:21','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,12,'2013-08-15 23:33:01','2013-08-15 23:33:09','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,13,'2013-08-15 23:33:27','2013-08-15 23:33:34','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,14,'2013-08-15 23:34:28','2013-08-15 23:34:29','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,15,'2013-08-15 23:34:49','2013-08-15 23:34:57','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,16,'2013-08-15 23:35:19','2013-08-15 23:35:26','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,17,'2013-08-15 23:37:17','2013-08-15 23:37:25','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,18,'2013-08-15 23:39:30','2013-08-15 23:39:38','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,19,'2013-08-15 23:39:59','2013-08-15 23:40:08','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,20,'2013-08-15 23:40:23','2013-08-15 23:40:32','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,21,'2013-08-19 21:03:56','2013-08-19 21:03:57','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,22,'2013-08-19 21:08:08','2013-08-19 21:08:10','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,23,'2013-08-19 21:08:33','2013-08-19 21:08:34','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,24,'2013-08-19 21:08:47','2013-08-19 21:08:56','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,25,'2013-08-19 21:10:37','2013-08-19 21:10:46','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(24,26,'2013-08-19 21:33:52','2013-08-19 21:33:55','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,27,'2013-08-19 21:35:46','2013-08-19 21:35:47','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(26,28,'2013-08-19 21:36:45','2013-08-19 21:36:56','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(27,29,'2013-08-19 21:37:10','2013-08-19 21:37:19','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,30,'2013-08-19 21:37:33','2013-08-19 21:37:40','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(29,31,'2013-08-19 21:37:56','2013-08-19 21:44:23','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(30,32,'2013-08-20 20:23:03','2013-08-20 20:23:04','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(31,33,'2013-08-20 20:55:19','2013-08-20 20:55:40','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,34,'2013-08-20 21:46:17','2013-08-20 21:46:29','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,35,'2013-08-21 21:25:07','2013-08-21 21:25:09','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(34,36,'2013-08-21 22:16:26','2013-08-21 22:16:59','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,37,'2013-08-21 22:51:01','2013-08-21 22:51:11','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(36,38,'2013-08-23 23:15:14','2013-08-23 23:17:12','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(37,39,'2013-08-24 13:42:32','2013-08-24 13:42:47','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(38,40,'2013-08-24 13:56:21','2013-08-24 14:04:57','free',NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_sales_flat_quote_payment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_flat_quote_shipping_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_quote_shipping_rate`;

CREATE TABLE `mg_sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_MG_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `FK_1EA40552D6118DEBE72CD1A977F10250` FOREIGN KEY (`address_id`) REFERENCES `mg_sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';



# Dump of table mg_sales_flat_shipment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_shipment`;

CREATE TABLE `mg_sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_MG_SALES_FLAT_SHIPMENT_ORDER_ID_MG_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_SHIPMENT_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';



# Dump of table mg_sales_flat_shipment_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_shipment_comment`;

CREATE TABLE `mg_sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_50AD2F74A813C72D878226A41CB7989F` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';



# Dump of table mg_sales_flat_shipment_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_shipment_grid`;

CREATE TABLE `mg_sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MG_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  CONSTRAINT `FK_D538984C71D0C56EC8D21F7F38ADC170` FOREIGN KEY (`entity_id`) REFERENCES `mg_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_FLAT_SHIPMENT_GRID_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';



# Dump of table mg_sales_flat_shipment_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_shipment_item`;

CREATE TABLE `mg_sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_D9ED52874692ED77BE31E0FD424D52E0` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';



# Dump of table mg_sales_flat_shipment_track
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_flat_shipment_track`;

CREATE TABLE `mg_sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_0E83429825C66E9BC666C188373BBC1B` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';



# Dump of table mg_sales_invoiced_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_invoiced_aggregated`;

CREATE TABLE `mg_sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_INVOICED_AGGREGATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';



# Dump of table mg_sales_invoiced_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_invoiced_aggregated_order`;

CREATE TABLE `mg_sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_INVOICED_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_7FDC82E7477512A5A05B533896C5319E` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';



# Dump of table mg_sales_order_aggregated_created
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_aggregated_created`;

CREATE TABLE `mg_sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_ORDER_AGGRED_CREATED_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_ORDER_AGGRED_CREATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';



# Dump of table mg_sales_order_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_aggregated_updated`;

CREATE TABLE `mg_sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_ORDER_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_ORDER_AGGRED_UPDATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mg Sales Order Aggregated Updated';



# Dump of table mg_sales_order_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_status`;

CREATE TABLE `mg_sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

LOCK TABLES `mg_sales_order_status` WRITE;
/*!40000 ALTER TABLE `mg_sales_order_status` DISABLE KEYS */;

INSERT INTO `mg_sales_order_status` (`status`, `label`)
VALUES
	('canceled','Canceled'),
	('closed','Closed'),
	('complete','Complete'),
	('fraud','Suspected Fraud'),
	('holded','On Hold'),
	('payment_review','Payment Review'),
	('pending','Pending'),
	('pending_payment','Pending Payment'),
	('pending_paypal','Pending PayPal'),
	('processing','Processing');

/*!40000 ALTER TABLE `mg_sales_order_status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_order_status_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_status_label`;

CREATE TABLE `mg_sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_MG_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_ORDER_STATUS_LABEL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_ORDER_STS_LBL_STS_MG_SALES_ORDER_STS_STS` FOREIGN KEY (`status`) REFERENCES `mg_sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';



# Dump of table mg_sales_order_status_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_status_state`;

CREATE TABLE `mg_sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `FK_MG_SALES_ORDER_STS_STATE_STS_MG_SALES_ORDER_STS_STS` FOREIGN KEY (`status`) REFERENCES `mg_sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

LOCK TABLES `mg_sales_order_status_state` WRITE;
/*!40000 ALTER TABLE `mg_sales_order_status_state` DISABLE KEYS */;

INSERT INTO `mg_sales_order_status_state` (`status`, `state`, `is_default`)
VALUES
	('canceled','canceled',1),
	('closed','closed',1),
	('complete','complete',1),
	('fraud','payment_review',0),
	('holded','holded',1),
	('payment_review','payment_review',1),
	('pending','new',1),
	('pending_payment','pending_payment',1),
	('processing','processing',1);

/*!40000 ALTER TABLE `mg_sales_order_status_state` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_sales_order_tax
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_tax`;

CREATE TABLE `mg_sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_MG_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';



# Dump of table mg_sales_order_tax_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_order_tax_item`;

CREATE TABLE `mg_sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_MG_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_MG_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_MG_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_78865D45F16B96BA5664E53F070FBB6F` FOREIGN KEY (`item_id`) REFERENCES `mg_sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_ORDER_TAX_ITEM_TAX_ID_MG_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `mg_sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';



# Dump of table mg_sales_payment_transaction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_payment_transaction`;

CREATE TABLE `mg_sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_MG_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_MG_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_MG_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_MG_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_79BC39932E1D0C2FACF4F68AFC0ADE89` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_C06950956E5B7800FEA8C79B9829366A` FOREIGN KEY (`payment_id`) REFERENCES `mg_sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DBC36626E185E30AB299A4F902A37036` FOREIGN KEY (`parent_id`) REFERENCES `mg_sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';



# Dump of table mg_sales_recurring_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_recurring_profile`;

CREATE TABLE `mg_sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_MG_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_MG_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_RECURRING_PROFILE_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALES_RECURRING_PROFILE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile';



# Dump of table mg_sales_recurring_profile_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_recurring_profile_order`;

CREATE TABLE `mg_sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MG_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_MG_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_5AD359FFD1B730214227742897EB0F04` FOREIGN KEY (`order_id`) REFERENCES `mg_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_AE6786939BEDDC7C41204928BF53D5D7` FOREIGN KEY (`profile_id`) REFERENCES `mg_sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order';



# Dump of table mg_sales_refunded_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_refunded_aggregated`;

CREATE TABLE `mg_sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_REFUNDED_AGGREGATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';



# Dump of table mg_sales_refunded_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_refunded_aggregated_order`;

CREATE TABLE `mg_sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MG_SALES_REFUNDED_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MG_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_ADA65BC7A91F771E9395CD1012CDF2AD` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';



# Dump of table mg_sales_shipping_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_shipping_aggregated`;

CREATE TABLE `mg_sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `01510D7BAD92162CADEDC6961AC1B60A` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_MG_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_SHIPPING_AGGREGATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';



# Dump of table mg_sales_shipping_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sales_shipping_aggregated_order`;

CREATE TABLE `mg_sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `2F05DEC97D704DCC8AAEA9140E6202CF` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_MG_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SALES_SHPP_AGGRED_ORDER_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';



# Dump of table mg_salesrule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule`;

CREATE TABLE `mg_salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MG_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';



# Dump of table mg_salesrule_coupon
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_coupon`;

CREATE TABLE `mg_salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_MG_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_MG_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_MG_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_MG_SALESRULE_COUPON_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';



# Dump of table mg_salesrule_coupon_usage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_coupon_usage`;

CREATE TABLE `mg_salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_MG_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_MG_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_AA86A62AD7748CE6E698463B3B55410B` FOREIGN KEY (`coupon_id`) REFERENCES `mg_salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALESRULE_COUPON_USAGE_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';



# Dump of table mg_salesrule_customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_customer`;

CREATE TABLE `mg_salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_MG_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_MG_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `FK_MG_SALESRULE_CSTR_CSTR_ID_MG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALESRULE_CUSTOMER_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';



# Dump of table mg_salesrule_customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_customer_group`;

CREATE TABLE `mg_salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_MG_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_MG_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_A1922381C1A4656E87C084376ADABA51` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALESRULE_CUSTOMER_GROUP_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';



# Dump of table mg_salesrule_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_label`;

CREATE TABLE `mg_salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_MG_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_MG_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_MG_SALESRULE_LABEL_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_MG_SALESRULE_LABEL_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALESRULE_LABEL_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';



# Dump of table mg_salesrule_product_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_product_attribute`;

CREATE TABLE `mg_salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_MG_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MG_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_FB6F0E141326644713448A6488F1365C` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_SALESRULE_PRD_ATTR_ATTR_ID_MG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_SALESRULE_PRD_ATTR_WS_ID_MG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';



# Dump of table mg_salesrule_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_salesrule_website`;

CREATE TABLE `mg_salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_MG_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MG_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MG_SALESRULE_WEBSITE_RULE_ID_MG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mg_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_SALESRULE_WEBSITE_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';



# Dump of table mg_sendfriend_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sendfriend_log`;

CREATE TABLE `mg_sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_MG_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_MG_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';



# Dump of table mg_shipping_tablerate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_shipping_tablerate`;

CREATE TABLE `mg_shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `24C5BFAC7AC50711F0FDC69DF46D7286` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';



# Dump of table mg_sitemap
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_sitemap`;

CREATE TABLE `mg_sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_MG_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_SITEMAP_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap';



# Dump of table mg_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tag`;

CREATE TABLE `mg_tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_MG_TAG_FIRST_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_MG_TAG_FIRST_STORE_ID_MG_CORE_STORE_STORE_ID` (`first_store_id`),
  CONSTRAINT `FK_MG_TAG_FIRST_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_MG_TAG_FIRST_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag';



# Dump of table mg_tag_properties
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tag_properties`;

CREATE TABLE `mg_tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_MG_TAG_PROPERTIES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_TAG_PROPERTIES_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAG_PROPERTIES_TAG_ID_MG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mg_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';



# Dump of table mg_tag_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tag_relation`;

CREATE TABLE `mg_tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_MG_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_MG_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_MG_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_TAG_RELATION_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_TAG_RELATION_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAG_RELATION_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAG_RELATION_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAG_RELATION_TAG_ID_MG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mg_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Relation';



# Dump of table mg_tag_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tag_summary`;

CREATE TABLE `mg_tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_MG_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_MG_TAG_SUMMARY_TAG_ID` (`tag_id`),
  CONSTRAINT `FK_MG_TAG_SUMMARY_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAG_SUMMARY_TAG_ID_MG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mg_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';



# Dump of table mg_tax_calculation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_calculation`;

CREATE TABLE `mg_tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_MG_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_MG_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_MG_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_MG_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `D41E1E1C7864EE3C619CFC0240A91E8D` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `FK_210C9E4DF73AB75B727E8BD7C6823BCF` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `mg_tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_D5ADAC9C26DE49214A704FCD9746A9A9` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `mg_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_MG_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `mg_tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAX_CALC_CSTR_TAX_CLASS_ID_MG_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `mg_tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';

LOCK TABLES `mg_tax_calculation` WRITE;
/*!40000 ALTER TABLE `mg_tax_calculation` DISABLE KEYS */;

INSERT INTO `mg_tax_calculation` (`tax_calculation_id`, `tax_calculation_rate_id`, `tax_calculation_rule_id`, `customer_tax_class_id`, `product_tax_class_id`)
VALUES
	(1,1,1,3,2),
	(2,2,1,3,2);

/*!40000 ALTER TABLE `mg_tax_calculation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_tax_calculation_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_calculation_rate`;

CREATE TABLE `mg_tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_MG_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_MG_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `CCA86D7F60DE4DB9AA7FE619BA73E321` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';

LOCK TABLES `mg_tax_calculation_rate` WRITE;
/*!40000 ALTER TABLE `mg_tax_calculation_rate` DISABLE KEYS */;

INSERT INTO `mg_tax_calculation_rate` (`tax_calculation_rate_id`, `tax_country_id`, `tax_region_id`, `tax_postcode`, `code`, `rate`, `zip_is_range`, `zip_from`, `zip_to`)
VALUES
	(1,'US',12,'*','US-CA-*-Rate 1',8.2500,NULL,NULL,NULL),
	(2,'US',43,'*','US-NY-*-Rate 1',8.3750,NULL,NULL,NULL),
	(3,'LT',0,'*','PVM',21.0000,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mg_tax_calculation_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_tax_calculation_rate_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_calculation_rate_title`;

CREATE TABLE `mg_tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_MG_TAX_CALC_RATE_TTL_TAX_CALC_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_MG_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_MG_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B3F89DCF0C5B43C5641DFF2A044C0BEA` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `mg_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_TAX_CALCULATION_RATE_TITLE_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';



# Dump of table mg_tax_calculation_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_calculation_rule`;

CREATE TABLE `mg_tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_MG_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_MG_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';

LOCK TABLES `mg_tax_calculation_rule` WRITE;
/*!40000 ALTER TABLE `mg_tax_calculation_rule` DISABLE KEYS */;

INSERT INTO `mg_tax_calculation_rule` (`tax_calculation_rule_id`, `code`, `priority`, `position`)
VALUES
	(1,'Retail Customer-Taxable Goods-Rate 1',1,1);

/*!40000 ALTER TABLE `mg_tax_calculation_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_tax_class
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_class`;

CREATE TABLE `mg_tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Class';

LOCK TABLES `mg_tax_class` WRITE;
/*!40000 ALTER TABLE `mg_tax_class` DISABLE KEYS */;

INSERT INTO `mg_tax_class` (`class_id`, `class_name`, `class_type`)
VALUES
	(2,'Taxable Goods','PRODUCT'),
	(3,'Retail Customer','CUSTOMER'),
	(4,'Shipping','PRODUCT'),
	(5,'PVM','PRODUCT');

/*!40000 ALTER TABLE `mg_tax_class` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_tax_order_aggregated_created
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_order_aggregated_created`;

CREATE TABLE `mg_tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `8B6479C64CB72174486393DFC6709D0D` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_MG_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_TAX_ORDER_AGGRED_CREATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';



# Dump of table mg_tax_order_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_tax_order_aggregated_updated`;

CREATE TABLE `mg_tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `BC3FBF6C5EAB506C2B2655E6F079B2F2` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_MG_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_TAX_ORDER_AGGRED_UPDATED_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mg Tax Order Aggregated Updated';



# Dump of table mg_weee_discount
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_weee_discount`;

CREATE TABLE `mg_weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_MG_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_MG_WEEE_DISCOUNT_CSTR_GROUP_ID_MG_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `mg_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WEEE_DISCOUNT_ENTT_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WEEE_DISCOUNT_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';



# Dump of table mg_weee_tax
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_weee_tax`;

CREATE TABLE `mg_weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MG_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MG_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MG_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_MG_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MG_WEEE_TAX_ATTRIBUTE_ID_MG_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mg_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WEEE_TAX_COUNTRY_MG_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `mg_directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WEEE_TAX_ENTITY_ID_MG_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WEEE_TAX_WEBSITE_ID_MG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mg_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';



# Dump of table mg_widget
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_widget`;

CREATE TABLE `mg_widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_MG_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';



# Dump of table mg_widget_instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_widget_instance`;

CREATE TABLE `mg_widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';



# Dump of table mg_widget_instance_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_widget_instance_page`;

CREATE TABLE `mg_widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_MG_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `FK_68AC700EE56C18FF6C12FBB0E6486BEF` FOREIGN KEY (`instance_id`) REFERENCES `mg_widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';



# Dump of table mg_widget_instance_page_layout
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_widget_instance_page_layout`;

CREATE TABLE `mg_widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_MG_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_MG_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_MG_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_10B3A671EF73F604D71271B76E3B6EBD` FOREIGN KEY (`layout_update_id`) REFERENCES `mg_core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A9220BD2C9A049E331807813978C1461` FOREIGN KEY (`page_id`) REFERENCES `mg_widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';



# Dump of table mg_wishlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_wishlist`;

CREATE TABLE `mg_wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `UNQ_MG_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MG_WISHLIST_SHARED` (`shared`),
  CONSTRAINT `FK_MG_WISHLIST_CUSTOMER_ID_MG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mg_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';

LOCK TABLES `mg_wishlist` WRITE;
/*!40000 ALTER TABLE `mg_wishlist` DISABLE KEYS */;

INSERT INTO `mg_wishlist` (`wishlist_id`, `customer_id`, `shared`, `sharing_code`, `updated_at`)
VALUES
	(1,1,0,'19bc415b690dc25f7ad46126f1fa4cea','2013-08-14 22:25:41'),
	(2,2,0,'daa92b6e6c5b9096295991b8ecbe397f','2013-08-15 20:13:23');

/*!40000 ALTER TABLE `mg_wishlist` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mg_wishlist_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_wishlist_item`;

CREATE TABLE `mg_wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_MG_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_MG_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MG_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MG_WISHLIST_ITEM_PRD_ID_MG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mg_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WISHLIST_ITEM_STORE_ID_MG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MG_WISHLIST_ITEM_WISHLIST_ID_MG_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `mg_wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';



# Dump of table mg_wishlist_item_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_wishlist_item_option`;

CREATE TABLE `mg_wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_52740CF0FD0849C46ABC912037133550` (`wishlist_item_id`),
  CONSTRAINT `FK_52740CF0FD0849C46ABC912037133550` FOREIGN KEY (`wishlist_item_id`) REFERENCES `mg_wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';



# Dump of table mg_xmlconnect_application
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_xmlconnect_application`;

CREATE TABLE `mg_xmlconnect_application` (
  `application_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Application Id',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  `type` varchar(32) NOT NULL COMMENT 'Device Type',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `active_from` date DEFAULT NULL COMMENT 'Active From',
  `active_to` date DEFAULT NULL COMMENT 'Active To',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `browsing_mode` smallint(5) unsigned DEFAULT '0' COMMENT 'Browsing Mode',
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `UNQ_MG_MG_XMLCONNECT_APPLICATION_CODE` (`code`),
  KEY `FK_814443420C7DC25E68C1E7728E5F3D8A` (`store_id`),
  CONSTRAINT `FK_814443420C7DC25E68C1E7728E5F3D8A` FOREIGN KEY (`store_id`) REFERENCES `mg_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Application';



# Dump of table mg_xmlconnect_config_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_xmlconnect_config_data`;

CREATE TABLE `mg_xmlconnect_config_data` (
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `category` varchar(60) NOT NULL DEFAULT 'default' COMMENT 'Category',
  `path` varchar(250) NOT NULL COMMENT 'Path',
  `value` text NOT NULL COMMENT 'Value',
  UNIQUE KEY `UNQ_MG_MG_XMLCONNECT_CONFIG_DATA_APPLICATION_ID_CATEGORY_PATH` (`application_id`,`category`,`path`),
  CONSTRAINT `FK_6F2C508A2D00CCDA99C41C86E048A2B2` FOREIGN KEY (`application_id`) REFERENCES `mg_xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Configuration Data';



# Dump of table mg_xmlconnect_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_xmlconnect_history`;

CREATE TABLE `mg_xmlconnect_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `params` blob COMMENT 'Params',
  `title` varchar(200) NOT NULL COMMENT 'Title',
  `activation_key` varchar(255) NOT NULL COMMENT 'Activation Key',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  PRIMARY KEY (`history_id`),
  KEY `FK_B4B2394A09DCDF2F0FFEAE835E028069` (`application_id`),
  CONSTRAINT `FK_B4B2394A09DCDF2F0FFEAE835E028069` FOREIGN KEY (`application_id`) REFERENCES `mg_xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect History';



# Dump of table mg_xmlconnect_notification_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_xmlconnect_notification_template`;

CREATE TABLE `mg_xmlconnect_notification_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `name` varchar(255) NOT NULL COMMENT 'Template Name',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) NOT NULL COMMENT 'Message Title',
  `content` text NOT NULL COMMENT 'Message Content',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  PRIMARY KEY (`template_id`),
  KEY `FK_2F14BFC88FBCF27F619842C0918A7432` (`application_id`),
  CONSTRAINT `FK_2F14BFC88FBCF27F619842C0918A7432` FOREIGN KEY (`application_id`) REFERENCES `mg_xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Template';



# Dump of table mg_xmlconnect_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mg_xmlconnect_queue`;

CREATE TABLE `mg_xmlconnect_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `exec_time` timestamp NULL DEFAULT NULL COMMENT 'Scheduled Execution Time',
  `template_id` int(10) unsigned NOT NULL COMMENT 'Template Id',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) DEFAULT '' COMMENT 'Message Title',
  `content` text COMMENT 'Message Content',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `type` varchar(12) NOT NULL COMMENT 'Type of Notification',
  PRIMARY KEY (`queue_id`),
  KEY `FK_DA50CA04D69D478FA928FDC8381C3244` (`template_id`),
  CONSTRAINT `FK_DA50CA04D69D478FA928FDC8381C3244` FOREIGN KEY (`template_id`) REFERENCES `mg_xmlconnect_notification_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Queue';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
