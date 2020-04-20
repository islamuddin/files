-- phpMyAdmin SQL Dump
-- version 4.0.10.17
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 11, 2019 at 03:33 PM
-- Server version: 10.2.22-MariaDB
-- PHP Version: 5.6.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `a0d03e33_mig`
--

-- --------------------------------------------------------

--
-- Table structure for table `am_label`
--

DROP TABLE IF EXISTS `am_label`;
CREATE TABLE IF NOT EXISTS `am_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pos` int(11) NOT NULL DEFAULT 0 COMMENT 'Position',
  `is_single` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Is Single',
  `name` text NOT NULL COMMENT 'Name',
  `stores` text NOT NULL COMMENT 'Stores',
  `prod_txt` text NOT NULL COMMENT 'Product text',
  `prod_img` text NOT NULL COMMENT 'Product image',
  `prod_image_size` text NOT NULL COMMENT 'Product image size',
  `prod_pos` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Product position',
  `prod_style` text NOT NULL COMMENT 'Product style',
  `prod_text_style` text NOT NULL COMMENT 'Product text style',
  `cat_txt` text NOT NULL COMMENT 'Category text',
  `cat_img` text NOT NULL COMMENT 'Category image',
  `cat_pos` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Category position',
  `cat_style` text NOT NULL COMMENT 'Category style',
  `cat_image_size` text NOT NULL COMMENT 'Category image size',
  `cat_text_style` text NOT NULL COMMENT 'Category text style',
  `is_new` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Is new',
  `is_sale` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Is sale',
  `special_price_only` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Special Price Only',
  `stock_less` int(11) DEFAULT NULL COMMENT 'Stock less',
  `stock_more` int(11) NOT NULL DEFAULT 0 COMMENT 'Stock more',
  `stock_status` int(11) NOT NULL DEFAULT 0 COMMENT 'Stock status',
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `date_range_enabled` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Date range enabled',
  `from_price` float NOT NULL COMMENT 'From price',
  `to_price` float NOT NULL COMMENT 'To price',
  `by_price` smallint(6) NOT NULL DEFAULT 0 COMMENT 'By price',
  `price_range_enabled` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Price range enabled',
  `customer_group_ids` text NOT NULL COMMENT 'Customer groups',
  `cond_serialize` text NOT NULL COMMENT 'Conditions',
  `customer_group_enabled` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Customer group enabled',
  `use_for_parent` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Use for parent',
  `status` smallint(6) DEFAULT NULL,
  `product_stock_enabled` smallint(6) DEFAULT NULL,
  `stock_higher` int(11) DEFAULT NULL,
  PRIMARY KEY (`label_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='am_label' AUTO_INCREMENT=22 ;

--
-- Dumping data for table `am_label`
--

INSERT INTO `am_label` (`label_id`, `pos`, `is_single`, `name`, `stores`, `prod_txt`, `prod_img`, `prod_image_size`, `prod_pos`, `prod_style`, `prod_text_style`, `cat_txt`, `cat_img`, `cat_pos`, `cat_style`, `cat_image_size`, `cat_text_style`, `is_new`, `is_sale`, `special_price_only`, `stock_less`, `stock_more`, `stock_status`, `from_date`, `to_date`, `date_range_enabled`, `from_price`, `to_price`, `by_price`, `price_range_enabled`, `customer_group_ids`, `cond_serialize`, `customer_group_enabled`, `use_for_parent`, `status`, `product_stock_enabled`, `stock_higher`) VALUES
(5, 0, 0, '20 Off Value Sets', '1', '', '20off.gif', '', 0, '', '', '', '120off.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all"}', 1, 0, 1, 0, NULL),
(6, 0, 0, '40 off clearance', '1', '', 'ProductLabel.gif', '', 0, '', '', '', '1ProductLabel.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"87","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(7, 99, 0, ' NEW!', '1', '', 'new2.png', '', 0, '', '', '', '0new2.png', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all"}', 1, 0, 1, 0, NULL),
(8, 0, 0, '30 Off ', '1', '', '54321030off_2.png', '', 0, '', '', '', '654321030off_2.png', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"275","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(9, 0, 0, '35 Off', '1', '', '35off.gif', '', 0, '', '', '', '035off.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all"}', 1, 0, 1, 0, NULL),
(10, 0, 0, '60 off Hayden', '1', '', '321060off.png', '', 0, '', '', '', '4321060off.png', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"228","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(11, 0, 0, 'BBB Exclusive', '1', '', 'BBB-Exclusive.gif', '', 0, '', '', '', '0BBB-Exclusive.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"163","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(12, 0, 0, '15 off', '1', '', '15off.gif', '', 0, '', '', '', '015off.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"79","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(13, 0, 0, 'Sample Items', '1', '', 'Sample-Label.gif', '', 0, '', '', '', '0Sample-Label.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"sku","operator":"==","value":"4932-S05E","is_value_processed":false},{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"59","is_value_processed":false}]}', 0, 0, 1, 0, NULL),
(14, 0, 0, 'Coming Soon', '1', '', 'Coming-Soon-Label.gif', '', 0, '', '', '', '0Coming-Soon-Label.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all"}', 1, 0, 1, 0, NULL),
(15, 0, 0, '25 off', '1', '', '321025off.gif', '', 0, '', '', '', '4321025off.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all"}', 1, 0, 1, 0, NULL),
(16, 0, 0, '50 Off', '1', '', '50off2.gif', '', 0, '', '', '', '050off2.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"273","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(17, 0, 0, 'Available at Macy''s', '1', '', 'Available_at_Macys.png', '', 0, '', '', '', '0Available_at_Macys.png', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"199","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(18, 2, 0, 'Retired Items', '1', '', 'Retired_Image_Label_5_small_2.gif', '', 8, '', '', '', '0Retired_Image_Label_5_small_2.gif', 8, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"sku","operator":"==","value":"4352-zzz","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(19, 1, 0, 'Macy''s Exclusive', '1', '', '10Macys-Exclusive-Label.gif', '', 0, '', '', '', '21210Macys-Exclusive-Label.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"199","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(20, 1, 0, 'Colorwave Curve ', '1', '', 'Curve-Exclusive-Label-LC.gif', '', 0, '', '', '', '0Curve-Exclusive-Label-LC.gif', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"269","is_value_processed":false}]}', 1, 0, 1, 0, NULL),
(21, 0, 0, 'Everyday Low Price on 50s', '1', '', 'Labelfor50PieceSetListingsonWebsitecopy.jpg', '', 0, '', '', '', '0Labelfor50PieceSetListingsonWebsitecopy.jpg', 0, '', '', '', 0, 0, 0, NULL, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, '["0","1","2","3"]', '{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Combine","attribute":null,"operator":null,"value":"1","is_value_processed":null,"aggregator":"all","conditions":[{"type":"Magento\\\\CatalogRule\\\\Model\\\\Rule\\\\Condition\\\\Product","attribute":"category_ids","operator":"==","value":"274","is_value_processed":false}]}', 1, 0, 1, 0, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
