
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `aliasable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `aliasable_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_aliases_on_name_and_aliasable_type` (`name`,`aliasable_type`) USING BTREE,
  KEY `index_aliases_on_aliasable_id` (`aliasable_id`) USING BTREE,
  KEY `index_aliases_on_aliasable_type` (`aliasable_type`) USING BTREE,
  KEY `index_aliases_on_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `article_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  `position` int(11) DEFAULT '0',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_article_categories_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `heading` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` tinyint(1) DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `position` int(11) DEFAULT '0',
  `article_category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_articles_on_article_category_id` (`article_category_id`) USING BTREE,
  KEY `index_articles_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ages_begin` int(11) DEFAULT '0',
  `ages_end` int(11) DEFAULT '999',
  `friendly_param` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ability` int(11) NOT NULL DEFAULT '0',
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'M',
  `ability_begin` int(11) NOT NULL DEFAULT '0',
  `ability_end` int(11) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_index` (`name`) USING BTREE,
  KEY `index_categories_on_friendly_param` (`friendly_param`) USING BTREE,
  KEY `index_categories_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_categories_on_ability_begin` (`ability_begin`),
  KEY `index_categories_on_ability_end` (`ability_end`),
  KEY `index_categories_on_parent_id` (`parent_id`),
  CONSTRAINT `fk_rails_82f48f7407` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `competition_event_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition_event_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `points_factor` float DEFAULT '1',
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_competition_event_memberships_on_competition_id` (`competition_id`) USING BTREE,
  KEY `index_competition_event_memberships_on_event_id` (`event_id`) USING BTREE,
  CONSTRAINT `competition_event_memberships_competitions_id_fk` FOREIGN KEY (`competition_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `competition_event_memberships_events_id_fk` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `discipline_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discipline_aliases` (
  `discipline_id` int(11) NOT NULL DEFAULT '0',
  `alias` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  KEY `idx_alias` (`alias`) USING BTREE,
  KEY `index_discipline_aliases_on_discipline_id` (`discipline_id`),
  CONSTRAINT `fk_rails_1c1d7559b0` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `discipline_bar_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discipline_bar_categories` (
  `category_id` int(11) NOT NULL DEFAULT '0',
  `discipline_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `discipline_bar_categories_category_id_index` (`category_id`,`discipline_id`) USING BTREE,
  KEY `index_discipline_bar_categories_on_discipline_id` (`discipline_id`),
  CONSTRAINT `discipline_bar_categories_categories_id_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_76a8f4adc3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `disciplines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disciplines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bar` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `numbers` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_disciplines_on_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `discount_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_by_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `used_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`) USING BTREE,
  CONSTRAINT `discount_codes_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `duplicates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `new_attributes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `duplicates_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicates_people` (
  `person_id` int(11) DEFAULT NULL,
  `duplicate_id` int(11) DEFAULT NULL,
  UNIQUE KEY `index_duplicates_racers_on_racer_id_and_duplicate_id` (`person_id`,`duplicate_id`) USING BTREE,
  KEY `index_duplicates_racers_on_duplicate_id` (`duplicate_id`) USING BTREE,
  KEY `index_duplicates_racers_on_racer_id` (`person_id`) USING BTREE,
  CONSTRAINT `duplicates_people_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE,
  CONSTRAINT `duplicates_racers_duplicates_id_fk` FOREIGN KEY (`duplicate_id`) REFERENCES `duplicates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `editor_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editor_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `expires_at` datetime NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_editor_requests_on_editor_id_and_person_id` (`editor_id`,`person_id`) USING BTREE,
  KEY `index_editor_requests_on_editor_id` (`editor_id`) USING BTREE,
  KEY `index_editor_requests_on_expires_at` (`expires_at`) USING BTREE,
  KEY `index_editor_requests_on_person_id` (`person_id`) USING BTREE,
  KEY `index_editor_requests_on_token` (`token`) USING BTREE,
  CONSTRAINT `editor_requests_ibfk_1` FOREIGN KEY (`editor_id`) REFERENCES `people` (`id`) ON DELETE CASCADE,
  CONSTRAINT `editor_requests_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `editors_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editors_events` (
  `event_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  KEY `index_editors_events_on_editor_id` (`editor_id`) USING BTREE,
  KEY `index_editors_events_on_event_id` (`event_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `event_team_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_team_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_team_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_event_team_memberships_on_event_team_id_and_person_id` (`event_team_id`,`person_id`) USING BTREE,
  KEY `index_event_team_memberships_on_event_team_id` (`event_team_id`) USING BTREE,
  KEY `index_event_team_memberships_on_person_id` (`person_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `event_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_event_teams_on_event_id_and_team_id` (`event_id`,`team_id`) USING BTREE,
  KEY `index_event_teams_on_event_id` (`event_id`) USING BTREE,
  KEY `index_event_teams_on_team_id` (`team_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `discipline` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flyer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `sanctioned_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `flyer_approved` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled` tinyint(1) DEFAULT '0',
  `number_issuer_id` int(11) DEFAULT NULL,
  `first_aid_provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pre_event_fees` float DEFAULT NULL,
  `post_event_fees` float DEFAULT NULL,
  `flyer_ad_fee` float DEFAULT NULL,
  `prize_list` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `velodrome_id` int(11) DEFAULT NULL,
  `time` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instructional` tinyint(1) DEFAULT '0',
  `practice` tinyint(1) DEFAULT '0',
  `atra_points_series` tinyint(1) NOT NULL DEFAULT '0',
  `bar_points` int(11) NOT NULL DEFAULT '0',
  `ironman` tinyint(1) NOT NULL DEFAULT '1',
  `auto_combined_results` tinyint(1) NOT NULL DEFAULT '1',
  `team_id` int(11) DEFAULT NULL,
  `sanctioning_org_event_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `promoter_id` int(11) DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `postponed` tinyint(1) NOT NULL DEFAULT '0',
  `chief_referee` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `registration` tinyint(1) NOT NULL DEFAULT '0',
  `beginner_friendly` tinyint(1) NOT NULL DEFAULT '0',
  `promoter_pays_registration_fee` tinyint(1) NOT NULL DEFAULT '0',
  `membership_required` tinyint(1) NOT NULL DEFAULT '0',
  `registration_ends_at` datetime DEFAULT NULL,
  `override_registration_ends_at` tinyint(1) NOT NULL DEFAULT '0',
  `all_events_discount` decimal(10,2) DEFAULT NULL,
  `additional_race_price` decimal(10,2) DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `registration_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_suggestion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_limit` int(11) DEFAULT NULL,
  `refund_policy` text COLLATE utf8_unicode_ci,
  `refunds` tinyint(1) NOT NULL DEFAULT '1',
  `region_id` int(11) DEFAULT NULL,
  `end_date` date,
  `registration_public` tinyint(1) NOT NULL DEFAULT '1',
  `junior_price` decimal(10,2) DEFAULT NULL,
  `suggest_membership` tinyint(1) NOT NULL DEFAULT '1',
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year` int(11),
  `break_ties` tinyint(1) DEFAULT '1',
  `categories` tinyint(1) DEFAULT '0',
  `default_bar_points` int(11) DEFAULT '0',
  `dnf_points` decimal(10,2) DEFAULT '0.00',
  `double_points_for_last_event` tinyint(1) DEFAULT '0',
  `field_size_bonus` tinyint(1) DEFAULT '0',
  `members_only` tinyint(1) DEFAULT '1',
  `maximum_events` int(11) DEFAULT NULL,
  `minimum_events` int(11) DEFAULT NULL,
  `missing_result_penalty` int(11) DEFAULT NULL,
  `most_points_win` tinyint(1) DEFAULT '1',
  `points_schedule_from_field_size` tinyint(1) DEFAULT '0',
  `results_per_race` int(11) DEFAULT '1',
  `use_source_result_points` tinyint(1) DEFAULT '0',
  `team` tinyint(1) DEFAULT '0',
  `place_bonus` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_events_on_bar_points` (`bar_points`) USING BTREE,
  KEY `idx_disciplined` (`discipline`) USING BTREE,
  KEY `events_number_issuer_id_index` (`number_issuer_id`) USING BTREE,
  KEY `index_events_on_promoter_id` (`promoter_id`) USING BTREE,
  KEY `index_events_on_region_id` (`region_id`) USING BTREE,
  KEY `index_events_on_sanctioned_by` (`sanctioned_by`) USING BTREE,
  KEY `index_events_on_slug` (`slug`) USING BTREE,
  KEY `idx_type` (`type`) USING BTREE,
  KEY `index_events_on_type` (`type`) USING BTREE,
  KEY `index_events_on_updated_at` (`updated_at`) USING BTREE,
  KEY `velodrome_id` (`velodrome_id`) USING BTREE,
  KEY `index_events_on_year_and_slug` (`year`,`slug`) USING BTREE,
  KEY `index_events_on_year` (`year`) USING BTREE,
  KEY `index_events_on_date` (`date`),
  KEY `index_events_on_parent_id` (`parent_id`),
  CONSTRAINT `events_number_issuers_id_fk` FOREIGN KEY (`number_issuer_id`) REFERENCES `number_issuers` (`id`),
  CONSTRAINT `events_promoter_id` FOREIGN KEY (`promoter_id`) REFERENCES `people` (`id`) ON DELETE SET NULL,
  CONSTRAINT `events_velodrome_id_fk` FOREIGN KEY (`velodrome_id`) REFERENCES `velodromes` (`id`),
  CONSTRAINT `fk_rails_68f023eb25` FOREIGN KEY (`parent_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `homes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `weeks_of_recent_results` int(11) NOT NULL DEFAULT '2',
  `weeks_of_upcoming_events` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `index_homes_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `import_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `race_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `string_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `boolean_value` tinyint(1) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'LineItem',
  `promoter_pays_registration_fee` tinyint(1) NOT NULL DEFAULT '0',
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `discount_code_id` int(11) DEFAULT NULL,
  `line_item_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `effective_purchased_at` datetime DEFAULT NULL,
  `additional_product_variant_id` int(11) DEFAULT NULL,
  `purchased_discount_code_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_line_items_on_additional_product_variant_id` (`additional_product_variant_id`) USING BTREE,
  KEY `index_line_items_on_discount_code_id` (`discount_code_id`) USING BTREE,
  KEY `index_line_items_on_event_id` (`event_id`) USING BTREE,
  KEY `index_line_items_on_line_item_id` (`line_item_id`) USING BTREE,
  KEY `index_line_items_on_order_id` (`order_id`) USING BTREE,
  KEY `index_line_items_on_person_id` (`person_id`) USING BTREE,
  KEY `index_line_items_on_product_id` (`product_id`) USING BTREE,
  KEY `index_line_items_on_product_variant_id` (`product_variant_id`) USING BTREE,
  KEY `index_line_items_on_purchased_discount_code_id` (`purchased_discount_code_id`) USING BTREE,
  KEY `index_line_items_on_race_id` (`race_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mailing_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailing_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `friendly_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `subject_line_prefix` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_mailing_lists_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_mailing_lists_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nameable_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `year` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nameable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_names_on_name` (`name`) USING BTREE,
  KEY `team_id` (`nameable_id`) USING BTREE,
  KEY `index_names_on_nameable_type` (`nameable_type`) USING BTREE,
  KEY `index_names_on_year` (`year`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `non_member_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `non_member_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visible` tinyint(1) DEFAULT '1',
  `person_id` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT '0',
  `recent_result_on` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `non_member_results_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `non_member_results_people` (
  `non_member_result_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `number_issuers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `number_issuers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_issuers_name_index` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `offline_single_event_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offline_single_event_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `order_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT '0',
  `membership_card` tinyint(1) NOT NULL DEFAULT '0',
  `date_of_birth` date DEFAULT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'US',
  `membership_address_is_billing_address` tinyint(1) NOT NULL DEFAULT '1',
  `billing_first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'US',
  `card_expires_on` date DEFAULT NULL,
  `card_brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ccx_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dh_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `home_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mtb_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `official_interest` tinyint(1) NOT NULL DEFAULT '0',
  `race_promotion_interest` tinyint(1) NOT NULL DEFAULT '0',
  `team_interest` tinyint(1) NOT NULL DEFAULT '0',
  `volunteer_interest` tinyint(1) NOT NULL DEFAULT '0',
  `wants_mail` tinyint(1) NOT NULL DEFAULT '0',
  `wants_email` tinyint(1) NOT NULL DEFAULT '0',
  `road_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `track_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergency_contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `work_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cell_fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_order_people_on_order_id` (`order_id`) USING BTREE,
  KEY `index_order_people_on_person_id` (`person_id`) USING BTREE,
  CONSTRAINT `order_people_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_people_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `notes` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `purchase_time` datetime DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `waiver_accepted` tinyint(1) DEFAULT NULL,
  `error_message` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  `previous_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `suggest` tinyint(1) DEFAULT '1',
  `old_purchase_fees` decimal(10,2) DEFAULT NULL,
  `gateway` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_orders_on_gateway` (`gateway`) USING BTREE,
  KEY `index_orders_on_purchase_time` (`purchase_time`) USING BTREE,
  KEY `index_orders_on_status` (`status`) USING BTREE,
  KEY `index_orders_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pages_on_path` (`path`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `index_pages_on_slug` (`slug`) USING BTREE,
  KEY `index_pages_on_updated_at` (`updated_at`) USING BTREE,
  CONSTRAINT `pages_parent_id_fk` FOREIGN KEY (`parent_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `payment_gateway_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_gateway_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `success` tinyint(1) DEFAULT NULL,
  `authorization` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `line_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_order_transactions_on_created_at` (`created_at`) USING BTREE,
  KEY `index_payment_gateway_transactions_on_line_item_id` (`line_item_id`) USING BTREE,
  KEY `index_order_transactions_on_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `license` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cell_fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ccx_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dh_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `home_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mtb_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `member_from` date DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `road_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `track_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `work_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `member_to` date DEFAULT NULL,
  `print_card` tinyint(1) DEFAULT '0',
  `ccx_only` tinyint(1) NOT NULL DEFAULT '0',
  `bmx_category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wants_email` tinyint(1) NOT NULL DEFAULT '0',
  `wants_mail` tinyint(1) NOT NULL DEFAULT '0',
  `volunteer_interest` tinyint(1) NOT NULL DEFAULT '0',
  `official_interest` tinyint(1) NOT NULL DEFAULT '0',
  `race_promotion_interest` tinyint(1) NOT NULL DEFAULT '0',
  `team_interest` tinyint(1) NOT NULL DEFAULT '0',
  `member_usac_to` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `single_access_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `failed_login_count` int(11) NOT NULL DEFAULT '0',
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `license_expiration_date` date DEFAULT NULL,
  `club_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ncca_club_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'US',
  `card_brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_expires_on` date DEFAULT NULL,
  `membership_address_is_billing_address` tinyint(1) NOT NULL DEFAULT '1',
  `license_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'US',
  `emergency_contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_printed_at` datetime DEFAULT NULL,
  `membership_card` tinyint(1) NOT NULL DEFAULT '0',
  `official` tinyint(1) NOT NULL DEFAULT '0',
  `non_member_result_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `other_people_with_same_name` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_people_on_crypted_password` (`crypted_password`) USING BTREE,
  KEY `index_people_on_email` (`email`) USING BTREE,
  KEY `idx_first_name` (`first_name`) USING BTREE,
  KEY `idx_last_name` (`last_name`) USING BTREE,
  KEY `index_people_on_login` (`login`) USING BTREE,
  KEY `index_racers_on_member_from` (`member_from`) USING BTREE,
  KEY `index_racers_on_member_to` (`member_to`) USING BTREE,
  KEY `index_people_on_name` (`name`) USING BTREE,
  KEY `index_people_on_non_member_result_id` (`non_member_result_id`) USING BTREE,
  KEY `index_people_on_perishable_token` (`perishable_token`) USING BTREE,
  KEY `index_people_on_persistence_token` (`persistence_token`) USING BTREE,
  KEY `index_people_on_print_card` (`print_card`) USING BTREE,
  KEY `index_people_on_single_access_token` (`single_access_token`) USING BTREE,
  KEY `index_people_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_people_on_team_id` (`team_id`),
  CONSTRAINT `fk_rails_dbbaf0d12e` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `people_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people_people` (
  `person_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  UNIQUE KEY `index_people_people_on_editor_id_and_person_id` (`editor_id`,`person_id`) USING BTREE,
  KEY `index_people_people_on_editor_id` (`editor_id`) USING BTREE,
  KEY `index_people_people_on_person_id` (`person_id`) USING BTREE,
  CONSTRAINT `people_people_ibfk_1` FOREIGN KEY (`editor_id`) REFERENCES `people` (`id`) ON DELETE CASCADE,
  CONSTRAINT `people_people_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `people_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people_roles` (
  `role_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  KEY `index_people_roles_on_person_id` (`person_id`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE,
  CONSTRAINT `people_roles_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE,
  CONSTRAINT `roles_users_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` text COLLATE utf8_unicode_ci,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_photos_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `topica_message_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `mailing_list_id` int(11) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_reply_at` datetime DEFAULT NULL,
  `last_reply_from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original_id` int(11) DEFAULT NULL,
  `replies_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_topica_message_id` (`topica_message_id`) USING BTREE,
  KEY `idx_date_list` (`date`,`mailing_list_id`) USING BTREE,
  KEY `index_posts_on_last_reply_at` (`last_reply_at`) USING BTREE,
  KEY `idx_mailing_list_id` (`mailing_list_id`) USING BTREE,
  KEY `index_posts_on_original_id` (`original_id`) USING BTREE,
  KEY `index_posts_on_position` (`position`) USING BTREE,
  KEY `idx_subject` (`subject`) USING BTREE,
  KEY `index_posts_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_posts_on_date` (`date`),
  CONSTRAINT `posts_mailing_list_id_fk` FOREIGN KEY (`mailing_list_id`) REFERENCES `mailing_lists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `inventory` int(11) DEFAULT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `additional` tinyint(1) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_product_variants_on_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `notify_racing_association` tinyint(1) NOT NULL DEFAULT '0',
  `inventory` int(11) DEFAULT NULL,
  `seller_pays_fee` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `suggest` tinyint(1) NOT NULL DEFAULT '0',
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dependent` tinyint(1) NOT NULL DEFAULT '0',
  `seller_id` int(11) DEFAULT NULL,
  `has_amount` tinyint(1) DEFAULT '0',
  `donation` tinyint(1) DEFAULT '0',
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `concussion_waver_required` tinyint(1) DEFAULT '0',
  `quantity` tinyint(1) NOT NULL DEFAULT '0',
  `default_quantity` int(11) NOT NULL DEFAULT '1',
  `team_name` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_products_on_event_id` (`event_id`) USING BTREE,
  KEY `index_products_on_seller_id` (`seller_id`) USING BTREE,
  KEY `index_products_on_type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `race_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `race_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `discipline_id` int(11) NOT NULL DEFAULT '0',
  `number_issuer_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `year` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discipline_id` (`discipline_id`) USING BTREE,
  KEY `number_issuer_id` (`number_issuer_id`) USING BTREE,
  KEY `racer_id` (`person_id`) USING BTREE,
  KEY `race_numbers_value_index` (`value`) USING BTREE,
  KEY `index_race_numbers_on_year` (`year`) USING BTREE,
  CONSTRAINT `race_numbers_discipline_id_fk` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `race_numbers_number_issuer_id_fk` FOREIGN KEY (`number_issuer_id`) REFERENCES `number_issuers` (`id`),
  CONSTRAINT `race_numbers_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `distance` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_size` int(11) DEFAULT NULL,
  `laps` int(11) DEFAULT NULL,
  `time` float DEFAULT NULL,
  `finishers` int(11) DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `sanctioned_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `result_columns` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bar_points` int(11) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `custom_price` decimal(10,2) DEFAULT NULL,
  `custom_columns` text COLLATE utf8_unicode_ci,
  `full` tinyint(1) NOT NULL DEFAULT '0',
  `field_limit` int(11) DEFAULT NULL,
  `additional_race_only` tinyint(1) NOT NULL DEFAULT '0',
  `visible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_races_on_bar_points` (`bar_points`) USING BTREE,
  KEY `index_races_on_event_id` (`event_id`) USING BTREE,
  KEY `index_races_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_races_on_category_id` (`category_id`),
  CONSTRAINT `fk_rails_b35dac1d83` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `races_event_id_fk` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `racing_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racing_associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_members_from_results` tinyint(1) NOT NULL DEFAULT '1',
  `always_insert_table_headers` tinyint(1) NOT NULL DEFAULT '1',
  `award_cat4_participation_points` tinyint(1) NOT NULL DEFAULT '1',
  `bmx_numbers` tinyint(1) NOT NULL DEFAULT '0',
  `cx_memberships` tinyint(1) NOT NULL DEFAULT '0',
  `eager_match_on_license` tinyint(1) NOT NULL DEFAULT '0',
  `flyers_in_new_window` tinyint(1) NOT NULL DEFAULT '0',
  `gender_specific_numbers` tinyint(1) NOT NULL DEFAULT '0',
  `include_multiday_events_on_schedule` tinyint(1) NOT NULL DEFAULT '0',
  `show_all_teams_on_public_page` tinyint(1) NOT NULL DEFAULT '0',
  `show_calendar_view` tinyint(1) NOT NULL DEFAULT '1',
  `show_events_velodrome` tinyint(1) NOT NULL DEFAULT '1',
  `show_license` tinyint(1) NOT NULL DEFAULT '1',
  `show_only_association_sanctioned_races_on_calendar` tinyint(1) NOT NULL DEFAULT '1',
  `show_practices_on_calendar` tinyint(1) NOT NULL DEFAULT '0',
  `ssl` tinyint(1) NOT NULL DEFAULT '0',
  `usac_results_format` tinyint(1) NOT NULL DEFAULT '0',
  `cat4_womens_race_series_category_id` int(11) DEFAULT NULL,
  `masters_age` int(11) NOT NULL DEFAULT '35',
  `rental_numbers_end` int(11) DEFAULT NULL,
  `rental_numbers_start` int(11) DEFAULT NULL,
  `cat4_womens_race_series_points` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `administrator_tabs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `competitions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'US',
  `default_discipline` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Road',
  `default_sanctioned_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'scott.willson@gmail.com',
  `exempt_team_categories` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `membership_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Cascadia Bicycle Racing Association',
  `rails_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'localhost:3000',
  `sanctioning_organizations` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CBRA',
  `show_events_sanctioning_org_event_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'OR',
  `static_host` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'localhost',
  `usac_region` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'North West',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cat4_womens_race_series_end_date` date DEFAULT NULL,
  `unregistered_teams_in_results` tinyint(1) NOT NULL DEFAULT '1',
  `next_year_start_at` date DEFAULT NULL,
  `mobile_site` tinyint(1) NOT NULL DEFAULT '0',
  `cat4_womens_race_series_start_date` date DEFAULT NULL,
  `filter_schedule_by_sanctioning_organization` tinyint(1) NOT NULL DEFAULT '0',
  `result_questions_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_schedule_by_region` tinyint(1) NOT NULL DEFAULT '0',
  `default_region_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_iframes` tinyint(1) DEFAULT '0',
  `payment_gateway_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'elavon',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refunds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `line_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_refunds_on_line_item_id` (`line_item_id`) USING BTREE,
  KEY `index_refunds_on_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `friendly_param` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_regions_on_friendly_param` (`friendly_param`) USING BTREE,
  UNIQUE KEY `index_regions_on_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `race_id` int(11) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `is_series` tinyint(1) DEFAULT NULL,
  `license` varchar(64) COLLATE utf8_unicode_ci DEFAULT '',
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(16) COLLATE utf8_unicode_ci DEFAULT '',
  `place` varchar(8) COLLATE utf8_unicode_ci DEFAULT '',
  `place_in_category` int(11) DEFAULT '0',
  `points` float DEFAULT '0',
  `points_from_place` float DEFAULT '0',
  `points_bonus_penalty` float DEFAULT '0',
  `points_total` float DEFAULT '0',
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time` double DEFAULT NULL,
  `time_bonus_penalty` double DEFAULT NULL,
  `time_gap_to_leader` double DEFAULT NULL,
  `time_gap_to_previous` double DEFAULT NULL,
  `time_gap_to_winner` double DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `time_total` double DEFAULT NULL,
  `laps` int(11) DEFAULT NULL,
  `members_only_place` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `points_bonus` int(11) NOT NULL DEFAULT '0',
  `points_penalty` int(11) NOT NULL DEFAULT '0',
  `preliminary` tinyint(1) DEFAULT NULL,
  `bar` tinyint(1) DEFAULT '1',
  `gender` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_class` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age_group` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_attributes` text COLLATE utf8_unicode_ci,
  `competition_result` tinyint(1) NOT NULL,
  `team_competition_result` tinyint(1) NOT NULL,
  `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date_range_s` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `event_end_date` date NOT NULL,
  `event_id` int(11) NOT NULL,
  `event_full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `race_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `race_full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `team_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year` int(11) NOT NULL,
  `non_member_result_id` int(11) DEFAULT NULL,
  `single_event_license` tinyint(1) DEFAULT '0',
  `team_member` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_results_on_event_id` (`event_id`) USING BTREE,
  KEY `index_results_on_members_only_place` (`members_only_place`) USING BTREE,
  KEY `index_results_on_non_member_result_id` (`non_member_result_id`) USING BTREE,
  KEY `idx_racer_id` (`person_id`) USING BTREE,
  KEY `index_results_on_place` (`place`) USING BTREE,
  KEY `idx_race_id` (`race_id`) USING BTREE,
  KEY `index_results_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_results_on_year` (`year`) USING BTREE,
  KEY `index_results_on_category_id` (`category_id`),
  KEY `index_results_on_team_id` (`team_id`),
  CONSTRAINT `fk_rails_1656ccfca7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `fk_rails_c00c36d50b` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `results_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`),
  CONSTRAINT `results_race_id_fk` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_result_id` int(11) DEFAULT NULL,
  `source_result_id` int(11) DEFAULT NULL,
  `points` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scores_competition_result_id_index` (`competition_result_id`) USING BTREE,
  KEY `scores_source_result_id_index` (`source_result_id`) USING BTREE,
  CONSTRAINT `scores_competition_result_id_fk` FOREIGN KEY (`competition_result_id`) REFERENCES `results` (`id`) ON DELETE CASCADE,
  CONSTRAINT `scores_source_result_id_fk` FOREIGN KEY (`source_result_id`) REFERENCES `results` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `member` tinyint(1) DEFAULT '0',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sponsors` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_on_public_page` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_teams_on_updated_at` (`updated_at`) USING BTREE,
  KEY `index_teams_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `update_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_person_id` int(11) NOT NULL,
  `expires_at` datetime NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_update_requests_on_order_person_id` (`order_person_id`) USING BTREE,
  KEY `index_update_requests_on_expires_at` (`expires_at`) USING BTREE,
  KEY `index_update_requests_on_token` (`token`) USING BTREE,
  CONSTRAINT `update_requests_ibfk_1` FOREIGN KEY (`order_person_id`) REFERENCES `order_people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `velodromes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `velodromes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_velodromes_on_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versioned_id` int(11) DEFAULT NULL,
  `versioned_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modifications` text COLLATE utf8_unicode_ci,
  `number` int(11) DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `reverted_from` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_created_at` (`created_at`) USING BTREE,
  KEY `index_versions_on_number` (`number`) USING BTREE,
  KEY `index_versions_on_tag` (`tag`) USING BTREE,
  KEY `index_versions_on_user_id_and_user_type` (`user_id`,`user_type`) USING BTREE,
  KEY `index_versions_on_user_name` (`user_name`) USING BTREE,
  KEY `index_versions_on_versioned_id_and_versioned_type` (`versioned_id`,`versioned_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
