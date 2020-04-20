-- ============= [ store : CSW Store View ] ===================
SELECT * FROM rgw_core_website;
SELECT * FROM rgw_core_store; -- WHERE `store_id` = 2;

/*
M2 Categories Analysis
Entity Type ID  :   3   FOR CATEGORIES          -> ??? ab in ki url keys kahan hen ??????? Answer: neche isme : rgw_catalog_category_entity_url_key
     Store ID   |   Count
    ALL         |   1409
     0          |   1407
     1          |   2
     2          |   0
*/
select * from rgw_catalog_category_entity_varchar  ORDER BY entity_id ASC;
select * from rgw_catalog_category_entity_varchar where attribute_id=41;
select * from rgw_catalog_category_entity_varchar where attribute_id=41 and store_id=0;
select 'rgw_catalog_product_entity_varchar' as tbl,'0' as store_id, count(*) from rgw_catalog_category_entity_varchar where attribute_id=41 and store_id=0 union all
select 'rgw_catalog_product_entity_varchar' as tbl,'1' as store_id, count(*) from rgw_catalog_category_entity_varchar where attribute_id=41 and store_id=1 union all
select 'rgw_catalog_product_entity_varchar' as tbl,'2' as store_id, count(*) from rgw_catalog_category_entity_varchar where attribute_id=41 and store_id=2;

/*  ===================[ rgw_catalog_category_entity_url_key ]====================   : Catalog Category Url Key Attribute Backend Table
COLUMNS : value_id,entity_type_id,attribute_id,store_id,entity_id,value
ATTRIBUTE ID    :   43  for category
ENTITY TYPE ID  :   3   for category
    Store       |   COUNT
    All         |   1408
    0           |   1406
    1           |   2
    2           |   0
*/
select * from rgw_catalog_category_entity_url_key;
select DISTINCT  attribute_id from rgw_catalog_category_entity_url_key;
select COUNT(*) from rgw_catalog_category_entity_url_key;
select COUNT(*) from rgw_catalog_category_entity_url_key WHERE store_id=0;
select COUNT(*) from rgw_catalog_category_entity_url_key WHERE store_id=1;
select COUNT(*) from rgw_catalog_category_entity_url_key WHERE store_id=2;
-- ===============================================================================

/*
 M1 URL KEY REPORT for products
Entity Type ID  :   4   FOR PRODUCTS
 Store ID   |   Count
 0          |   130202
 1          |   0
 2          |   0
*/
select * from rgw_catalog_product_entity_varchar;
select * from rgw_catalog_product_entity_varchar where attribute_id=97 and store_id=0;
select 'rgw_catalog_product_entity_varchar' as tbl,'0' as store_id, count(*) from rgw_catalog_product_entity_varchar where attribute_id=97 and store_id=0 union all
select 'rgw_catalog_product_entity_varchar' as tbl,'1' as store_id, count(*) from rgw_catalog_product_entity_varchar where attribute_id=97 and store_id=1 union all
select 'rgw_catalog_product_entity_varchar' as tbl,'2' as store_id, count(*) from rgw_catalog_product_entity_varchar where attribute_id=97 and store_id=2;
/*  ===================[ rgw_catalog_product_entity_url_key ]====================   : Catalog Product Url Key Attribute Backend Table
COLUMNS : value_id,entity_type_id,attribute_id,store_id,entity_id,value
ATTRIBUTE ID    :   97
ENTITY TYPE ID  :   4
    Store       |   COUNT
    All         |   145900
    0           |   145900
    1           |   0
    2           |   0
*/
select * from rgw_catalog_product_entity_url_key;
select DISTINCT  entity_type_id from rgw_catalog_product_entity_url_key;
select COUNT(*) from rgw_catalog_product_entity_url_key;
select COUNT(*) from rgw_catalog_product_entity_url_key WHERE store_id=0;
select COUNT(*) from rgw_catalog_product_entity_url_key WHERE store_id=1;
select COUNT(*) from rgw_catalog_product_entity_url_key WHERE store_id=2;
select * from rgw_catalog_product_entity_url_key where value like '%19xe212%';

-- 123396 matched in rgw_catalog_product_entity_varchar vs rgw_catalog_product_entity_url_key
-- 6806 not in rgw_catalog_product_entity_url_key
select count(*)
from rgw_catalog_product_entity_varchar
where attribute_id=97 and store_id=0
and value not in (select distinct value from rgw_catalog_product_entity_url_key where attribute_id=97 and store_id=0);
-- 123394 matched in rgw_catalog_product_entity_url_key vs rgw_catalog_product_entity_varchar
-- 6806 not in 22506
select count(*)
from rgw_catalog_product_entity_url_key
where attribute_id=97 and store_id=0
and value not in (select distinct value from rgw_catalog_product_entity_varchar where attribute_id=97 and store_id=0);
-- ===============================================================================

/*  ===================[ rgw_enterprise_url_rewrite ]====================   : URL Rewrite
COLUMNS : url_rewrite_id,request_path,target_path,is_system,guid,identifier,inc,value_id,store_id,entity_type */
-- entity_type =1 ==> products      23260
-- entity_type =2 ==> category      1402
-- entity_type =2 ==> products      145942
select count(*) from rgw_enterprise_url_rewrite where entity_type=1 order by  url_rewrite_id desc ;
select count(*) from rgw_enterprise_url_rewrite where entity_type=2 order by  url_rewrite_id desc ;
select count(*) from rgw_enterprise_url_rewrite where entity_type=3 order by  url_rewrite_id desc ;
select DISTINCT  entity_type from rgw_enterprise_url_rewrite;
/*ENTITY TYPE ID  :   ALL       1           2       3
    Store       |   COUNT
    All         |   170604  = 23260 +   1402    +   145942      = 170604
    0           |   146156  = 214   +   0       +   145942      = 146156
    1           |   8313    = 7617  +   696     +   0           = 8313
    2           |   16135   = 15429 +   706     +   0           = 16135
*/




select * from rgw_enterprise_url_rewrite;
select COUNT(*) from rgw_enterprise_url_rewrite;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=0;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=1;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=2;
/*ENTITY TYPE ID  :   1
    Store       |   COUNT
    All         |   23260
    0           |   214
    1           |   7617
    2           |   15429
*/
select COUNT(*) from rgw_enterprise_url_rewrite WHERE entity_type=1;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=0 AND entity_type=1;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=1 AND entity_type=1;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=2 AND entity_type=1;
/*ENTITY TYPE ID  :   2
    Store       |   COUNT
    All         |   1402
    0           |   0
    1           |   696
    2           |   706
*/
select COUNT(*) from rgw_enterprise_url_rewrite WHERE entity_type=2;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=0 AND entity_type=2;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=1 AND entity_type=2;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=2 AND entity_type=2;
/*ENTITY TYPE ID  :   3
    Store       |   COUNT
    All         |   145942
    0           |   145942
    1           |   0
    2           |   0
*/
select COUNT(*) from rgw_enterprise_url_rewrite WHERE entity_type=3;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=0 AND entity_type=3;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=1 AND entity_type=3;
select COUNT(*) from rgw_enterprise_url_rewrite WHERE store_id=2 AND entity_type=3;

-- ===================================================================
-- a53979e5_csm1
-- a53979e5_csw_mig

select count(*) from rgw_enterprise_url_rewrite;
select * from rgw_catalog_product_entity_varchar where entity_id=2691 and attribute_id in (97,71)  and store_id=0;
select * from rgw_enterprise_url_rewrite where store_id=0 and entity_type=3;
select * from rgw_catalog_product_entity_int where entity_id=191721 and attribute_id=1509 and store_id=0 order by value_id desc;

show triggers;

-- SELECT * FROM `catalog_product_entity` WHERE 1
select *
from a53979e5_csm1.rgw_m2_cl_catalog_product_entity_int rm2ccpei
inner join a53979e5_csw_mig.catalog_product_entity cpe
on rm2ccpei.value_id=cpe.value_id
-- where entity_id=191721 and attribute_id=1509 and store_id=0 order by value_id desc;

select count(*) from rgw_catalog_product_entity_url_key;

select * from catalog_url_rewrite_product_category;

select * from rgw_enterprise_url_rewrite;
select * from rgw_core_url_rewrite;
select * from rgw_enterprise_catalog_category_rewrite;
select * from rgw_enterprise_catalog_product_rewrite;
select * from rgw_enterprise_url_rewrite;
select * from rgw_m_mstcore_urlrewrite;
select * from rgw_enterprise_url_rewrite_redirect_rewrite;
select * from rgw_enterprise_url_rewrite_redirect;



select * from rgw_core_url_rewrite;

select count(*) from rgw_enterprise_url_rewrite;


select count(*) as count from rgw_enterprise_url_rewrite union all
select count(*) as count  from rgw_catalog_category_entity_url_key union all
select count(*) as count  from  rgw_catalog_product_entity_url_key;
-- ================ [ images missing issue ] =========================
select count(*) from rgw_catalog_product_entity_media_gallery cpemg;
select cpemg.* from rgw_catalog_product_entity_media_gallery cpemg
-- inner join  rgw_catalog_product_entity_media_gallery_value cpemgv on cpemg.value_id=cpemgv.value_id
where attribute_id=88
-- and cpemg.entity_id=3313

-- mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1  rgw_catalog_product_entity_media_gallery rgw_catalog_product_entity_media_gallery_value>a53979e5_csm1_media_tables_14_feb.sql


select count(*) as count from rgw_catalog_product_entity_media_gallery union
select count(*) as count from rgw_catalog_product_entity_media_gallery_value

-- ==============[ Starts CSW | Product Related Data: SEO extension attributes are empty ] ================================================

select * from rgw_eav_attribute where entity_type_id=4 and note like '%MageWorx%';
select * from rgw_eav_attribute where entity_type_id=4 and attribute_code like 'meta_%' order by attribute_id;
select * from rgw_eav_attribute where entity_type_id=4 and attribute_code like '%canonical%' order by attribute_id;
select * from rgw_eav_attribute where entity_type_id=4 and attribute_code like '%seo_%' order by attribute_id;

select * from rgw_eav_attribute where entity_type_id=4 and attribute_code in (
'meta_title',
'meta_keyword',
'meta_description',
'canonical_url',
'canonical_cross_domain');

select distinct attribute_id from rgw_catalog_product_entity_varchar where attribute_id in (1490,1489,84,83,82);
select count(*) from rgw_catalog_product_entity_varchar where attribute_id in (1490,1489,84,83,82);
select * from rgw_catalog_category_entity_varchar where attribute_id in (1490,1489,84,83,82);


select value_id,
        attribute_id,
       store_id, entity_id, value
from rgw_catalog_product_entity_varchar  where attribute_id in (1456,1465,1466);

select value_id,
        attribute_id,
       store_id, entity_id, value
from rgw_catalog_product_entity_decimal  where attribute_id in (1456,1465,1466);

-- mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1  rgw_eav_attribute rgw_catalog_product_entity_varchar>a53979e5_csm1_varchar_n_eav_tables_16_feb.sql

-- ==============[ Ends CSW | Product Related Data: SEO extension attributes are empty ] ================================================
select * from rgw_core_config_data where value like '%shipper%';

select * from rgw_catalog_category_entity_varchar;

select * from rgw_eav_attribute where attribute_code like '%shipperhq%'

and attribute_code in (
'shipperhq_shipping_group'
,'shipperhq_warehouse'
,'shipperhq_hs_code' -- ye nahin he
,'shipperhq_shipping_fee'
,'shipperhq_handling_fee'
,'shipperhq_volume_weight'
,'shipperhq_declared_value'
,'shipperhq_dim_group'
,'shipperhq_poss_boxes'
,'shipperhq_malleable_product'
,'shipperhq_master_boxes'
,'shipperhq_availability_date'
,'shipperhq_nmfc_class'
,'shipperhq_nmfc_sub'
        );


-
select count(*)
 from rgw_catalog_product_entity; -- 145906-145946=40
select count(*)
 from rgw_catalog_category_entity; -- 1410-1409=-1
select count(*)
 from rgw_sales_flat_order; -- 22268-24285=-2017
select count(*)
 from rgw_customer_address_entity -- 7139-7679=-540

select count(*)
 from rgw_enterprise_url_rewrite; -- 283487 -- 170804
select count(*)
 from rgw_core_url_rewrite -- 283487 -728

8917-1482
CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID

select * from rgw_customer_address_entity where entity_id=1062;
select * from rgw_customer_entity where entity_id=8917
select * from rgw_eav_attribute_option where attribute_id=1457
select * from rgw_catalog_product_entity_text  where entity_id=192017
SELECT * FROM `rgw_catalog_category_entity_text` where entity_id=13
SELECT * FROM `rgw_catalog_category_entity_text` where entity_id=13 and attribute_id=1419
SELECT * FROM `rgw_catalog_category_entity_varchar` where entity_id=13 and attribute_id=1419
SELECT * FROM `rgw_catalog_category_entity_datetime` where entity_id=13 and attribute_id=1419
SELECT * FROM `rgw_catalog_category_entity_decimal` where entity_id=13 and attribute_id=1419
SELECT * FROM `rgw_catalog_category_entity_int` where entity_id=13 and attribute_id=1419



SELECT * FROM `rgw_catalog_category_entity_text` where attribute_id in (1420,1419,1424,1408,2915,1423);
SELECT * FROM `rgw_catalog_category_entity_text` where attribute_id in (1420,1419,1424,1408,2915,1423);
SELECT * FROM `rgw_catalog_category_entity_varchar` where attribute_id in (1420,1419,1424,1408,2915,1423);
SELECT * FROM `rgw_catalog_category_entity_datetime` where attribute_id in (1420,1419,1424,1408,2915,1423);
SELECT * FROM `rgw_catalog_category_entity_decimal` where attribute_id in (1420,1419,1424,1408,2915,1423);
SELECT * FROM `rgw_catalog_category_entity_int` where attribute_id in (1420,1419,1424,1408,2915,1423);


SELECT count(*) FROM `rgw_catalog_category_entity_text` where attribute_id in (1420,1419,1424,1408,2915,1423) union
SELECT count(*) FROM `rgw_catalog_category_entity_varchar` where attribute_id in (1420,1419,1424,1408,2915,1423) union
SELECT count(*) FROM `rgw_catalog_category_entity_datetime` where attribute_id in (1420,1419,1424,1408,2915,1423) union
SELECT count(*) FROM `rgw_catalog_category_entity_decimal` where attribute_id in (1420,1419,1424,1408,2915,1423) union
SELECT count(*) FROM `rgw_catalog_category_entity_int` where attribute_id in (1420,1419,1424,1408,2915,1423);


select * from rgw_eav_entity_attribute
select * from rgw_eav_entity_attribute ea where -- ea.attribute_id=2895 and
                                                attribute_set_id=38

select * from rgw_eav_attribute where  attribute_code='created_at';

SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order
FROM rgw_eav_attribute_set s
LEFT JOIN rgw_eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN rgw_eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN rgw_eav_attribute a         ON ea.attribute_id      = a.attribute_id
WHERE s.entity_type_id = 4
  and a.attribute_id in (258,257)
and g.attribute_group_name='Shipping' -- and s.attribute_set_name='sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;

select * from rgw_eav_attribute where attribute_code like '%ship_separately%'
select * from eav_entity_attribute ea where ea.attribute_id=2895 and attribute_set_id=38

select * from rgw_eav_attribute
where -- eaov.m2_option_id=7667 and
      p.entity_id=184798





select * from rgw_eav_attribute where attribute_code like '%ship_separately%';
select a.value_id, entity_type_id, attribute_id, store_id, entity_id, value
from rgw_catalog_product_entity_int a where attribute_id=254

select * from rgw_eav_attribute_option ov where attribute_id=254

select ov.value_id, option_id, store_id, value
from rgw_eav_attribute_option_value ov


select  2904 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_int a where attribute_id=256
select  2904 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_text where attribute_id=256
select  2904 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_datetime a where attribute_id=256

select  2904 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_varchar a where attribute_id=256
select  2904 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=256


-- cross verification for shipping attributes

-- entity ID : 58921    ,sku : 176000-71
SELECT * FROM rgw_catalog_product_entity where entity_id=58921;
-- frontend_label: Shipping Fee : 1459
select * from rgw_eav_attribute where attribute_id=1459;
-- frontend_label: Handling Fee : 1461
select * from rgw_eav_attribute where attribute_id=1461;

select * from rgw_catalog_product_entity_varchar where attribute_id=1459 and entity_id=58921;
select * from rgw_catalog_product_entity_decimal where attribute_id=1459 and  entity_id=58921;
select * from rgw_catalog_product_entity_int where attribute_id=1459 and  entity_id=58921;
select * from rgw_catalog_product_entity_datetime where attribute_id=1459 and  entity_id=58921;
select * from rgw_catalog_product_entity_text where attribute_id=1459 and  entity_id=58921;


select * from rgw_eav_entity_attribute where attribute_id=1459
select * from rgw_eav_entity_attribute where attribute_id=256

select * from rgw_eav_attribute_set a
inner join rgw_eav_attribute_group g on a.attribute_set_id=g.attribute_set_id
where attribute_group_name='Shipping'


-- cross verification for shipping attributes

-- entity ID : 58921    ,sku : 176000-71
SELECT * FROM rgw_catalog_product_entity where entity_id=58921;
-- frontend_label: Shipping Fee : 1459
select * from rgw_eav_attribute where attribute_id=1459;
-- frontend_label: Handling Fee : 1461
select * from rgw_eav_attribute where attribute_id=1461;


SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order, rcped.value
FROM rgw_eav_attribute_set s
LEFT JOIN rgw_eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN rgw_eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN rgw_eav_attribute a         ON ea.attribute_id      = a.attribute_id
left join rgw_catalog_product_entity_decimal rcped on ea.attribute_id=rcped.attribute_id
WHERE s.entity_type_id = 4
and a.attribute_id =1459 -- 1461 -- ,2906)
and g.attribute_group_name='Shipping'
-- and s.attribute_set_name='Migration_sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
and rcped.value=2703.0000
and rcped.entity_id=58921
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;

select count(*) from rgw_eav_attribute_set s
LEFT JOIN rgw_eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id



SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order, rcped.value
FROM rgw_eav_attribute_set s
LEFT JOIN rgw_eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN rgw_eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN rgw_eav_attribute a         ON ea.attribute_id      = a.attribute_id
left join rgw_catalog_product_entity_decimal rcped on ea.attribute_id=rcped.attribute_id
WHERE s.entity_type_id = 4
and a.attribute_id = 1459 -- 2898 (m2) -- ,2906)
and g.attribute_group_name='Shipping'
-- and s.attribute_set_name='Migration_sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
and rcped.value=2703.0000
and rcped.entity_id=58921
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;

select  * from rgw_eav_attribute a where a.attribute_id=1459;
select * from rgw_eav_entity_attribute ea where ea.attribute_id=1459;

select  * from rgw_eav_attribute a where a.attribute_id in (select ea.attribute_id from rgw_eav_entity_attribute ea where attribute_id=1459);

select count(*) from rgw_catalog_product_entity_decimal rcped  where rcped.attribute_id=1459
                                                                 and rcped.entity_id=58921




SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order, rcped.value
FROM rgw_eav_attribute_set s
LEFT JOIN rgw_eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN rgw_eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN rgw_eav_attribute a         ON ea.attribute_id      = a.attribute_id
left join rgw_catalog_product_entity_decimal rcped on ea.attribute_id=rcped.attribute_id
WHERE s.entity_type_id = 4
and a.attribute_id = 1459 -- 2898 (m2) -- ,2906)
and g.attribute_group_name='Shipping'
-- and s.attribute_set_name='Migration_sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
and rcped.value=2703.0000
and rcped.entity_id=58921
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;

select * from rgw_eav_attribute_group g where g.attribute_group_name='Shipping'


select * from rgw_eav_entity_attribute ea where ea.attribute_id=1459
and ea.attribute_group_id in (
select g.attribute_group_id from rgw_eav_attribute_group g where g.attribute_group_name='Shipping'
        )
order by attribute_set_id asc;

select * from rgw_eav_entity_attribute where attribute_id=1459 and entity_type_id=4;
-- xxx
select * from rgw_eav_entity_attribute where attribute_id=1461 and entity_type_id=4;
select * from rgw_eav_attribute where attribute_id=1461;
select * from rgw_eav_attribute where frontend_label='Handling Fee';


-- select * from rgw_eav_attribute_set where attribute_set_id=13

-- --shipping group issue :
select * from rgw_eav_attribute where frontend_label='Shipping Group'; -- 2895
select * from rgw_catalog_product_entity_text where entity_id=58921 and attribute_id=1456; -- and value=7594;
select count(*) from rgw_catalog_product_entity_varchar where attribute_id=1456 -- and entity_id=58921; -- and value=7594;


select * from rgw_catalog_product_entity_varchar
where attribute_id=1456  -- and entity_id=58921
                                               and value in (6303,7185);


-- mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1 rgw_catalog_product_entity_varchar>a53979e5_csm1_rgw_catalog_product_entity_varchar_apr_14.sql

-- category attributes task :
-- 1420
-- 1419,3,display_left_nav -- value =1
-- attribute code : display_left_nav , attribute id : 2931
-- step 1: attribute details
select * from rgw_eav_attribute where frontend_label='Display Only Left Categories';   -- to see attribte details by attribute id or name
select * from rgw_eav_attribute where attribute_id=1419;   -- to see attribte details by attribute id or name
-- step 1 ends
-- step 2: attribute used in products
SELECT * FROM `rgw_catalog_category_entity_int` where entity_id=13 and attribute_id=1419; -- union   -- es table data save ho rahi he category attribute display_left_nav ki
-- --------------------------------------------------------------------------------------------
SELECT * FROM `rgw_catalog_category_entity_text` where entity_id=13 and attribute_id=1419 -- union
SELECT * FROM `rgw_catalog_category_entity_varchar` where entity_id=13 and attribute_id=1419 -- union
SELECT * FROM `rgw_catalog_category_entity_decimal` where entity_id=13 and attribute_id=1419 -- union
SELECT * FROM `rgw_catalog_category_entity_datetime` where entity_id=13 and attribute_id=1419;

-- format as to migrate to m2
SELECT '2931' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_int` where attribute_id=1419; -- union   -- es table data save ho rahi he category attribute display_left_nav ki
-- SELECT distinct store_id FROM `rgw_catalog_category_entity_int` where attribute_id=1419; -- union   -- es table data save ho rahi he category attribute display_left_nav ki



-- step 1: attribute details
select * from rgw_eav_attribute where frontend_label='Display Only Left Categories';   -- to see attribte details by attribute id or name
select * from rgw_eav_attribute where frontend_label='Display Left Category As';   -- to see attribte details by attribute id or name
select * from rgw_eav_attribute where frontend_label='Image Text';   -- to see attribte details by attribute id or name
select * from rgw_eav_attribute where frontend_label='Show In Layered Navigation Filter';   -- to see attribte details by attribute id or name
select * from rgw_eav_attribute where frontend_label='Home Page Slider Image';   -- to see attribte details by attribute id or name

select * from rgw_eav_attribute where attribute_id=1423;   -- to see attribte details by attribute id or name
-- step 1 ends
-- step 2: attribute used in products
-- GENERAL
SELECT * FROM `rgw_catalog_category_entity_int` where attribute_id=1423;
SELECT * FROM `rgw_catalog_category_entity_text` where attribute_id=1423;
SELECT * FROM `rgw_catalog_category_entity_varchar` where attribute_id=1423;
SELECT * FROM `rgw_catalog_category_entity_decimal` where attribute_id=1423;
SELECT * FROM `rgw_catalog_category_entity_datetime` where attribute_id=1423;

-- YE MIGRATING
SELECT * FROM `rgw_catalog_category_entity_int` where attribute_id=1419; -- union   -- es table data save ho rahi he category attribute display_left_nav ki
SELECT * FROM `rgw_catalog_category_entity_int` where attribute_id=1420;
SELECT * FROM `rgw_catalog_category_entity_text` where attribute_id=1424
SELECT * FROM `rgw_catalog_category_entity_int` where attribute_id=1408;
SELECT * FROM `rgw_catalog_category_entity_varchar` where attribute_id=1423;

-- format as to migrate to m2
SELECT '2931' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_int` where attribute_id=1419; -- union   -- es table data save ho rahi he category attribute display_left_nav ki
SELECT '2932' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_int` where attribute_id=1420;
SELECT '2934' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_text` where attribute_id=1424;
SELECT '2930' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_int` where attribute_id=1408;

SELECT '2933' as attribute_id, store_id, entity_id, value FROM `rgw_catalog_category_entity_varchar` where attribute_id=1423;

-- 1408
-- SELECT distinct store_id FROM `rgw_catalog_category_entity_int` where attribute_id=1420; -- union   -- es table data save ho rahi he category attribute display_left_nav ki


