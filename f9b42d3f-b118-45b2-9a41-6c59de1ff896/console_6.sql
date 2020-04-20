select * from rgw_eav_attribute where  attribute_code='created_at';
select * from eav_attribute where  attribute_code='created_at';

select * from rgw_eav_entity_attribute;
select * from eav_entity_attribute;

-- 1.1 ese attributes jin attr id or code ek jesa he
select * from rgw_eav_entity_attribute where attribute_id not in
(
    select m2.attribute_id from eav_entity_attribute m2 where  m2.attribute_id in  (
        select m1.attribute_id from eav_attribute m2 inner join rgw_eav_attribute m1 on m2.attribute_id=m1.attribute_id and m2.attribute_code=m1.attribute_code
    )
);

-- backup and insert
# create table temp_apr_7_eav_entity_attribute_act_bkp select * from eav_entity_attribute
 select * from temp_apr_7_eav_entity_attribute_act_bkp
-- insert : DONE ye kam 1.1 wali insert ki file save kr k usme table ka nam change kr k krlia

-- 1.2.1 ese attributes jin attr id or code ek jesa nain he + jo duplicate nahin hen
        create table shipping_attributes_mapping_data_insert_2
        select * from rgw_eav_entity_attribute mage1 where  mage1.attribute_id in  (
            -- isko sai krna he duplicates hata hen
            select m1.attribute_id from eav_attribute m2 inner join rgw_eav_attribute m1 on  m2.attribute_code=m1.attribute_code and m2.attribute_id!=m1.attribute_id
            where m1.attribute_code not in (
                select n.attribute_code from eav_attribute n group by n.attribute_code having count(n.attribute_code)>1
                )
        );
select entity_type_id, attribute_set_id, attribute_group_id, m1t2.m2_attribute_id as attribute_id, sort_order
from shipping_attributes_mapping_data_insert_2 m1t1
left join temp_apr_7_eav_attribute_mapping m1t2 on m1t1.attribute_id=m1t2.m1_attribute_id;

select * from temp_apr_7_eav_attribute_mapping;

-- INSERT IGNORE INTO eav_entity_attribute(entity_type_id, attribute_set_id, attribute_group_id, attribute_id, sort_order) VALUES (4, 22, 974, 2903, 1);



-- 1.2.2 ese attributes jin attr id or code ek jesa nain he + jo duplicate hen




SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order
FROM eav_attribute_set s
LEFT JOIN eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN eav_attribute a         ON ea.attribute_id      = a.attribute_id
WHERE s.entity_type_id = 4
  and a.attribute_id =2898 -- ,2906)
and g.attribute_group_name='Shipping'
--  and s.attribute_set_name='Migration_sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;

select * from eav_entity_varchar;
select * from catalog_product_entity_varchar where entity_id=191977;
select * from catalog_product_entity_decimal where entity_id=191977;
select * from catalog_product_entity_int where entity_id=191977;
select * from catalog_product_entity_datetime where entity_id=191977;
select * from catalog_product_entity_text where entity_id=191977;

select * from rgw_catalog_product_entity_varchar where entity_id=191977;
select * from rgw_catalog_product_entity_decimal where entity_id=191977;
select * from rgw_catalog_product_entity_int where entity_id=191977;


-- entity ID : 58921    ,sku : 176000-71
SELECT * FROM catalog_product_entity where entity_id=58921;
-- frontend_label: Shipping Fee : 1459 / 2898
select * from rgw_eav_attribute where attribute_id=1459;
select * from eav_attribute where frontend_label='Shipping Fee';
-- frontend_label: Handling Fee : 1461 / 2899
select * from rgw_eav_attribute where attribute_id=1461;
select * from eav_attribute where frontend_label='Handling Fee';

select * from rgw_catalog_product_entity_decimal where attribute_id=1459 and  entity_id=58921;
select * from rgw_catalog_product_entity_decimal where attribute_id=1461 and  entity_id=58921;

select * from rgw_catalog_product_entity_varchar where attribute_id=1459 and entity_id=58921;
select * from rgw_catalog_product_entity_int where attribute_id=1459 and  entity_id=58921;
-- migrate it
# select * from rgw_catalog_product_entity_datetime where attribute_id=1459 and  entity_id=58921;
# select * from rgw_catalog_product_entity_text where attribute_id=1459 and  entity_id=58921;

select * from catalog_product_entity_decimal where attribute_id=2898 and  entity_id=58921;
select * from catalog_product_entity_decimal where attribute_id=2899 and  entity_id=58921;

select * from catalog_product_entity_varchar where attribute_id=2898 and entity_id=58921;
select * from catalog_product_entity_int where attribute_id=2898 and  entity_id=58921;
select * from catalog_product_entity_datetime where attribute_id=2898 and  entity_id=58921;
select * from catalog_product_entity_text where attribute_id=2898 and  entity_id=58921;

-- migrating data for shpping fee and handling fee

select * from eav_attribute where attribute_code='shipperhq_handling_fee'   -- 2899
select * from rgw_eav_attribute where attribute_code='shipperhq_handling_fee'; -- 1461
select  2899 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=1461;

-- table : catalog_product_entity_decimal
select  2899 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=258;
select  2899 as attribute_id, store_id, entity_id, value from catalog_product_entity_decimal a where attribute_id=2899;

# insert into catalog_product_entity_decimal(attribute_id, store_id, entity_id, value)
# select  2899 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=1461;


-- verification query
    select  count(rcpei.entity_id) from catalog_product_entity_decimal rcpei where attribute_id=2906;
    select  count(rcpei.entity_id) from rgw_catalog_product_entity_decimal rcpei where attribute_id=258;
-- ---------------------------------

-- migrating data for shpping fee and handling fee

select * from eav_attribute where attribute_code='shipperhq_shipping_fee'   -- 2898
select * from rgw_eav_attribute where attribute_code='shipperhq_shipping_fee'; -- 1459
select  2898 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=1459;

-- table : catalog_product_entity_decimal
select  2898 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=258;
select  2898 as attribute_id, store_id, entity_id, value from catalog_product_entity_decimal a where attribute_id=2898;

# insert into catalog_product_entity_decimal(attribute_id, store_id, entity_id, value)
# select  2898 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_decimal a where attribute_id=1459;


-- verification query
    select  count(rcpei.entity_id) from catalog_product_entity_decimal rcpei where attribute_id=2898;
    select  count(rcpei.entity_id) from rgw_catalog_product_entity_decimal rcpei where attribute_id=258;
-- ---------------------------------




-- mass verification
select
-- mapping table
select * from rgw_eav_entity_attribute where attribute_id=1459
select * from rgw_eav_entity_attribute where attribute_id=256

select * from eav_entity_attribute where attribute_id=2906
select * from eav_entity_attribute where attribute_id=2899

select * from rgw_eav_entity_attribute

select * from eav_attribute_group where attribute_group_name='Shipping'
select * from rgw_eav_attribute_group where attribute_group_name='Shipping'

select a.attribute_set_name,count(g.attribute_group_name) from eav_attribute_set a
inner join eav_attribute_group g on a.attribute_set_id=g.attribute_set_id
where attribute_group_name='Shipping'
group by a.attribute_set_name


-- from m1 with love
SELECT ea.entity_attribute_id, ea.entity_type_id, ea.attribute_set_id, ea.attribute_group_id, ea.attribute_id, ea.sort_order,
       s.attribute_set_name,
       g.attribute_group_name,
       a.attribute_code,
       a.attribute_id,
       a.frontend_label,
       ea.sort_order, rcped.value
FROM eav_attribute_set s
LEFT JOIN eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
LEFT JOIN eav_entity_attribute ea ON g.attribute_group_id = ea.attribute_group_id
LEFT JOIN eav_attribute a         ON ea.attribute_id      = a.attribute_id
left join catalog_product_entity_decimal rcped on ea.attribute_id=rcped.attribute_id
WHERE s.entity_type_id = 4
and a.attribute_id =2898 -- ,2906)
and g.attribute_group_name='Shipping'
-- and s.attribute_set_name='Migration_sanctuary_lamps' -- in ('Migration_advent_wreaths__candles','shipperhq_shipping_group')
and rcped.value=2703.0000
and rcped.entity_id=58921
ORDER BY s.attribute_set_name,
         g.sort_order,
         ea.sort_order;



select * from eav_entity_attribute ea where ea.attribute_id=2898
and ea.attribute_group_id in (
select g.attribute_group_id from eav_attribute_group g where g.attribute_group_name='Shipping'
        );

select * from eav_attribute_group g where g.attribute_group_name='Shipping'


select s.attribute_set_id,g.attribute_group_id, 2898 as attribute_id,s.entity_type_id,4 as sort_order
FROM eav_attribute_set s
LEFT JOIN eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
where g.attribute_group_name='Shipping' and s.entity_type_id=4 and attribute_group_id!=2503
and attribute_group_id=2898
select count(*) from catalog_product_entity_decimal rcped  where rcped.attribute_id=2898;

-- backup and insert
# create table temp_apr_13_eav_entity_attribute_act_bkp select * from eav_entity_attribute
select count(*) from temp_apr_13_eav_entity_attribute_act_bkp
select * from eav_entity_attribute

-- insert into eav_entity_attribute(attribute_set_id,entity_type_id, attribute_group_id, attribute_id, sort_order)
select s.attribute_set_id,s.entity_type_id,g.attribute_group_id, 2898 as attribute_id,4 as sort_order
FROM eav_attribute_set s
LEFT JOIN eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
where g.attribute_group_name='Shipping' and s.entity_type_id=4

select * from eav_entity_attribute where attribute_id=2898 and entity_type_id=4;


-- for second attribute
select * from eav_entity_attribute where attribute_id=2899 and entity_type_id=4;
select * from eav_attribute where frontend_label='Handling Fee';



select * from eav_entity_attribute ea where ea.attribute_id=2899 and ea.attribute_group_id in (select g.attribute_group_id from eav_attribute_group g where g.attribute_group_name='Shipping');

-- insert into eav_entity_attribute(attribute_set_id,entity_type_id, attribute_group_id, attribute_id, sort_order)
select s.attribute_set_id,s.entity_type_id,g.attribute_group_id, 2899 as attribute_id,4 as sort_order
FROM eav_attribute_set s
LEFT JOIN eav_attribute_group g   ON s.attribute_set_id   = g.attribute_set_id
where g.attribute_group_name='Shipping' and s.entity_type_id=4;

-- Shipping Group tracking
-- entity id : 58921,
-- eav_attribute_group attribute_group_name :  Shipping

-- Step 1 : General
select * from eav_attribute where frontend_label='Shipping Group'; -- 2895
select * from eav_attribute where attribute_id=2895;

-- Step 2 : General
-- select * from eav_attribute_option where option_id=7596; -- es sy bhi attribute nikal skte hen
select * from eav_attribute_option where attribute_id=2895;
select * from eav_attribute_option where attribute_id=2895;

-- Step 3 : General
select * from eav_attribute_option_value where option_id in (select option_id from eav_attribute_option where attribute_id=2895);

-- Step 4 : Find for a single product if option is selected or not
-- set with selected option id: 7594 : selected option value : FREIGHT : 1 row found = selected , no row found
select * from catalog_product_entity_text where entity_id=58921 and attribute_id=2895 and value=7594;
select * from catalog_product_entity_text where attribute_id=2895 and value=7602;
select * from catalog_product_entity_text where entity_id=58921 and attribute_id=2895 -- and value=7594;

-- ISSUE: m1 me msla pakra gaya he wo ye he k m1 me rgw_catalog_product_entity_varchar wale table me shipping group k selected values ja rahe hen or m2 me catalog_product_entity_text men.
select count(*) from rgw_catalog_product_entity_varchar where attribute_id=1456 -- and entity_id=58921; -- and value=7594;

-- ISSUE: lo ek or msla data to migrate hua he varchar me and text me migrate nahin hua isiliye wo show nahin ho raha he frond end pe
select count(*) from catalog_product_entity_varchar where attribute_id=2895 -- and entity_id=58921; -- and value=7594;

-- ISSUE: lo ek or msla data me values bhi m1 k pare huae hen ye value m2 k hone chaiye the
select * from catalog_product_entity_varchar where attribute_id=2895  and entity_id=58921; -- and value=7594;

-- SOLUTION: varchar me sy data text me jaega or varchar wala deta delete hoga shipping group sy related or m1 wale option id change honge m2 ki option id me bsss.
select * from catalog_product_entity_varchar where attribute_id=2895  -- and entity_id=58921
                                               and value!=6303;

select COUNT(*) from catalog_product_entity_varchar where attribute_id=2895  -- and entity_id=58921
                                               and value!=6303;

select * from catalog_product_entity_text where attribute_id=2895; -- and entity_id=58921

# select count(*) from catalog_product_entity_varchar where attribute_id=2895   and entity_id=58921
#                                                and value in (6303,7185);
-- backup n delte those which are manually selected option values by ID n Pravin
# INSERT INTO a53979e5_csw_mig.catalog_product_entity_text (value_id, attribute_id, store_id, entity_id, value) VALUES (1450867, 2895, 0, 165910, '7602');
# INSERT INTO a53979e5_csw_mig.catalog_product_entity_text (value_id, attribute_id, store_id, entity_id, value) VALUES (1647987, 2895, 0, 58921, '7594');

-- delete from catalog_product_entity_text where attribute_id=2895; -- and entity_id=58921
-- mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig>a53979e5_csw_mig_23_dec.sql
-- mysql -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig
-- from m1 : a53979e5_csm1_rgw_catalog_product_entity_varchar_apr_14.sql

-- table imported again with lastest data.
-- pre condition before migration to m2 table text ,,, varchar table to be mapped with m2 attribute option value :
-- total : 5 (ye to manuly bhi update ho skte hen). so upating manulay
select distinct  value from rgw_catalog_product_entity_varchar where value  is not null and attribute_id=1456;
#   m1              :   m2
# 6303              :   7594
# 7185              :   7602
# 6304              :   7595
# 7569,6306,6307    :   7603,7597,7598
# 6309              :   7600

-- step 1: m1 me dekho us attribute ka name value kia he by picking option id from above resultset
select * from rgw_eav_attribute_option_value where option_id =6309; -- m1: 6303=> FREIGHT => m2 : ?
-- step 2: m2 me dekho us attribute ka name value kia he
select * from eav_attribute_option_value where option_id in ( select option_id from eav_attribute_option where attribute_id=2895 and value ='FREE');-- m1: 6303=> FREIGHT => m2 : 7594

-- mapping hogai ab update krdo : DONE
# update rgw_catalog_product_entity_varchar set value='7594' where value='6303';
# update rgw_catalog_product_entity_varchar set value='7602' where value='7185';
# update rgw_catalog_product_entity_varchar set value='7595' where value='6304';
# update rgw_catalog_product_entity_varchar set value='7603,7597,7598' where value='7569,6306,6307';
# update rgw_catalog_product_entity_varchar set value='7600' where value='6309';


select count(*) from rgw_catalog_product_entity_varchar where attribute_id=1456;  -- and entity_id=58921

-- CHECK ALREADY IS ATTRIBTE K AGAIN KOI DATA TO NAHIN: CHECKED : NO DATA FOUND, PROCEED TO INSERT
SELECT * from catalog_product_entity_text where attribute_id=2895; -- and entity_id=58921

-- INSERT INTO a53979e5_csw_mig.catalog_product_entity_text (attribute_id, store_id, entity_id, value)
-- IS ME SY TO DELTE KRDI AB M1 WALE TABLE rgw_catalog_product_entity_varchar ME SY IMPORT HOGA DATA : select attribute_id, store_id, entity_id, value from catalog_product_entity_varchar where attribute_id=2895;  -- and entity_id=58921
-- select 2895 as attribute_id, store_id, entity_id, value from rgw_catalog_product_entity_varchar where attribute_id=1456 -- and entity_id=58921
#                                                and value in (6303,7185); -- M2: 7602,7594


-- admin index issue
SELECT * FROM `core_config_data` where path like '%crontab/%';

# DELETE FROM core_config_data WHERE path LIKE 'crontab/%' AND path NOT LIKE 'crontab/default%' AND config_id > 0
select * FROM core_config_data WHERE path LIKE 'crontab/%' AND path NOT LIKE 'crontab/default%' AND config_id > 0;
-- DELETE FROM core_config_data WHERE path LIKE 'crontab/%' AND path NOT LIKE 'crontab/default%' AND config_id > 0
-- default wale original
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (17, 'default', 0, 'crontab/default/jobs/analytics_subscribe/schedule/cron_expr', '0 * * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (786, 'default', 0, 'crontab/default/jobs/catalog_product_alert/schedule/cron_expr', '0 0 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1444, 'default', 0, 'crontab/default/jobs/log_clean/schedule/cron_expr', '0 0 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1445, 'default', 0, 'crontab/default/jobs/log_clean/run/model', 'log/cron::logClean', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1461, 'default', 0, 'crontab/default/jobs/enterprise_import_export_log_clean/schedule/cron_expr', '0 0 * * 1', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1587, 'default', 0, 'crontab/default/jobs/sitemap_generate/schedule/cron_expr', '0 6 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1588, 'default', 0, 'crontab/default/jobs/sitemap_generate/run/model', 'sitemap/observer::scheduledGenerateSitemaps', '2020-01-06 14:08:00');


-- back crontab entries and delete them
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (1461, 'default', 0, 'crontab/default/jobs/enterprise_import_export_log_clean/schedule/cron_expr', '0 0 * * 1', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2343, 'default', 0, 'crontab/default/jobs/enterprise_index_clean_changelog/schedule/cron_expr', '30 23 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2351, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2352, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2353, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2354, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2355, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2356, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2357, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2358, 'default', 0, 'crontab/default/jobs/enterprise_refresh_index/schedule/cron_expr', '*/5 * * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2359, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2360, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2361, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2362, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2363, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2364, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2365, 'default', 0, 'crontab/default/jobs/captcha_delete_old_attempts/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2366, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2367, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2368, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2369, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2370, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2371, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2372, 'default', 0, 'crontab/default/jobs/captcha_delete_expired_images/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2373, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2374, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2375, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2376, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2377, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2378, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2379, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_generage_codes_pool/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2380, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2381, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2382, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2383, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2384, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2385, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2386, 'default', 0, 'crontab/default/jobs/enterprise_giftcardaccount_update_states/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2387, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2388, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2389, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2390, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2391, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2392, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2393, 'default', 0, 'crontab/default/jobs/enterprise_reward_balance_warning_notification/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2394, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2395, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2396, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2397, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2398, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2399, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2400, 'default', 0, 'crontab/default/jobs/enterprise_reward_expire_points/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2401, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2402, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2403, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2404, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2405, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2406, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2407, 'default', 0, 'crontab/default/jobs/enterprise_search_index_reindex_all/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2408, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2409, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2410, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2411, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2412, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2413, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2414, 'default', 0, 'crontab/default/jobs/enterprise_staging_automates/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2415, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2416, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2417, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2418, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2419, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/schedule/cron_expr', '10 23 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2420, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2421, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2422, 'default', 0, 'crontab/default/jobs/enterprise_page_cache_crawler/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2423, 'default', 0, 'crontab/default/jobs/core_clean_cache/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2424, 'default', 0, 'crontab/default/jobs/core_clean_cache/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2425, 'default', 0, 'crontab/default/jobs/core_clean_cache/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2426, 'default', 0, 'crontab/default/jobs/core_clean_cache/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2427, 'default', 0, 'crontab/default/jobs/core_clean_cache/schedule/cron_expr', '30 1 * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2428, 'default', 0, 'crontab/default/jobs/core_clean_cache/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2429, 'default', 0, 'crontab/default/jobs/core_clean_cache/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2430, 'default', 0, 'crontab/default/jobs/core_clean_cache/is_active', '1', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2433, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2434, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2435, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2436, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2437, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/schedule/cron_expr', '*/5 * * * *', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2438, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2439, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2440, 'default', 0, 'crontab/default/jobs/searchsphinx_check_daemon/is_active', '1', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2441, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2442, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2443, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2444, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/schedule/cron_expr', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2445, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2446, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/groups', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2447, 'default', 0, 'crontab/default/jobs/searchsphinx_reindex_job/is_active', '1', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2685, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/name', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2686, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2687, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/short_description', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2688, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/schedule/config_path', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2689, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/parameters', '', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2690, 'default', 0, 'crontab/default/jobs/mailchimp_bulksync_ecommerce_data/is_active', '0', '2020-01-06 14:08:00');
# INSERT INTO a53979e5_csw_mig.core_config_data (config_id, scope, scope_id, path, value, updated_at) VALUES (2815, 'default', 0, 'crontab/default/jobs/enterprise_index_clean_changelog/run/model', 'enterprise_index/cron::scheduledCleanup', '2020-04-15 18:00:44');

# Licence Key Is Invalid For Mconnect Trackorder extension



-- BHS TASK
# Onestepcheckout_Iosc
# php bin/magento module:disable Onestepcheckout_Iosc
# php bin/magento module:enable Onestepcheckout_Iosc
# php bin/magento module:status

-- CSW ADMIN ISSUE TASK
# php bin/magento module:disable Mirasvit_SearchElastic
# php bin/magento module:disable Mirasvit_SearchLanding
# php bin/magento module:disable Mirasvit_Search
# php bin/magento module:disable Mirasvit_SearchAutocomplete
# php bin/magento module:disable Mirasvit_SearchElasticNative
# php bin/magento module:disable Mirasvit_SearchMysql
# php bin/magento module:disable Mirasvit_SearchReport
# php bin/magento module:disable Mconnect_Trackorder

select * from core_config_data
where value like '%domain.com%';
