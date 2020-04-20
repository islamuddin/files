-- ############## NOTE : before running script on m2 for latest changes copy m1 tables with latest into m2 db ############
-- ============= [ store : CSW Store View ] ===================
SELECT * FROM store_website;
SELECT * FROM store; -- WHERE `store_id` = 2;

/*
M2 Categories Analysis ( general sirf total cateogries ka )
Entity Type ID  :   3   FOR CATEGORIES          -> ??? ab in ki url keys kahan hen ??????? Answer: neche isme : catalog_category_entity_varchar with 43 as attribute key
     Store ID   |   Count
    ALL         |   1410    -- DONE ye to match kr gate m1 sy
     0          |   1408    -- DONE
     1          |   2       -- DONE
     2          |   0       -- DONE
*/
select * from catalog_product_entity_varchar;
select * from catalog_category_entity_varchar where attribute_id=41;
select count(*) from catalog_category_entity_varchar where attribute_id=41; -- ALL
select 'catalog_product_entity_varchar' as tbl,'0' as store_id, count(*) from catalog_category_entity_varchar where attribute_id=41 and store_id=0 union all
select 'catalog_product_entity_varchar' as tbl,'1' as store_id, count(*) from catalog_category_entity_varchar where attribute_id=41 and store_id=1 union all
select 'catalog_product_entity_varchar' as tbl,'2' as store_id, count(*) from catalog_category_entity_varchar where attribute_id=41 and store_id=2;

/*  ===================[ catalog_category_entity_varchar ]====================   : Catalog Category Url Key Attribute Backend Table
COLUMNS : value_id,entity_type_id,attribute_id,store_id,entity_id,value
ATTRIBUTE ID    :   43  for category
ENTITY TYPE ID  :   3   for category
    Store       |   COUNT
    All         |   637     /   1408    -- TODO MATCH THESE CATEGORY URL KEYS WITH M1 URL KEYS. Create import script for these category url keys
    0           |   637     /   1406    -- PENDING
    1           |   0       /   0
    2           |   0      /    0
*/

select * from catalog_category_entity_varchar;
select DISTINCT  attribute_id from catalog_category_entity_varchar ;     -- 19
select COUNT(*) from catalog_category_entity_varchar where attribute_id=43; -- 637
select COUNT(*) from catalog_category_entity_varchar WHERE store_id=0 and attribute_id=43;  -- 637
select COUNT(*) from catalog_category_entity_varchar WHERE store_id=1 and attribute_id=43;
select COUNT(*) from catalog_category_entity_varchar WHERE store_id=2 and attribute_id=43;

# _________ ab m1 k table k compare kro ____________    -- TODO add category url keys
-- TODO MATCH THESE CATEGORY URL KEYS WITH M1 URL KEYS. Create import script for these category url keys    : DONE
/* EXTRA CATEGORIES BACKUP
   episcopalian-amp-anglican,inexpensive-banners1,treidentine-latin-mass,communion-roll-cushions,gul
*/
SELECT * FROM rgw_catalog_category_entity_url_key;
select value from catalog_category_entity_varchar where attribute_id=43; -- 637

-- MATCH        |   636 -- ab ye to match hogae ab nikal hen.. ab esi url ki nikalni hen jo m2 url key tabl (catalog_category_entity_varchar where attribute_id=43) me nh he DONE
-- Not Match    |   1  -- ye gul k nam sy extra url key he jo matchi nh hui
-- select COUNT(*) from catalog_category_entity_varchar where attribute_id=43 -- 637
select COUNT(*) from catalog_category_entity_varchar where attribute_id=43 -- 637
AND entity_id in (SELECT DISTINCT entity_id FROM rgw_catalog_category_entity_url_key);

-- 1.ab esi m1 ki url ki jo m2 me nh hen. 2. phir unko import krna he m2 k tabl me : DONE

# 1.ab esi m1 ki url ki jo m2 me nh hen. DONE
-- 772
SELECT count(*) FROM rgw_catalog_category_entity_url_key
where entity_id not in (
    select distinct entity_id from catalog_category_entity_varchar where attribute_id=43
    );

# 2. phir unko import krna he m2 k tabl me DONE
-- INSERT INTO a53979e5_csw_mig.catalog_category_entity_varchar  (attribute_id, store_id, entity_id, value)    VALUES (43, 1, 1, 'root-catalog');
-- INSERT INTO a53979e5_csw_mig.catalog_category_entity_varchar  (attribute_id, store_id, entity_id, value) VALUES ( 43,1,2,'default-category' );
select * from catalog_category_entity_varchar;

SELECT
       concat('INSERT INTO a53979e5_csw_mig.catalog_category_entity_varchar  (attribute_id, store_id, entity_id, value) VALUES ( ',
           attribute_id,',',store_id,',',entity_id,',''',value,''' );') as insert_query
FROM rgw_catalog_category_entity_url_key where entity_id not in (    select distinct entity_id from catalog_category_entity_varchar where attribute_id=43    );

select count(*) from rgw_catalog_category_entity_url_key;
select count(*) from catalog_category_entity_varchar where attribute_id=43;
-- select * from catalog_category_entity_varchar where value like '%root%';

-- ===============================================================================

/*
 M2 URL KEY REPORT for products
Entity Type ID  :   4   FOR PRODUCTS
 Store ID   |   Count
 ALL        |   291302
 0          |   145651  / m1: 130202 ( diff : 15449 )   -- TODO
 1          |   0       / 0
 2          |   0       / 0
*/
select * from catalog_product_entity_varchar;
select * from catalog_product_entity_varchar where attribute_id=97;
select count(*) from catalog_product_entity_varchar where attribute_id=97;
select 'catalog_product_entity_varchar' as tbl,'0' as store_id, count(*) from catalog_product_entity_varchar where attribute_id=97 and store_id=0 union all
select 'catalog_product_entity_varchar' as tbl,'1' as store_id, count(*) from catalog_product_entity_varchar where attribute_id=97 and store_id=1 union all
select 'catalog_product_entity_varchar' as tbl,'2' as store_id, count(*) from catalog_product_entity_varchar where attribute_id=97 and store_id=2;

-- select * from catalog_product_entity_varchar        where attribute_id=97 and store_id=1;
-- delete from catalog_product_entity_varchar        where attribute_id=97 and store_id=1;

-- 1.ab esi m1 ki url ki jo m2 me nh hen. 2. phir unko import krna he m2 k tabl me :

-- 1. backup current category data and delete it : 361 (ye step tb follow kro jb sare scratch sy krne hon. nahin to neche wala 1 chalao)
    -- CREATE TABLE temp_feb_11_catalog_product_entity_varchar_for_product_url_key SELECT * FROM catalog_product_entity_varchar where attribute_id=97; -- 145651
    -- select count(*) from temp_feb_11_catalog_product_entity_varchar_for_product_url_key; -- 145651
    -- delete FROM catalog_product_entity_varchar where attribute_id=97;


# 1.ab esi m1 ki url KEYS for product jo m2 me nh hen.
-- 145651
select count(*) from catalog_product_entity_varchar where attribute_id=97;
select count(*) from rgw_catalog_product_entity_url_key;

-- 249
SELECT count(*) FROM rgw_catalog_product_entity_url_key
SELECT count(*) FROM rgw_catalog_product_entity_url_key
where value not in (
    select DISTINCT value from catalog_product_entity_varchar where attribute_id=97
);

# 2. phir unko import krna he m2 k tabl me DONE
-- INSERT INTO a53979e5_csw_mig.catalog_category_entity_varchar  (attribute_id, store_id, entity_id, value)    VALUES (43, 1, 1, 'root-catalog');
-- INSERT INTO a53979e5_csw_mig.catalog_category_entity_varchar  (attribute_id, store_id, entity_id, value) VALUES ( 43,1,2,'default-category' );
select * from catalog_category_entity_varchar;

SELECT
      concat('INSERT INTO a53979e5_csw_mig.catalog_product_entity_varchar(attribute_id, store_id, entity_id, value) VALUES ( ',attribute_id,',',store_id,',',entity_id,',''',value,''' );') as insert_query
FROM rgw_catalog_product_entity_url_key where entity_id not in (    select distinct entity_id from catalog_product_entity_varchar where attribute_id=97);

-- demo insert
-- INSERT INTO a53979e5_csw_mig.catalog_product_entity_varchar(attribute_id, store_id, entity_id, value) VALUES ( 97,0,2133,'chnat-162-3-1-4-resin-nativity-ornament' );

/*  ===================[ catalog_product_entity_url_key ]====================   : Catalog Product Url Key Attribute Backend Table
COLUMNS : value_id,entity_type_id,attribute_id,store_id,entity_id,value
ATTRIBUTE ID    :   97
ENTITY TYPE ID  :   4
    Store       |   COUNT
    All         |   145900
    0           |   0   /   145900
    1           |   0   /   0
    2           |   0   /   0
*/

# select * from catalog_product_entity_url_key;
# select DISTINCT  entity_type_id from catalog_product_entity_url_key;
# select COUNT(*) from catalog_product_entity_url_key;
# select COUNT(*) from catalog_product_entity_url_key WHERE store_id=0;
# select COUNT(*) from catalog_product_entity_url_key WHERE store_id=1;
# select COUNT(*) from catalog_product_entity_url_key WHERE store_id=2;
# select * from catalog_product_entity_url_key where value like '%19xe212%';

-- __________ PRODUCT URL RE-WRITE WORK STARTS _______________
    SELECT * FROM `url_rewrite` where entity_type='product';
    SELECT count(*) FROM `url_rewrite` where entity_type='product';  -- 169202
    -- 1. backup current category data and delete it : 361
    -- CREATE TABLE temp_feb_11_url_rewrite_for_product SELECT * FROM `url_rewrite` where entity_type='product';  -- 0
    -- select * from temp_feb_11_url_rewrite_for_product; -- 0
    -- delete from  `url_rewrite` where entity_type='product'; -- 0
    -- 2. Import data from m1
    -- verifying existing records in URL rewrite. jo already pare hen unka set exlude krna hoga : 0
    -- SELECT * FROM `url_rewrite` ur WHERE ur.`entity_type` = 'product' and ur.entity_id not in (SELECT rcpeuk.entity_id FROM rgw_catalog_product_entity_url_key rcpeuk ); --0

    -- used this
    -- 169202   = 169008+194 = 169008+194
    SELECT  -- count(*)
            CONCAT('INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES (','''product''',    ',',    SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1),     ',',     '''',    reur.request_path,'''',',','''',reur.target_path,'''',',','''','0',    '''',    ',',    '''',    reur.store_id,    '''',    ',',    'null',    ',',    '''',    '1',    '''',    ',',    'null',');') as url_rewrite_sql_updates
    from rgw_enterprise_url_rewrite  reur where reur.entity_type in (1,3) and SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1) not in  (select ur.entity_id from url_rewrite ur  where ur.entity_type='product'); -- 11188

    -- DOUBLE CHECK WITH THIS QUERY
    SELECT  -- count(*)
             CONCAT('INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES (','''product''',    ',',    SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1),     ',',     '''',    reur.request_path,'''',',','''',reur.target_path,'''',',','''','0',    '''',    ',',    '''',    reur.store_id,    '''',    ',',    'null',    ',',    '''',    '1',    '''',    ',',    'null',');') as url_rewrite_sql_updates
    from rgw_enterprise_url_rewrite  reur where reur.entity_type in (1,3) and target_path not in  (select ur.target_path from url_rewrite ur where ur.entity_type='product'); -- 11188

    SELECT  count(*)    from rgw_enterprise_url_rewrite  reur where reur.entity_type in (1,3);

-- and SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1) not in  (select ur.entity_id from url_rewrite ur); -- 11188

    select request_path    from url_rewrite    where    request_path like '%artwork%';

    SELECT  request_path -- , count(*)
    from rgw_enterprise_url_rewrite  reur where reur.entity_type=2 and SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1) not in  (select ur.entity_id from url_rewrite ur)
    and request_path like '%artwork%'
    group by request_path having count(*)>1;
    ; -- 11188
    --  INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES ('category',2855,'artwork','catalog/category/view/id/2855','0','1',null,'1',null);


-- INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES ('category',334,'holiday/nativity/fontanini-nativities/5-fontanini-life-of-christ','catalog/category/view/id/334','0','1',null,'1',null);

-- errors after import


select * from catalog_category_entity_varchar where attribute_id=97 and entity_id=2185;

-- __________ PRODUCT URL RE-WRITE WORK ENDS _______________

-- ===============================================================================


/*  ===================[ enterprise_url_rewrite ]====================   : URL Rewrite
COLUMNS : url_rewrite_id,request_path,target_path,is_system,guid,identifier,inc,value_id,store_id,entity_type */
-- M1 url rewrite values SUMMARY
-- entity_type =1 ==> products      23260
-- entity_type =2 ==> category      1402
-- entity_type =3 ==> products      145942
select count(*) from rgw_enterprise_url_rewrite where entity_type=1 order by  url_rewrite_id desc ;
select count(*) from rgw_enterprise_url_rewrite where entity_type=2 order by  url_rewrite_id desc ;
select count(*) from rgw_enterprise_url_rewrite where entity_type=3 order by  url_rewrite_id desc ;


select distinct store_id from rgw_enterprise_url_rewrite where entity_type=2 order by  url_rewrite_id desc ;

-- M2 url rewrite values SUMMARY
-- entity_type =    'category'     457
-- entity_type =    'product'      0

select * from url_rewrite where entity_type='category';
select count(*) from url_rewrite where entity_type='category';
select * from url_rewrite where entity_type='product';

select DISTINCT  entity_type from url_rewrite;

-- __________ CATEGORY URL RE-WRITE WORK STARTS _______________
    SELECT * FROM `url_rewrite` where entity_type='category'; -- 1402
    -- 1. backup current category data and delete it : 361
    CREATE TABLE temp_feb_11_url_rewrite_for_category SELECT * FROM `url_rewrite` where entity_type='category';
    select * from temp_jan_16_url_rewrite_for_category; -- 361
  --  delete from  `url_rewrite` where entity_type='category';
    -- 2. Import data from m1
    -- verifying existing records in URL rewrite. jo already pare hen unka set exlude krna hoga : 0
    SELECT * FROM `url_rewrite` ur WHERE ur.`entity_type` = 'category' and ur.entity_id not in (SELECT rcceuk.entity_id FROM rgw_catalog_category_entity_url_key rcceuk );

    -- not used this
    -- SELECT           CONCAT('INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES (','''category''',    ',',    entity_id,     ',',     '''',    value,'''',',','''','catalog/category/view/id/',entity_id,'''',',','''','0',    '''',    ',',    '''',    '1',    '''',    ',',    'null',    ',',    '''',    '1',    '''',    ',',    'null',');') as url_rewrite_sql_updates     FROM rgw_catalog_category_entity_url_key where entity_id not in (select ur.entity_id from url_rewrite ur);
    -- INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES ('product',45832,'7130-pope-john-paul-ii-banner-slb7130','catalog/product/view/id/45832','0','1',null,'1',null);
    -- used this
    SELECT  -- * -- count(*)
            CONCAT('INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES (','''category''',    ',',    SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1),     ',',     '''',    reur.request_path,'''',',','''',reur.target_path,'''',',','''','0',    '''',    ',',    '''',    reur.store_id,    '''',    ',',    'null',    ',',    '''',    '1',    '''',    ',',    'null',');') as url_rewrite_sql_updates
    from rgw_enterprise_url_rewrite  reur where reur.entity_type=2 and SUBSTRING_INDEX(SUBSTRING_INDEX(reur.target_path, '/', 5), '/', -1) not in  (select ur.entity_id from url_rewrite ur where ur.entity_type='category'); -- 11188

    -- demo insert : SUCCESS
    -- INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES ('category',182,'holiday','catalog/category/view/id/182','0','1',null,'1',null);


-- INSERT INTO url_rewrite (entity_type, entity_id, request_path,target_path, redirect_type,store_id,description,is_autogenerated,metadata) VALUES ('category',334,'holiday/nativity/fontanini-nativities/5-fontanini-life-of-christ','catalog/category/view/id/334','0','1',null,'1',null);
-- errors after import
# ERROR 1062 (23000) at line 1337 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1338 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/angels-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1339 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/christ-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1340 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/custom-wood-reliefs-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1341 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/divine-mercy-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1342 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/holy-family-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1343 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/inspirational-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1344 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/large-canvases-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1345 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/last-supper-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1346 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/mary-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1347 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/plaques-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1348 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/popes-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1349 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/prints-and-posters-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1350 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/sacred-heart-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1351 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/saints-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1352 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'artwork/triptych-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# ERROR 1062 (23000) at line 1358 in file: 'url_rewrite_missing_import_11_feb.sql': Duplicate entry 'sale-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'


select * from catalog_category_entity_varchar where attribute_id=97 and entity_id=2185;

-- __________ CATEGORY URL RE-WRITE WORK ENDS ________________


/*ENTITY TYPE ID  :   ALL       1           2       3
    Store       |   COUNT
    All         |   170604  = 23260 +   1402    +   145942      = 170604
    0           |   146156  = 214   +   0       +   145942      = 146156
    1           |   8313    = 7617  +   696     +   0           = 8313
    2           |   16135   = 15429 +   706     +   0           = 16135
*/

select * from enterprise_url_rewrite;
select COUNT(*) from enterprise_url_rewrite;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=0;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=1;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=2;

/*ENTITY TYPE ID  :   1
    Store       |   COUNT
    All         |   23260
    0           |   214
    1           |   7617
    2           |   15429
*/
select COUNT(*) from enterprise_url_rewrite WHERE entity_type=1;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=0 AND entity_type=1;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=1 AND entity_type=1;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=2 AND entity_type=1;
/*ENTITY TYPE ID  :   2
    Store       |   COUNT
    All         |   1402
    0           |   0
    1           |   696
    2           |   706
*/
select COUNT(*) from enterprise_url_rewrite WHERE entity_type=2;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=0 AND entity_type=2;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=1 AND entity_type=2;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=2 AND entity_type=2;
/*ENTITY TYPE ID  :   3
    Store       |   COUNT
    All         |   145942
    0           |   145942
    1           |   0
    2           |   0
*/
select COUNT(*) from enterprise_url_rewrite WHERE entity_type=3;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=0 AND entity_type=3;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=1 AND entity_type=3;
select COUNT(*) from enterprise_url_rewrite WHERE store_id=2 AND entity_type=3;

-- ===================================================================

select count(*) from enterprise_url_rewrite;
select * from catalog_product_entity_varchar where entity_id=2691 and attribute_id in (97,71)  and store_id=0;
select * from enterprise_url_rewrite where store_id=0 and entity_type=3;
select * from catalog_product_entity_int where entity_id=191721 and attribute_id=1509 and store_id=0 order by value_id desc;

show triggers;

-- SELECT * FROM `catalog_product_entity` WHERE 1
select *
from a53979e5_csm1.m2_cl_catalog_product_entity_int rm2ccpei
inner join a53979e5_csw_mig.catalog_product_entity cpe
on rm2ccpei.value_id=cpe.value_id
-- where entity_id=191721 and attribute_id=1509 and store_id=0 order by value_id desc;








select * from url_rewrite;
-- ======== [ CREATE TRIGGERS STARTS] =================
-- DROP TRIGGER IF EXISTS watch_url_rewrite;
-- drop table tbl_notifications;

# drop table magento1;
# CREATE TABLE magento1 (
# id     int auto_increment primary key comment 'ID',
# name     varchar(1000)  comment 'Name'
# );
# insert into magento1(name) values('ali');
# insert into magento1(name) values('wali');
# insert into magento1(name) values('khan');
# select * from magento1;
-- ========================================
CREATE TABLE tbl_notifications (
id     int auto_increment primary key comment 'ID',
table_name     varchar(1000)  comment 'Table Name'
);
select * from tbl_notifications;
-- url_rewrite
-- drop table watch_url_rewrite
DELIMITER $$ CREATE TRIGGER watch_url_rewrite    AFTER INSERT    ON url_rewrite FOR EACH ROW BEGIN
    insert into tbl_notifications(table_name) values('url_rewrite');
END $$ DELIMITER ;
-- catalog_product_entity_varchar
-- drop table watch_catalog_product_entity_varchar
DELIMITER $$ CREATE TRIGGER watch_catalog_product_entity_varchar    AFTER INSERT    ON catalog_product_entity_varchar FOR EACH ROW BEGIN
    insert into tbl_notifications(table_name) values('catalog_product_entity_varchar');
END $$ DELIMITER ;


-- ======== [ CREATE TRIGGERS ENDS] =================

/*
ls a53979e5_csw_mig_b4_change_10_feb.sql -alh
ls a53979e5_csw_mig_url_rewrite_b4_change_10_feb.sql -alh
ls a53979e5_csw_mig_catalog_category_entity_varchar_b4_change_10_feb.sql -alh
ls a53979e5_csw_mig_catalog_product_entity_varchar_b4_change_10_feb.sql -alh

mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig>a53979e5_csw_mig_b4_gul_change_20_feb.sql
mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig>a53979e5_csw_mig_b4_gul_change2_20_feb.sql

mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig>a53979e5_csw_mig_b4_id_change_27_feb.sql

mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig>a53979e5_csw_mig_b4_change_10_feb.sql
mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig url_rewrite>a53979e5_csw_mig_url_rewrite_b4_change_10_feb.sql
mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig catalog_category_entity_varchar>a53979e5_csw_mig_catalog_category_entity_varchar_b4_change_10_feb.sql
mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig catalog_product_entity_varchar>a53979e5_csw_mig_catalog_product_entity_varchar_b4_change_10_feb.sql

mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig url_rewrite>a53979e5_csw_mig_url_rewrite_b4_change_20_feb.sql

*/

/*
vi a53979e5_csm1_rgw_enterprise_url_rewrite_10_feb.sql
vi a53979e5_csm1_rgw_catalog_category_entity_url_key_10_feb.sql
vi a53979e5_csm1_rgw_catalog_product_entity_url_key_10_feb.sql

select * from rgw_enterprise_url_rewrite
select * from rgw_enterprise_url_rewrite


mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1 rgw_enterprise_url_rewrite>a53979e5_csm1_rgw_enterprise_url_rewrite_10_feb.sql
mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1 rgw_catalog_category_entity_url_key>a53979e5_csm1_rgw_catalog_category_entity_url_key_10_feb.sql
mysqldump -ua53979e5_csm1 -pPennyCloySecedeRues14 a53979e5_csm1 rgw_catalog_product_entity_url_key>a53979e5_csm1_rgw_catalog_product_entity_url_key_10_feb.sql
*/



-- source  a53979e5_csm1_rgw_enterprise_url_rewrite_10_feb.sql
-- source  a53979e5_csm1_rgw_catalog_category_entity_url_key_10_feb.sql
-- source a53979e5_csm1_rgw_catalog_product_entity_url_key_10_feb.sql

select count(*) as count from rgw_enterprise_url_rewrite
union all
select count(*) as count  from rgw_catalog_category_entity_url_key
union all
select count(*) as count  from  rgw_catalog_product_entity_url_key;


SELECT distinct  store_id FROM `url_rewrite` where entity_type='product' and store_id;

SELECT * FROM `url_rewrite` where entity_type='product' and store_id=2;
select * from url_rewrite where entity_type='category';

select * from catalog_url_rewrite_product_category;

# select * from review_entity
# select * from review
# select * from review_detail
# select * from review_status



-- target path      catalog/product/view/id/4019/category/2223
-- request path     holiday-sacraments/advent-wreaths-candles/cc01-100-12-advent-candle-refill-pack-4.html

-- one product test data
select * from url_rewrite where url_rewrite_id=169882
select * from url_rewrite where url_rewrite_id=169882
select * from catalog_product_entity_varchar where attribute_id=97 and entity_id=4019;
-- INSERT INTO catalog_url_rewrite_product_category (url_rewrite_id, category_id, product_id) VALUES (169882, 2223, 4019);

--  find . -name "*a-2017g.jpg"
select entity_id,' ' from catalog_product_entity where entity_id>=191918

select * from eav_attribute where entity_type_id=4 and attribute_code='media_gallery';
select count(*) from catalog_product_entity_media_gallery cpemg;


select cpemg.* from catalog_product_entity_media_gallery cpemg
inner join catalog_product_entity_media_gallery_value cpemgv on cpemg.value_id=cpemgv.value_id
where attribute_id=88
  and cpemgv.entity_id=3313


and value like '%CC04-2-14%'
order by value_id desc;


select * from catalog_product_entity_varchar where entity_id=191918;

-- ============ [ CSW IMAGE ISSUE ] =======================
-- mysql -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig
select count(*) as count from rgw_catalog_product_entity_media_gallery union select count(*) as count from rgw_catalog_product_entity_media_gallery_value;
-- bakup tables
-- mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig catalog_product_entity_media_gallery catalog_product_entity_media_gallery_value_to_entity catalog_product_entity_media_gallery_value >a53979e5_csw_mig_media_table_feb_14.sql

-- select count(*) from catalog_product_entity_media_gallery;
-- mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig >a53979e5_csw_mig_media_table_feb_14.sql
-- delete from catalog_product_entity_media_gallery where 1=1;

-- add column enity_id  temprorarily
-- alter table catalog_product_entity_media_gallery	add entity_id int null;


select count(*) from catalog_product_entity_media_gallery;
    select concat('insert into catalog_product_entity_media_gallery( value_id, attribute_id, value, media_type, disabled,entity_id ) values(',value_id,',',attribute_id,',''',value,''',','''image'',', 0,',',entity_id,');') as insert_query
    from a53979e5_csw_mig.rgw_catalog_product_entity_media_gallery;
-- mysql -e "select concat('insert into catalog_product_entity_media_gallery( value_id, attribute_id, value, media_type, disabled,entity_id ) values(',value_id,',',attribute_id,',''',value,''',','''image'',', 0,',',entity_id,');') as insert_query     from a53979e5_csw_mig.rgw_catalog_product_entity_media_gallery " -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig > a53979e5_csw_mig_media_table_feb_14.sql

select * from  catalog_product_entity_media_gallery_value_to_entity;
    select value_id,entity_id from rgw_catalog_product_entity_media_gallery;
    select value_id,entity_id from catalog_product_entity_media_gallery;

    INSERT INTO catalog_product_entity_media_gallery_value_to_entity
    select value_id,entity_id from rgw_catalog_product_entity_media_gallery;

-- truncate table catalog_product_entity_media_gallery_value;
 select * from catalog_product_entity_media_gallery_value;
-- value_id, store_id, entity_id, label, position, disabled, record_id PK  |   2218, 0, 2133, null, 1, 0, 1
SET FOREIGN_KEY_CHECKS=0;

    --
    select   concat('INSERT INTO catalog_product_entity_media_gallery_value (value_id, store_id, entity_id, label, position, disabled) VALUES (',value_id,',',store_id,',','9999',',',COALESCE(label, '''9999'''),',', position,',', disabled,');') as insert_query     from rgw_catalog_product_entity_media_gallery_value;
    -- value_id, store_id, label, position, disabled                        |   2218, 0, null, 1, 0
    -- chali hi nahin
    -- mysql -e " select   concat('INSERT INTO catalog_product_entity_media_gallery_value (value_id, store_id, entity_id, label, position, disabled) VALUES (',value_id,'','',store_id,'','',''9999'','','',COALESCE(label, ''9999''),'','', position,'','', disabled,'');'') as insert_query     from rgw_catalog_product_entity_media_gallery_value " -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig > a53979e5_csw_mig_media_table2_feb_14.sql

    -- ye chal gai but isme entity_id ka value set nahin wo update krna h alag sy
    INSERT into catalog_product_entity_media_gallery_value    select   value_id, store_id, '9999' as entity_id, label, position, disabled, null as record_id     from rgw_catalog_product_entity_media_gallery_value;
   --  update catalog_product_entity_media_gallery_value set entity_id;

    --  update entity_id  in gallery value now DONE
    # update catalog_product_entity_media_gallery_value
    # set entity_id=(
    #     select entity_id from catalog_product_entity_media_gallery_value_to_entity a where a.value_id=catalog_product_entity_media_gallery_value.value_id
    #     )
    # where value_id in (
    #     select cpemgvte.value_id from catalog_product_entity_media_gallery_value_to_entity cpemgvte
    #     where cpemgvte.entity_id is not null
    #     );

-- ab sare kam hogae ab entity_id column hata he catalog_product_entity_media_gallery value table sy DONE
    -- alter table catalog_product_entity_media_gallery drop column entity_id;

    SELECT * FROM eav_attribute where attribute_id in (85,86,87,88);
    SELECT * FROM eav_attribute where entity_type_id=4;

select ev.entity_id,ev.value , mg.value, ev.attribute_id from
              catalog_product_entity_media_gallery AS mg,
              catalog_product_entity_media_gallery_value AS mgv,
              catalog_product_entity_varchar AS ev
WHERE  mg.value_id = mgv.value_id
AND mgv.entity_id = ev.entity_id
AND ev.attribute_id IN (85, 86, 87)
AND mgv.position = 1;

-- BACKUP Done
-- CREATE TABLE temp_feb_16_catalog_product_entity_varchar         SELECT * FROM catalog_product_entity_varchar; -- 145651

-- UPDATE TABLE for small, thumbnail images. Done
#  UPDATE
#         catalog_product_entity_media_gallery AS mg,
#         catalog_product_entity_media_gallery_value AS mgv,
#         catalog_product_entity_varchar AS ev
# SET
#         ev.value = mg.value
# WHERE
#         mg.value_id = mgv.value_id
# AND     mgv.entity_id = ev.entity_id
# AND     ev.attribute_id IN (85, 86, 87)
# AND     mgv.position = 1;

-- product images varchar table surgery. wow images k reference yahan bhi pare hote hen.
select * from catalog_product_entity_varchar cpev  where cpev.attribute_id in (85,86,87,88);





    select * from catalog_product_entity_media_gallery where attribute_id=88;
    select * from catalog_product_entity_media_gallery_value_to_entity; --    where entity_id not in (select catalog_product_entity.entity_id from catalog_product_entity);
    select * from catalog_product_entity_media_gallery_value where entity_id not in (select catalog_product_entity.entity_id from catalog_product_entity);
    -- update catalog_product_entity_media_gallery_value set entity_id =2133 where entity_id=9999
    -- select * from rgw_catalog_product_entity_media_gallery_value



-- 68038 itni products ki images missing hen m2
select * from catalog_product_entity cpe
where cpe.entity_id not in (    select distinct cpemgvte.entity_id from catalog_product_entity_media_gallery cpemg    inner join catalog_product_entity_media_gallery_value_to_entity cpemgvte on cpemg.value_id=cpemgvte.value_id    );

-- 68038 itni products ki images missing hen m1 bhi
select * from catalog_product_entity cpe
where cpe.entity_id not in (    select distinct rcpemg.entity_id from rgw_catalog_product_entity_media_gallery rcpemg    );

-- testing images after import
-- testing thru m2
select distinct cpemg.value from catalog_product_entity_media_gallery cpemg
inner join catalog_product_entity_media_gallery_value_to_entity cpemgvte on cpemg.value_id=cpemgvte.value_id
-- inner join catalog_product_entity_media_gallery_value cpemgv on cpemgv.value_id=cpemgv.value_id
where cpemgvte.entity_id=2691;

select * from catalog_product_entity_media_gallery_value where entity_id=3496;

select entity_id, count(entity_id) from catalog_product_entity_media_gallery_value -- where entity_id=2691
group by entity_id having count(entity_id)>1;


-- testing thru m1
select * from rgw_catalog_product_entity_media_gallery where entity_id=2691;
-- ye 2133 me 9999 wale bhi dal diye hen to testing k ktne gae hen new or asal ktne pare the
select * from catalog_product_entity_media_gallery_value where entity_id=2133; -- 3813 -1 =3812 gae hen extra
select * from rgw_catalog_product_entity_media_gallery where entity_id=2133; -- 1 k again 300 dal diye hen :D
select * from rgw_catalog_product_entity_media_gallery_value  where value_id=2218;

-- TODO : ES ID K AGAINST DEKHTA HE M1/M2 ME IMAGES HN : 187998



-- ==============[ images work done /ends ] =========================================================================================

-- ==============[ Starts CSW | Product Related Data: SEO extension attributes are empty ] ================================================
-- task link : https://plumtreeinc.teamwork.com/#/tasks/15550082
/*
INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code) VALUES (82, 4, 'meta_title');
INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code) VALUES (1491, 4, 'meta_robots');
INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code) VALUES (83, 4, 'meta_keyword');
INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code) VALUES (84, 4, 'meta_description');
*/
select * from eav_entity_type;
select * from eav_attribute where entity_type_id=4 and attribute_code like '%meta_%' order by attribute_id;
select * from eav_attribute where entity_type_id=4 and attribute_code like '%seo_%' order by attribute_id;
select * from eav_attribute where entity_type_id=4 and note like '%MageWorx%';

select * from eav_attribute where entity_type_id=4 and attribute_code in ('meta_title','meta_keyword','meta_description','canonical_url','canonical_cross_domain');


select distinct attribute_id from catalog_product_entity_varchar where attribute_id in (1490,1489,84,83,82);
select count(*) from catalog_product_entity_varchar where attribute_id in (1490,1489,84,83,82);
select * from catalog_category_entity_varchar where attribute_id in (1490,1489,84,83,82);

-- 1226 matched : 1205 and not matched 21 or ye 21 shyd pravin walon ne daly hen
select * from eav_attribute where entity_type_id=4
                                     and attribute_code not in (
    select distinct attribute_code from rgw_eav_attribute where entity_type_id=4 order by attribute_id
    )
-- m1 k seo k attribute to already m2 moojood hen koi ziada gap nh
select * from rgw_eav_attribute where entity_type_id=4
                                     and attribute_code not in (
    select distinct attribute_code from eav_attribute where entity_type_id=4 order by attribute_id
    )
-- ab varcahr check hoga
select * from catalog_product_entity_varchar cpev
where cpev.attribute_id not in
(select distinct  attribute_id from rgw_eav_attribute where entity_type_id=4 and attribute_id in (        select distinct attribute_id from rgw_catalog_product_entity_varchar        ));

select * from rgw_catalog_product_entity_varchar where value like '%worx%';
select * from eav_attribute where entity_type_id=4 and note like '%MageWorx%';
select * from rgw_eav_attribute where entity_type_id=4 and note like '%MageWorx%';
-- MageWorx

# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (2887, 4, 'cross_domain_store', null, null, 'int', null, null, 'select', 'Cross Domain Store', null, 'MageWorx\\SeoBase\\Model\\Source\\CrossDomainStore', 0, 0, null, 0, 'This setting was added by MageWorx SEO Suite');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (2888, 4, 'cross_domain_url', null, null, 'varchar', null, null, 'text', 'Cross Domain URL', 'validate-url', null, 0, 0, null, 0, 'This setting was added by MageWorx SEO Suite');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (72, 4, 'description', null, null, 'text', null, null, 'textarea', 'Description', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "description" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (2885, 4, 'in_html_sitemap', null, 'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean', 'int', null, null, 'select', 'Include in HTML Sitemap', null, 'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean', 0, 0, '1', 0, 'This setting was added by MageWorx HTML Sitemap');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (2891, 4, 'in_xml_sitemap', null, 'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean', 'int', null, null, 'select', 'Include in XML Sitemap', null, 'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean', 0, 0, '1', 0, 'This setting was added by MageWorx XML Sitemap');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (84, 4, 'meta_description', null, null, 'varchar', null, null, 'textarea', 'Meta Description', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "meta_description" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (83, 4, 'meta_keyword', null, null, 'text', null, null, 'textarea', 'Meta Keywords', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "meta_keyword" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (1491, 4, 'meta_robots', null, null, 'varchar', null, null, 'select', 'Meta Robots', null, 'MageWorx\\SeoAll\\Model\\Source\\MetaRobots', 0, 0, null, 0, 'This setting was added by MageWorx SEO Suite');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (82, 4, 'meta_title', null, null, 'varchar', null, null, 'text', 'Meta Title', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "meta_title" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (1497, 4, 'product_seo_name', null, null, 'varchar', null, null, 'text', 'SEO Name', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "product_seo_name" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (73, 4, 'short_description', null, null, 'text', null, null, 'textarea', 'Short Description', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "short_description" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (97, 4, 'url_key', null, null, 'varchar', null, null, 'text', 'URL Key', null, null, 0, 0, null, 0, 'Note: Switch to a store view level to see the "url_key" attribute generated by MageWorx templates.');
# INSERT INTO a53979e5_csw_mig.eav_attribute (attribute_id, entity_type_id, attribute_code, attribute_model, backend_model, backend_type, backend_table, frontend_model, frontend_input, frontend_label, frontend_class, source_model, is_required, is_user_defined, default_value, is_unique, note) VALUES (2889, 4, 'use_in_crosslinking', null, 'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean', 'int', null, null, 'select', 'Use in Cross Linking', null, 'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean', 0, 0, '1', 0, 'This setting was added by MageWorx SEO Cross Links');

-- ==============[ Ends CSW | Product Related Data: SEO extension attributes are empty ] ================================================

-- ==============[ Starts CSW | Pravin Attributes Work ] ================================================
-- Backup before changes : Done
-- mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig eav_attribute eav_attribute_option eav_attribute_option_value eav_attribute_option_swatch>a53979e5_csw_mig_option_value_tables_18_feb.sql

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id
AND eav.attribute_id =832;

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov
WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =832 and ov.store_id=0;

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov
WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =882 and ov.store_id=0;

-- moved 1 attribute values
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1319, 0, 0, '10" x 8"');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1320, 0, 0, '16" x 20"');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1321, 0, 0, '12" x 15"');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1322, 0, 0, '8" x 10"');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1323, 0, 0, '20" x 16"');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1324, 0, 0, '15" x 12"');

-- moving another
SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id
AND eav.attribute_id =833;

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov
WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =833 and ov.store_id=0;

# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1325, 0, 0, 'Antique Gold Rope');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1326, 0, 0, 'Cherry Satin');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1327, 0, 0, 'Black Satin');
# INSERT INTO eav_attribute_option_swatch(option_id, store_id, TYPE, value) VALUES (1328, 0, 0, 'Antique Cherry');

-- ab bul k me
SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id
AND eav.attribute_id in (845,
846,
847,
848,
849,
850,
851,
852,
853,
854,
855,
856,
857,
858,
859,
860,
861,
862,
863,
864,
865,
866,
867,
868,
869,
870,
871,
872,
873,
874,
877,
878,
879,
880,
881,
883,
886,
887,
888,
889,
890,
891,
892,
893,
894,
895,
896,
897,
898,
899,
900,
901,
902,
903,
904,
905,
906,
907,
908,
909,
910,
911,
912,
913,
914,
915,
916,
917,
918,
919,
920,
921,
922,
923,
924,
925,
926,
927,
928,
929,
930,
931,
932,
933,
934,
935,
936,
937,
938,
939,
1270,
1271,
1272,
1273,
1274,
1275,
1276,
1277,
1278,
1279,
1280,
1281,
1282,
1283,
1284,
1285,
1286,
1287,
1288,
1289,
1290,
1291,
1292,
1293,
1294,
1295,
1296,
1297,
1298,
1299,
1300,
1301,
1302,
1303,
1304,
1305,
1306,
1307,
1308,
1309,
1310,
1311,
1312,
1313,
1314,
1315,
1316,
1317,
1318,
1319,
1320,
1321,
1322,
1323,
1324,
1325,
1326,
1327,
1328,
1329,
1330,
1331,
1332,
1333,
1334,
1335,
1336,
1337,
1338,
1339,
1340,
1341,
1342,
1343,
1344,
1345,
1346,
1347,
1348,
1349,
1350,
1351,
1352,
1353,
1354,
1355,
1356,
1357,
1358,
1359,
1360,
1361,
1362,
1363,
1364,
1365,
1366,
1367,
1368,
1369,
1370,
1371,
1372,
1373,
1374,
1375,
1376,
1377,
1378,
1379,
1380,
1381,
1382,
1383,
1384,
1385,
1386,
1387,
1388,
1389,
1390,
1391,
1392,
1393,
1394,
1451,
1483);

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value, eav.attribute_id
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov
WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id in (
845,
846,
847,
848,
849,
850,
851,
852,
853,
854,
855,
856,
857,
858,
859,
860,
861,
862,
863,
864,
865,
866,
867,
868,
869,
870,
871,
872,
873,
874,
877,
878,
879,
880,
881,
883,
886,
887,
888,
889,
890,
891,
892,
893,
894,
895,
896,
897,
898,
899,
900,
901,
902,
903,
904,
905,
906,
907,
908,
909,
910,
911,
912,
913,
914,
915,
916,
917,
918,
919,
920,
921,
922,
923,
924,
925,
926,
927,
928,
929,
930,
931,
932,
933,
934,
935,
936,
937,
938,
939,
1270,
1271,
1272,
1273,
1274,
1275,
1276,
1277,
1278,
1279,
1280,
1281,
1282,
1283,
1284,
1285,
1286,
1287,
1288,
1289,
1290,
1291,
1292,
1293,
1294,
1295,
1296,
1297,
1298,
1299,
1300,
1301,
1302,
1303,
1304,
1305,
1306,
1307,
1308,
1309,
1310,
1311,
1312,
1313,
1314,
1315,
1316,
1317,
1318,
1319,
1320,
1321,
1322,
1323,
1324,
1325,
1326,
1327,
1328,
1329,
1330,
1331,
1332,
1333,
1334,
1335,
1336,
1337,
1338,
1339,
1340,
1341,
1342,
1343,
1344,
1345,
1346,
1347,
1348,
1349,
1350,
1351,
1352,
1353,
1354,
1355,
1356,
1357,
1358,
1359,
1360,
1361,
1362,
1363,
1364,
1365,
1366,
1367,
1368,
1369,
1370,
1371,
1372,
1373,
1374,
1375,
1376,
1377,
1378,
1379,
1380,
1381,
1382,
1383,
1384,
1385,
1386,
1387,
1388,
1389,
1390,
1391,
1392,
1393,
1394,
1451,
1483
    )

  and ov.store_id=0;

select * from catalog_product_entity_varchar where attribute_id=871


select * from eav_attribute where entity_type_id=4;

-- SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value
SELECT entity_type_id,
       attribute_code,
       attribute_model,
       backend_model,
       backend_type,
       backend_table,
       frontend_model,
       frontend_input,
       frontend_label,
       frontend_class,
       source_model,
       is_required,
       is_user_defined,
       default_value,
       is_unique,
       note,
       sort_order,
       value_id,
       store_id,
       value
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov
WHERE eav.attribute_id = opt.attribute_id
AND opt.option_id = ov.option_id AND eav.attribute_id =871
order by ov.value;

SELECT entity_type_id,
       attribute_code,
       attribute_model,
       backend_model,
       backend_type,
       backend_table,
       frontend_model,
       frontend_input,
       frontend_label,
       frontend_class,
       source_model,
       is_required,
       is_user_defined,
       default_value,
       is_unique,
       note,
       sort_order,
       store_id,
       value
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov
WHERE eav.attribute_id = opt.attribute_id
AND opt.option_id = ov.option_id AND eav.attribute_id =871
order by ov.value;

SELECT opt.option_id, ov.store_id, 0 AS TYPE , ov.value , ov.value_id
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =871

-- delete duplicated
SELECT ov.*
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_swatch ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =871
order by value,ov.option_id;

SELECT ov.*
FROM eav_attribute eav, eav_attribute_option opt, eav_attribute_option_value ov WHERE eav.attribute_id = opt.attribute_id AND opt.option_id = ov.option_id AND eav.attribute_id =871
order by value,ov.option_id;

-- neche data rakhi eav_attribute_option_swatch isme he par change hostki he us sy
-- backup for deleted option ids
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (865, 1414, 0, 0, '00801');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (867, 1628, 0, 0, '00801');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (864, 1413, 0, 0, '01802');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (868, 1629, 0, 0, '01802');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (863, 1412, 0, 0, '02804');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (869, 1630, 0, 0, '02804');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (870, 1631, 0, 0, '03805');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (862, 1411, 0, 0, '03805');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (871, 1632, 0, 0, '04807');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (861, 1410, 0, 0, '04807');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (872, 1633, 0, 0, '05808');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (860, 1409, 0, 0, '05808');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (873, 1634, 0, 0, '07810');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (859, 1408, 0, 0, '07810');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (858, 1407, 0, 0, '1 1/16"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (857, 1406, 0, 0, '1 1/2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (856, 1405, 0, 0, '1 1/2" x 1 1/2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (855, 1404, 0, 0, '1 1/2" x 3"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (854, 1403, 0, 0, '1 1/4"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (853, 1402, 0, 0, '1 1/8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (852, 1401, 0, 0, '1 15/16"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (851, 1400, 0, 0, '1 3/4"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (850, 1399, 0, 0, '1"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (849, 1398, 0, 0, '10 3/4"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (848, 1397, 0, 0, '10"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (847, 1396, 0, 0, '12"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (846, 1395, 0, 0, '15803');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (845, 1394, 0, 0, '2 1/16"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (844, 1393, 0, 0, '2 1/2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (843, 1392, 0, 0, '2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (842, 1391, 0, 0, '2" x 1 1/2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (841, 1390, 0, 0, '2" x 3"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (840, 1389, 0, 0, '3 1/2"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (839, 1388, 0, 0, '3"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (874, 4698, 0, 0, '3" x 1 1/8" Christ Candle');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (838, 1387, 0, 0, '3.5"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (837, 1386, 0, 0, '35806');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (836, 1385, 0, 0, '4"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (835, 1384, 0, 0, '5 5/8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (834, 1383, 0, 0, '5"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (833, 1382, 0, 0, '55809');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (832, 1381, 0, 0, '6 5/8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (831, 1380, 0, 0, '6"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (830, 1379, 0, 0, '65809');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (829, 1378, 0, 0, '7 1/4"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (828, 1377, 0, 0, '7"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (827, 1376, 0, 0, '7/8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (876, 4700, 0, 0, '7/8" - 10/24');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (875, 4699, 0, 0, '7/8" - 5/16-18');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (826, 1375, 0, 0, '8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (825, 1374, 0, 0, '9 3/8"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (824, 1373, 0, 0, '9"');
# INSERT INTO a53979e5_csw_mig.eav_attribute_option_swatch (swatch_id, option_id, store_id, type, value) VALUES (866, 1627, 0, 0, 'All Purpose');

select * from eav_attribute_option_swatch
select * from eav_attribute_set

-- --- Useful direct SQL queries for Magento 2 developers
-- Entity type id = 4 -> The product entity
SELECT attribute_set_id FROM `eav_attribute_set` WHERE entity_type_id = 4 and attribute_set_name = 'Default';

SELECT attribute_group_id FROM `eav_attribute_group` WHERE attribute_group_code = 'iyngaran' AND attribute_set_id = '4';

-- attribute_set_id = '4' // the default attribute set
-- attribute_code = 'iyngaran_pro_val'
-- attribute_group_code = 'iyngaran'
-- UPDATE `eav_entity_attribute`
-- SET `attribute_group_id` = (SELECT attribute_group_id FROM `eav_attribute_group` WHERE attribute_group_code = 'iyngaran' AND attribute_set_id = '4')
WHERE `eav_entity_attribute`.`attribute_id` = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'iyngaran_pro_val');

SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'acfp_candles_size_1';
SELECT * FROM eav_entity_attribute WHERE `eav_entity_attribute`.`attribute_id` = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'acfp_candles_size_1');
SELECT * FROM `eav_attribute_group` WHERE attribute_group_id = '98' AND attribute_set_id = '16';


-- First find out the entity_type_id for the custom attribute.
SELECT entity_type_id FROM `eav_entity_type` WHERE `entity_type_code` = 'catalog_product';

--  and then delete attribute option values using entity_type_id and attribute_code.
-- DELETE FROM eav_attribute_option_value WHERE option_id IN (SELECT option_id FROM eav_attribute_option WHERE attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'iyn_product_option' AND entity_type_id = 4))

--  and then delete attribute option swatches using entity_type_id and attribute_code.
-- DELETE FROM eav_attribute_option_swatch WHERE option_id IN (SELECT option_id FROM eav_attribute_option WHERE attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'iyn_product_option' AND entity_type_id = 4))

--  and then delete attribute label using entity_type_id and attribute_code.
-- DELETE FROM eav_attribute_label WHERE attribute_id IN (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'iyn_product_option' AND entity_type_id = 4)

--  and then delete attribute options using entity_type_id and attribute_code.
-- DELETE FROM eav_attribute_option WHERE attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'iyn_product_option' AND entity_type_id = 4)

--  and finally, delete the attribute using entity_type_id and attribute_code.
-- DELETE FROM eav_attribute WHERE attribute_code = 'iyn_product_option' AND entity_type_id = 4;





-- SET FOREIGN_KEY_CHECKS = 0;
# TRUNCATE TABLE `catalog_product_bundle_option`;
# TRUNCATE TABLE `catalog_product_bundle_option_value`;
# TRUNCATE TABLE `catalog_product_bundle_selection`;
# TRUNCATE TABLE `catalog_product_entity_datetime`;
# TRUNCATE TABLE `catalog_product_entity_decimal`;
# TRUNCATE TABLE `catalog_product_entity_gallery`;
# TRUNCATE TABLE `catalog_product_entity_int`;
# TRUNCATE TABLE `catalog_product_entity_media_gallery`;
# TRUNCATE TABLE `catalog_product_entity_media_gallery_value`;
# TRUNCATE TABLE `catalog_product_entity_text`;
# TRUNCATE TABLE `catalog_product_entity_tier_price`;
# TRUNCATE TABLE `catalog_product_entity_varchar`;
# TRUNCATE TABLE `catalog_product_link`;
# TRUNCATE TABLE `catalog_product_link_attribute`;
# TRUNCATE TABLE `catalog_product_link_attribute_decimal`;
# TRUNCATE TABLE `catalog_product_link_attribute_int`;
# TRUNCATE TABLE `catalog_product_link_attribute_varchar`;
# TRUNCATE TABLE `catalog_product_link_type`;
# TRUNCATE TABLE `catalog_product_option`;
# TRUNCATE TABLE `catalog_product_option_price`;
# TRUNCATE TABLE `catalog_product_option_title`;
# TRUNCATE TABLE `catalog_product_option_type_price`;
# TRUNCATE TABLE `catalog_product_option_type_title`;
# TRUNCATE TABLE `catalog_product_option_type_value`;
# TRUNCATE TABLE `catalog_product_super_attribute_label`;
# TRUNCATE TABLE `catalog_product_super_attribute`;
# TRUNCATE TABLE `catalog_product_super_link`;
# TRUNCATE TABLE `catalog_product_website`;
# TRUNCATE TABLE `catalog_category_product_index`;
# TRUNCATE TABLE `catalog_category_product`;
# TRUNCATE TABLE `cataloginventory_stock_item`;
# TRUNCATE TABLE `cataloginventory_stock_status`;
# TRUNCATE TABLE `cataloginventory_stock`;
# TRUNCATE TABLE `catalog_product_entity`;
-- INSERT INTO `catalog_product_link_type`(`link_type_id`,`code`) VALUES (1,'relation'),(2,'bundle'),(3,'super'),(4,'up_sell'),(5,'cross_sell');
-- INSERT INTO `catalog_product_link_attribute`(`product_link_attribute_id`,`link_type_id`,`product_link_attribute_code`,`data_type`) VALUES (1,2,'qty','decimal'),(2,1,'position','int'),(3,4,'position','int'),(4,5,'position','int'),(6,1,'qty','decimal'),(7,3,'position','int'),(8,3,'qty','decimal');
-- INSERT INTO `cataloginventory_stock`(`stock_id`,`website_id`,`stock_name`) VALUES (1,0,'Default');
-- SET FOREIGN_KEY_CHECKS = 1;

SELECT entity_id FROM `catalog_product_entity_int`
WHERE attribute_id = (
SELECT attribute_id FROM `eav_attribute`
WHERE `attribute_code` LIKE 'acfp_candles_size_1'
) AND `catalog_product_entity_int`.value = 2;

select
`eav_attribute`.`attribute_id` AS `attribute_id`,
`catalog_product_entity_int`.`entity_id` AS `entity_id`,
`catalog_product_entity_int`.`value` AS `value`,
`eav_attribute`.`attribute_code` AS `attribute_code`,
`catalog_product_entity`.`sku` AS `sku`,
`catalog_product_entity`.`created_at` AS `created_at`,
`catalog_product_entity`.`updated_at` AS `updated_at`
from
((`eav_attribute`
join `catalog_product_entity_int` on ((`eav_attribute`.`attribute_id` = `catalog_product_entity_int`.`attribute_id`)))
join `catalog_product_entity` on ((`catalog_product_entity_int`.`entity_id` = `catalog_product_entity`.`entity_id`)))
where
((`eav_attribute`.`attribute_code` = 'acfp_candles_size_1')) and
(`catalog_product_entity_int`.`value` = 2));

-- ==============[ Ends CSW | Pravin Attributes Work ] ================================================

-- ==============[ Starts CSW | URL Products URLs ] ================================================
-- Backup before changes : Pending
-- mysqldump -ua53979e5_csw_mig -pOnsetJoyKetchKith19 a53979e5_csw_mig url_rewrite>a53979e5_csw_mig_url_rewrite_19_feb.sql
-- anyalsis starts
select * from catalog_url_rewrite_product_category;
select * from url_rewrite where target_path='catalog/category/view/id/2185';
select * from store;
select store_id, count(*) from url_rewrite group by store_id having count(store_id)>1;
-- store 2,3
select * from url_rewrite where target_path='catalog/category/view/id/2185'
select * from url_rewrite where store_id=3;
select * from url_rewrite where target_path='catalog/category/view/id/2925'
select * from url_rewrite where target_path='catalog/category/view/id/2185'
select * from tbl_notifications;
truncate table tbl_notifications;
-- anyalsis ends
-- start ....

-- store id check 0
INSERT into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata from url_rewrite ur where ur.store_id=0 -- 146156
-- and                                   ur.target_path in (select target_path from url_rewrite url where url.store_id=1); -- 2906
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=1); -- 143250+170628 = 313878
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=2); -- 139345+313878  = 453223
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 146154+453223=599377

-- store id check 1
select Count(*) from url_rewrite ur; -- 599377
INSERT into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata from url_rewrite ur where ur.store_id=1
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=0); -- 146156+4888 =151044
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=2); -- 4888+151044 = 155932 ([23000][1062] (conn=103782831) Duplicate entry 'artwork/christ-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID')
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 139345+313878  = 453223
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 146154+453223=599377

-- store id check 2
select Count(*) from url_rewrite ur; -- 609151
INSERT into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 1 as store_id, description, is_autogenerated, metadata from url_rewrite ur where ur.store_id=2
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=0); -- 146156+4888 =151044 [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=1); -- 4888+151044 = 155932 ([23000][1062] (conn=103782831) Duplicate entry 'artwork/christ-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID')
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 139345+313878  = 453223  -- [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 146154+453223=599377


-- store id check 3
select Count(*) from url_rewrite ur; -- 609151
INSERT into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata from url_rewrite ur where ur.store_id=3
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=0); -- 146156+4888 =151044 [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=2); -- 4888+151044 = 155932 ([23000][1062] (conn=103782831) Duplicate entry 'artwork/christ-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID')
--  and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 139345+313878  = 453223  -- [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 146154+453223=599377
-- 609159

-- reverted above changes. now working on this : select * from catalog_url_rewrite_product_category;
select * from url_rewrite where entity_type='product';


# SELECT product_id,
#   GROUP_CONCAT(c.category_id SEPARATOR ',') AS category_ids,
#   GROUP_CONCAT(cv.value SEPARATOR ',')      AS category_names
-- select category_id,count(category_id) as count
select category_id,product_id
FROM catalog_category_product c
    INNER JOIN catalog_category_entity_varchar cv ON c.category_id = cv.entity_id
AND cv.store_id = 0
AND cv.attribute_id =
   (SELECT attribute_id
    FROM eav_attribute
    WHERE attribute_code = 'name'
      AND entity_type_id =
          (SELECT entity_type_id
           FROM eav_entity_type
           WHERE entity_type_code = 'catalog_category'))
    AND product_id=76;
-- group by category_id having count(category_id)>1;

select * from catalog_category_product where product_id=2133;
select * from url_rewrite where url_rewrite_id in ( select catalog_url_rewrite_product_category.url_rewrite_id from catalog_url_rewrite_product_category where product_id=2133    )
-- GROUP BY product_id
INSERT INTO catalog_url_rewrite_product_category(url_rewrite_id, category_id, product_id)
select ur.url_rewrite_id,c.category_id,product_id
FROM url_rewrite ur
     INNER JOIN catalog_category_product c ON ur.entity_id=c.product_id
    INNER JOIN catalog_category_entity_varchar cv ON c.category_id = cv.entity_id -- AND cv.store_id = 0
                                                         AND cv.attribute_id =
   (SELECT attribute_id
    FROM eav_attribute
    WHERE attribute_code = 'name'
      AND entity_type_id =
          (SELECT entity_type_id
           FROM eav_entity_type
           WHERE entity_type_code = 'catalog_category'))
    AND product_id in (
        select ur.entity_id from url_rewrite ur where entity_type='product'
        )
and c.product_id not in (4019,186976,2133)  order by url_rewrite_id;

select * from catalog_category_product ccp where ccp.product_id=2133;
select * from catalog_category_entity_varchar where entity_id=2133;
select * from catalog_url_rewrite_product_category where category_id=2047
select * from catalog_url_rewrite_product_category where category_id=2047
where product_id=2133 order by url_rewrite_id;

select * from store;

INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84353);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84353);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84354);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84354);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84355);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84355);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84356);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84356);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84357);
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (product_id) VALUES (84358);
select * from catalog_url_rewrite_product_category where category_id=2047
order by url_rewrite_id desc
select * from url_rewrite where entity_type='category' and target_path like '%%'
                            and entity_id=2047;
select * from url_rewrite where entity_id=84353

select * from catalog_url_rewrite_product_category where product_id=2874;
select * from catalog_url_rewrite_product_category where product_id=2874;

select * from catalog_url_rewrite_product_category where product_id=2874;

select * from catalog_product_entity_varchar where attribute_id=97 and entity_id=2874;
INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (url_rewrite_id, category_id, product_id) VALUES (172946, 1030, 2874);



select Count(*) from url_rewrite ur; -- 609151

-- INSERT into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 1 as store_id, description, is_autogenerated, metadata from url_rewrite ur where ur.store_id=2
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=0); -- 146156+4888 =151044 [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=1); -- 4888+151044 = 155932 ([23000][1062] (conn=103782831) Duplicate entry 'artwork/christ-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID')
-- and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 139345+313878  = 453223  -- [23000][1062] (conn=103782831) Duplicate entry 'artwork/large-canvases-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# and                                   ur.target_path not in (select target_path from url_rewrite url where url.store_id=3); -- 146154+453223=599377

-- ==============[ Ends CSW | URL Products URLs ] ================================================

select * from url_rewrite where entity_type='category' and target_path='catalog/category/view/id/2209'
select * from catalog_url_rewrite_product_category where url_rewrite_id=3130
select * from catalog_url_rewrite_product_category where url_rewrite_id=192816

                                                         -- in (select url_rewrite_id from url_rewrite where entity_type='category' and target_path='catalog/category/view/id/2209')

select * from url_rewrite where target_path='catalog/category/view/id/2292';
-- INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES ('category', 2292, 'furniture/church-signs', 'catalog/category/view/id/2292', 0, 3, null, 1, null);

select target_path,store_id from url_rewrite
group by target_path having count(*)<2


select ur.store_id, count(ur.store_id) from url_rewrite ur
where ur.target_path in (
    select target_path from url_rewrite group by target_path having count(*)<2
    )
group by store_id
and store_id=2;

-- backup resultset into new table
-- [2020-02-20 23:05:50] 158877 rows affected in 2 s 267 ms
CREATE TABLE temp_feb_20_url_rewrite
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite ur
where ur.target_path in (
    select ur2.target_path from url_rewrite ur2 group by ur2.target_path having count(*)<2
    );

-- verification
select count(*) from temp_feb_20_url_rewrite;
select store_id, count(*) from temp_feb_20_url_rewrite  group by store_id;
select target_path from temp_feb_20_url_rewrite  group by target_path having count(target_path)>1

-- backup duplicate url keys for requiest path
# CREATE TABLE temp_feb_20_url_rewrite_duplicate_url_key_for_request_path_206
# select request_path from url_rewrite where target_path in (select target_path from temp_feb_20_url_rewrite)
# group by request_path having count(*)>1

-- rever :  source a53979e5_csw_mig_url_rewrite_b4_change_20_feb.sql


# 0,137637
# 1,11334   : done : 64 has issues
# 2,9881    : done : 128 has issues
# 3,25      : done : 0 has issues
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata
from temp_feb_20_url_rewrite where store_id=0
-- and request_path not in (    select request_path from temp_feb_20_url_rewrite_duplicate_url_key_for_request_path_206    );

select * from temp_feb_20_url_rewrite;

select concat('http://churchsupply.commercestaging.com/index.php/',request_path) from temp_feb_20_url_rewrite
where request_path not in (    select request_path from temp_feb_20_url_rewrite_duplicate_url_key_for_request_path_206    );

      request_path='sacraments/baptism-and-baby/albums-photo-frames'
select * from catalog_url_rewrite_product_category where url_rewrite_id=3130

-- a53979e5_3
-- LegsTheftLifersStills
select * from catalog_product_entity_varchar where attribute_id=97 and entity_id=2874;
-- INSERT INTO a53979e5_csw_mig.catalog_url_rewrite_product_category (url_rewrite_id, category_id, product_id) VALUES (172946, 1030, 2874);


-- Duplicate url keys in url rewrite issue fix 192
select * from url_rewrite where request_path='artwork/christ';

-- sb sy pehle categories me dekhna hoga
select c.*,cv.*
       FROM catalog_category_product c
                INNER JOIN catalog_category_entity_varchar cv ON c.category_id = cv.entity_id
           AND cv.store_id = 0
           AND cv.attribute_id =
               (SELECT attribute_id
                FROM eav_attribute
                WHERE attribute_code = 'name'
                  AND entity_type_id =
                      (SELECT entity_type_id
                       FROM eav_entity_type
                       WHERE entity_type_code = 'catalog_category'))
where c.category_id=365;

select * from url_rewrite where request_path like 'artwork/%'
and entity_type='category'
order by store_id,request_path ;

select * from
catalog_category_entity_varchar cv
where cv.entity_id=365

select * from url_rewrite where request_path like 'sacred-heart%' and entity_type='category'

-- ===================== [ starts CSW - category products missing soe friendly URL ] =======================
# 0	admin
# 1	default
# 2	churchsupply
# 3	csw_storeview
-- jo product 2 me wo 3 me bhi dalo to issue fix hojata he
select * from store;
select * from url_rewrite where target_path like '%id/123157' and request_path='communion-ware/altar-breads/cc01-139-low-gluten-priest-hosts-licit-for-catholics-cc01-139.html';
select count(*) from url_rewrite where target_path like 'catalog/product/view/id/%' and store_id=2; -- 169816
-- 16805
select count(request_path) from url_rewrite where target_path like 'catalog/product/view/id/%' group by request_path having count(request_path)<2;

-- add new category URL Rewrite
-- select * from url_rewrite where target_path like '%id/2260' and request_path='communion-ware/altar-breads..html';
-- INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES ('category', 2260, 'communion-ware/altar-breads..html', 'catalog/category/view/id/2260', 0, 2, null, 0, null);
-- INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES ('category', 2260, 'communion-ware/altar-breads..html', 'catalog/category/view/id/2260', 0, 2, null, 0, null);

select max(url_rewrite_id) from url_rewrite; -- 848267
-- backup resultset into new table
-- [2020-02-26 01:01:12] 17332 rows affected in 2 s 772 ms
/*
CREATE TABLE temp_feb_26_url_rewrite
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite ur
where ur.request_path in (
    select request_path from url_rewrite where target_path like 'catalog/product/view/id/%' group by request_path having count(request_path)<2
    );
*/
-- verification : 17332 TODO : migrate these  : bs ab nahin dalne ye
-- INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
# select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata
# from temp_feb_26_url_rewrite where store_id=2;

select count(request_path) from temp_feb_26_url_rewrite where store_id=2;
select * from temp_feb_26_url_rewrite where store_id=0;
-- drop table temp_feb_26_url_rewrite;
-- CREATE TABLE temp_feb_26_url_rewrite -- [2020-02-26 01:20:01] 12971 rows affected in 2 s 873 ms
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where store_id=2 and entity_type='product' and request_path not in
(select request_path from url_rewrite where store_id=3 and target_path like 'catalog/product/view/id/%' and entity_type='product');

-- verification : 12971 TODO : migrate these : qk ye ese hen jo 2 wale store m to hen par 3 wale me nahin hen
-- [2020-02-26 01:22:26] 12894 rows affected in 1 s 286 ms : DONE   12971-12894 = 77 NOT INSERTED/ISSUE WALIE
# INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
# select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata
# from temp_feb_26_url_rewrite where store_id=2;

select * from url_rewrite where url_rewrite_id not in (select url_rewrite_id from catalog_url_rewrite_product_category)
-- and request_path='holiday-sacraments.html'
and target_path='catalog/category/view/id/2222'

select * from url_rewrite where url_rewrite_id not in (select url_rewrite_id from catalog_url_rewrite_product_category)
-- and request_path='holiday-sacraments.html'
and target_path='catalog/category/view/id/263'

SELECT * FROM core_config_data WHERE path like '%web/seo/use_rewrites%';


-- dummary products
-- 2222 sy le k 2232 tk
select * from rgw_enterprise_url_rewrite where entity_type=1

select request_path,identifier from rgw_enterprise_url_rewrite where request_path=identifier;

select distinct redirect_type from url_rewrite

select distinct redirect_type from url_rewrite

select * from url_rewrite where entity_id=46119;

select * from url_rewrite where request_path='2537-83b-holy-water-font-2537-83b.html';
select * from url_rewrite where request_path='81370101-st-blase-candle-81370101.html';

select * from url_rewrite where request_path='brtb111-box-500-crucifixion-scene-with-angel-bulletin-covers-brtb111-box-500.html';

select * from url_rewrite where entity_type='product' and store_id=1
and entity_id not in (select entity_id from url_rewrite where entity_type='product' and store_id=2);

create table temp_feb_28_url_rewrite_for_product
SELECT
    request_path, store_id,
    COUNT(request_path)
FROM
    url_rewrite
where entity_type='product'
GROUP BY request_path
HAVING COUNT(request_path) <3;

select * from temp_feb_28_url_rewrite_for_product where store_id in(0,1)
and not exists (
select 1 from url_rewrite ur where ur.request_path!=request_path and store_id=3
);

select tf28urfp.store_id, tf28urfp.request_path,  ur.store_id
from temp_feb_28_url_rewrite_for_product tf28urfp
left join url_rewrite ur on tf28urfp.request_path=ur.request_path
where ur.store_id is null;

select
  s.request_path,
  max(case when r.store_id = 0 then r.store_id else -1 end) as store_0,
  max(case when r.store_id = 1 then r.store_id else -1 end) as store_1,
  max(case when r.store_id = 2 then r.store_id else -1 end) as store_2,
  max(case when r.store_id = 3 then r.store_id else -1 end) as store_3
from temp_feb_28_url_rewrite_for_product r
left join url_rewrite s on r.request_path=s.request_path
where s.entity_type='product'
-- and r.request_path='/embroidered-clergy-shirt-with-personalization-symbols.html'
group by s.request_path;

select entity_type, request_path, target_path, store_id,metadata from url_rewrite where request_path like '%012-gp-flared-cross-tsg-012.html%';
select * from url_rewrite where target_path like '%catalog/product/view/id/66565/category/2';
-- INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES ('product', 66565, '/0518-cord-rosary-0518-10763.html', 'catalog/product/view/id/66565/category/2', 0, 0, null, 1, '{"category_id":"2"}');
-- kaam ki query 1
select replace(request_path,'/','') from url_rewrite where entity_type='product'
group by replace(request_path,'/','') having count(*)>4;

-- kaam ki query 2
select entity_type, request_path, target_path, store_id,metadata from url_rewrite where request_path like '%embroidered-clergy-shirt-with-personalization-symbols%';
select * from url_rewrite where replace(target_path,'/','') in
(select replace(target_path,'/','') from url_rewrite where entity_type='product' and request_path like '/%')
and request_path like '%embroidered-clergy-shirt-with-personalization-symbols%';
                                and metadata is null;

INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES ('product', 138457, '/corpus-christi-advent-candles-1-1-2-x-15-51-beeswax-set.html', 'catalog/product/view/id/138457/category/2', 0, 0, null, 1, '{"category_id":"2"}');

select concat('http://churchsupply.commercestaging.com/',request_path)
from url_rewrite where target_path like '%/category/2';

-- /st-joseph-i-dark-wood-rosary-spec-color-bm1djoi-clr-lowast.html
-- http://churchsupply.commercestaging.com/lourdes-single-decade-blue-stone-rosary-spec-color-bm1dld-clr-lowast.html

select * from url_rewrite where entity_type='product' and store_id=1
and entity_id not in (select entity_id from url_rewrite where entity_type='product' and store_id=3);


select count(*) from url_rewrite where entity_type='product' and store_id not in (2,3)

-- create table temp_mar_4_url_rewrite_deleted_rows
select *  from url_rewrite where entity_type='product' -- and request_path in (select request_path from temp_mar_3_url_rewrite_404_duplicate_products )
and request_path='xb101-marriage-certificate-brtxb101-box-50.html';
-- delete from url_rewrite where entity_type='product'  and exists (select b.url_rewrite_id from temp_mar_4_url_rewrite_deleted_rows b where url_rewrite_id=b.url_rewrite_id);

select * from url_rewrite where entity_type='product';
select * from temp_feb_28_url_rewrite_for_product;

select count(*)  entity_type from url_rewrite where entity_type='product';
select count(*)  entity_type from temp_feb_20_url_rewrite where entity_type='product';;
select count(*)   entity_type from temp_feb_26_url_rewrite  where entity_type='product';


select * from temp_mar_3_url_rewrite_404_duplicate_products where request_path like '%16372-wedding-stole-sdi-116050%'
select * from url_rewrite where request_path like '%16372-wedding-stole-sdi-116050%'
create table temp_mar_4_url_rewrite_b4_bhand_recovery
select * from url_rewrite;
select count(*) from url_rewrite;
select  count(*) from temp_mar_4_url_rewrite_b4_bhand_recovery;

select count(*)  entity_type from url_rewrite where entity_type='category';
insert ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select  entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata from temp_mar_4_url_rewrite_b4_bhand_recovery  where entity_type='category';

select * from url_rewrite where entity_type='product'
                                and entity_id=80805 and request_path like '%4008-first-reconciliation-penance-4008parent%';


create table temp_feb_28_url_rewrite_for_product2
select
  s.request_path,
  max(case when s.store_id = 0 then s.store_id else -1 end) as store_0,
  max(case when s.store_id = 1 then s.store_id else -1 end) as store_1,
  max(case when s.store_id = 2 then s.store_id else -1 end) as store_2,
  max(case when s.store_id = 3 then s.store_id else -1 end) as store_3
from url_rewrite s
where s.entity_type='product'
-- and s.request_path='/embroidered-clergy-shirt-with-personalization-symbols.html'
group by s.request_path;

-- (store_0, store_1, store_2, store_3) VALUES (0, -1, -1, -1);
select * from url_rewrite where request_path='0-10-pen-ordination-tsg-0-10-pen';

select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_1=-1;
select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_2=-1;
select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_3=-1;
select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_0=-1;
select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_2=-1;
select * from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_3=-1;
-- -----------------------------------------------------------------------------------------------------------------------
# [2020-03-04 21:07:45] 146128 rows affected in 7 s 134 ms
# [2020-03-04 21:07:45] [23000][1062] Duplicate entry '40279t-christmas-joy-ornament-1' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 1 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_1=-1
);
# [2020-03-04 21:08:25] 146154 rows affected in 13 s 536 ms
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 2 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_2=-1
);
# [2020-03-04 21:09:16] 146155 rows affected in 19 s 40 ms
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_3=-1
);

# [2020-03-04 21:09:43] 17833 rows affected in 3 s 317 ms
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60318.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60118.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60418.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60518.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60618.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60718.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60818.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61018.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61118.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61218.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61318.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61418.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61518.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '62318.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61618.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68018.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68118.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60133.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60333.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60433.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60533.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60633.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60733.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60833.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61033.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61133.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61233.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61333.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61433.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61533.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '62333.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61633.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68033.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68133.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60136.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60136-fleur-de-lis-white-paschal-candle-1-1-2-x-34.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60336.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60436.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60436-fleur-de-lis-white-paschal-candle-1-15-16x28.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60136-fleur-de-lis-white-paschal-candle-1-1-2x34.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60336-fleur-de-lis-white-paschal-candle-1-3-4x37.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60536.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60636.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60736.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60836.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61036.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61136.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61236.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61336.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61436.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61536.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '62336.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61636.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68036.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '68136.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60133-fleur-de-lis-blue-paschal-candle-1-1-2-x-34.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60333-fleur-de-lis-blue-paschal-candle-1-3-4-x-37.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60433-fleur-de-lis-blue-paschal-candle-1-15-16-x-28.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60533-fleur-de-lis-blue-paschal-candle-1-15-16-x-39.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60633-fleur-de-lis-blue-paschal-candle-2-x-28.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60733-fleur-de-lis-blue-paschal-candle-2-x-39.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '60833-fleur-de-lis-blue-paschal-candle-2-1-16-x-45.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61033-fleur-de-lis-blue-paschal-candle-2-1-4-x-48.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:09:43] [23000][1062] Duplicate entry '61133-fleur-de-lis-blue-paschal-candle-2-1-2-x-36.html-0' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 0 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_0=-1
);

# [2020-03-04 21:10:30] 14101 rows affected in 3 s 525 ms
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'communion-pewter-cross-boy-sh319.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'carpenter-i-light-wood-rosary-spec-color-bmter1-clr-lowast-l.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'knights-templar-crucifix-rosary-spec-color-bmtr-clr-c.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'yeshua-tiger-eye-no-center-rosary-spec-color-bmye-clr-lowast.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-rosary-spec-color-bmmori-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'sanctus-rosary-spec-color-bmsanc-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'crusader-ii-shield-rosary-spec-color-bmcr2-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'jerusalem-shield-rosary-spec-color-bmjr-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-bones-rex-rosary-spec-color-bmrex-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'miraculous-medal-ii-rosary-spec-color-bmmmii-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'jacobs-ladder-rosary-spec-color-bmjl-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'knights-hospitaller-shield-rosary-spec-color-bmhos-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'fleur-de-lis-shield-rosary-spec-color-bmfdl-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'black-monk-black-white-rosary-bmbaw.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'legio-maria-bracelet-rosary-spec-color-bmmb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'assumption-rosary-spec-color-bm1dass-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'gloria-patri-rosary-spec-color-bm1dgp-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'lourdes-single-decade-blue-stone-rosary-spec-color-bm1dld-clr-lo' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'salvation-rosary-spec-color-bm1dsal-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'pater-noster-tiger-eye-rosary-spec-color-bm1dpn-clr-lowast.html-' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'irish-rosary-spec-color-bm1dnd-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-single-decade-rosary-spec-color-bm1dmm-clr-lowast.h' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'st-joseph-i-dark-wood-rosary-spec-color-bm1djoi-clr-lowast.html-' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'church-militant-bracelet-rosary-spec-color-bmcm-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'hospitaller-bracelet-rosary-bmhb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'crusader-bracelet-rosary-bmcb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-bones-rosary-spec-color-bmbones-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'holiday/nativity/best-selling-nativity-sets.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'communion-pewter-cross-boy-sh319.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'assumption-rosary-spec-color-bm1dass-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'gloria-patri-rosary-spec-color-bm1dgp-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'st-joseph-i-dark-wood-rosary-spec-color-bm1djoi-clr-lowast.html-' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'lourdes-single-decade-blue-stone-rosary-spec-color-bm1dld-clr-lo' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-single-decade-rosary-spec-color-bm1dmm-clr-lowast.h' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'irish-rosary-spec-color-bm1dnd-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'pater-noster-tiger-eye-rosary-spec-color-bm1dpn-clr-lowast.html-' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'salvation-rosary-spec-color-bm1dsal-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'black-monk-black-white-rosary-bmbaw.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-bones-rosary-spec-color-bmbones-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'crusader-bracelet-rosary-bmcb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'church-militant-bracelet-rosary-spec-color-bmcm-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'crusader-ii-shield-rosary-spec-color-bmcr2-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'fleur-de-lis-shield-rosary-spec-color-bmfdl-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'hospitaller-bracelet-rosary-bmhb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'knights-hospitaller-shield-rosary-spec-color-bmhos-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'jacobs-ladder-rosary-spec-color-bmjl-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'jerusalem-shield-rosary-spec-color-bmjr-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'legio-maria-bracelet-rosary-spec-color-bmmb-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'miraculous-medal-ii-rosary-spec-color-bmmmii-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-rosary-spec-color-bmmori-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-bones-rex-rosary-spec-color-bmrex-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'sanctus-rosary-spec-color-bmsanc-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'carpenter-i-light-wood-rosary-spec-color-bmter1-clr-lowast-l.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'knights-templar-crucifix-rosary-spec-color-bmtr-clr-c.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'yeshua-tiger-eye-no-center-rosary-spec-color-bmye-clr-lowast.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'communion-pewter-cross-boy-sh319.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'carpenter-i-light-wood-rosary-spec-color-bmter1-clr-lowast-l.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'knights-templar-crucifix-rosary-spec-color-bmtr-clr-c.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'yeshua-tiger-eye-no-center-rosary-spec-color-bmye-clr-lowast.htm' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-rosary-spec-color-bmmori-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'sanctus-rosary-spec-color-bmsanc-clr.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'crusader-ii-shield-rosary-spec-color-bmcr2-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'jerusalem-shield-rosary-spec-color-bmjr-clr-s.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
# [2020-03-04 21:10:31] [23000][1062] Duplicate entry 'memento-mori-bones-rex-rosary-spec-color-bmrex-clr-lowast.html-2' for key 'URL_REWRITE_REQUEST_PATH_STORE_ID'
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 2 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_2=-1
);

-- [2020-03-04 21:11:42] 17830 rows affected in 4 s 559 ms
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 3 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product2 tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_3=-1
);
select * from url_rewrite where request_path like '8509ss-20s-track-field-boy-st-christopher-ss-medal-8509ss-20s.html'
# and url_rewrite_id not in (    795788,182104,824823,844935,795794,182110,824829,844941,795789,182105,824824,844936,795790,182106,824825,844937,795793,182109,824828,844940,795795,182111,824830,
# 844942,795796,182112,824831,844943,795791,182107,824826,844938,795792,182108,824827,844939
#         )
order by target_path, store_id;

select * from url_rewrite where target_path like 'catalog/product/view/id/138623'
                            and store_id=0;
select * from url_rewrite where request_path like 'cc01-129-low-gluten-communion-hosts-licit-for-catholics';

select * from url_rewrite where request_path like 'communion-ware/altar-breads..html';

select * from url_rewrite where request_path like 'cc01-129-low-gluten-communion-hosts-licit-for-catholics';
select * from url_rewrite where request_path like 'cc01-129-low-gluten-communion-hosts-licit-for-catholics';

SELECT * FROM catalog_url_rewrite_product_category

-- pravin example for url path
SELECT * FROM url_rewrite WHERE request_path='60-3160-funeral-pall-terra-fabric-grey';

-- SELECT value_id, entity_type_id, attribute_id, store_id, entity_id, value  FROM rgw_catalog_product_entity_url_key;

SELECT url_rewrite_id, request_path, target_path, is_system, guid, identifier, inc, value_id, store_id, entity_type FROM rgw_enterprise_url_rewrite
WHERE target_path like  'catalog/product/view/id/138219%' ;

select * from rgw_enterprise_url_rewrite where request_path like '%/%' and target_path like  'catalog/product/view/id/%' ;

select request_path,store_id from url_rewrite where request_path like '%/%/%' and target_path like  'catalog/product/view/id/%' and store_id=3 order by request_path,store_id;

select * from url_rewrite where request_path like 'apparel-vestments/banners-paraments/embroidered-tapestries-by-slabbinck/4561-125315.html' and target_path like  'catalog/product/view/id/%' ;
create table temp_march_9_url_rewrite_for_product
select
  s.request_path,
  max(case when s.store_id = 0 then s.store_id else -1 end) as store_0,
  max(case when s.store_id = 1 then s.store_id else -1 end) as store_1,
  max(case when s.store_id = 2 then s.store_id else -1 end) as store_2,
  max(case when s.store_id = 3 then s.store_id else -1 end) as store_3
from url_rewrite s
where s.entity_type='product'
#  and s.request_path='/029033348934-14-lighted-baby-jesus-029033348934.html'
group by s.request_path;

-- ===================== starts ============
select count(*) from temp_march_9_url_rewrite_for_product where store_0=-1 union all
select  count(*) from temp_march_9_url_rewrite_for_product where store_2=-1 union all
select  count(*)  from temp_march_9_url_rewrite_for_product where store_3=-1 union  all
select  count(*)  from temp_march_9_url_rewrite_for_product where store_1=-1;

-- select * from url_rewrite where entity_type='product' and target_path like '%catalog/category/view/%'
-- update url_rewrite set entity_type='category' where entity_type='product' and target_path like '%catalog/category/view/id/%';
select request_path,store_id from url_rewrite where request_path like '%/%/%' and target_path like  'catalog/product/view/id/%' and store_id=3 order by request_path,store_id;







select * from url_rewrite where request_path like 'statues/inexpensive-indoor-outdoor/camel-sa3661w%';
select * from url_rewrite where entity_id=48541;
select * from url_rewrite where entity_id=54314  and request_path not like '%/%/%';
select * from url_rewrite where target_path='catalog/product/view/id/54314/category/2828';

select * from url_rewrite where is_autogenerated=1 and entity_type='product';


--
# update ignore url_rewrite set request_path=concat(request_path,'.html') where request_path not like '%.html'and entity_type='product'
# select concat(request_path,'.html') from url_rewrite where request_path not like '%.html'and entity_type='product';
















# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160920, 'product', 54314, 'camel-sa3661w.html', 'catalog/product/view/id/54314', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160923, 'product', 54314, 'camel-sa3661w.html', 'catalog/product/view/id/54314', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790351, 'product', 54314, 'camel-sa3661w.html', 'catalog/product/view/id/54314', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839501, 'product', 54314, 'camel-sa3661w.html', 'catalog/product/view/id/54314', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (14735, 'product', 54314, 'camel-white-sa3661w', 'catalog/product/view/id/54314', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (208951, 'product', 54314, 'camel-white-sa3661w', 'catalog/product/view/id/54314', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (405555, 'product', 54314, 'camel-white-sa3661w', 'catalog/product/view/id/54314', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (602161, 'product', 54314, 'camel-white-sa3661w', 'catalog/product/view/id/54314', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160922, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790353, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (821782, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839503, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160634, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790212, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (821687, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839362, 'product', 54314, 'holiday/nativity/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/1038', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160632, 'product', 54314, 'sa3661w.html', 'catalog/product/view/id/54314', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160635, 'product', 54314, 'sa3661w.html', 'catalog/product/view/id/54314', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790210, 'product', 54314, 'sa3661w.html', 'catalog/product/view/id/54314', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839360, 'product', 54314, 'sa3661w.html', 'catalog/product/view/id/54314', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160924, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (876993, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (909761, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (942527, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160636, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (876900, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (909668, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (942434, 'product', 54314, 'statuary/nativity-sets/36-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2828', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160925, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (876994, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (909762, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (942528, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160637, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (876901, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (909669, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (942435, 'product', 54314, 'statuary/statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/2839', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160921, 'product', 54314, 'statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790352, 'product', 54314, 'statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (821781, 'product', 54314, 'statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839502, 'product', 54314, 'statues/inexpensive-indoor-outdoor/camel-sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 3, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (160633, 'product', 54314, 'statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 1, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (790211, 'product', 54314, 'statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 0, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (821686, 'product', 54314, 'statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 2, null, 1, null);
# INSERT INTO a53979e5_csw_mig.url_rewrite (url_rewrite_id, entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata) VALUES (839361, 'product', 54314, 'statues/inexpensive-indoor-outdoor/sa3661w.html', 'catalog/product/view/id/54314/category/277', 0, 3, null, 1, null);


select * from url_rewrite where request_path like 'holiday/nativity/best-selling-nativity-sets.html'
select * from url_rewrite where request_path like 'holiday-sacraments/christmas-gifts.html' -- changed to cateogry
select * from url_rewrite where request_path like 'holiday/nativity/best-selling-nativity-sets.html'

INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, 1 as store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
     select request_path from temp_march_9_url_rewrite_for_product tf28urfp where tf28urfp.store_1=-1
#     select request_path from temp_march_9_url_rewrite_for_product tf28urfp where tf28urfp.store_1=-1 and tf28urfp.store_2=2
#     select request_path from temp_march_9_url_rewrite_for_product tf28urfp where tf28urfp.store_3=-1 and tf28urfp.store_2=2
);
-- and store_id=3;

 SELECT DISTINCT cc.entity_id as id, cc.value as path, cc1.value as name
  FROM catalog_category_entity_varchar cc
  JOIN catalog_category_entity_varchar cc1 ON cc.entity_id=cc1.entity_id
  JOIN eav_entity_type ee ON cc.entity_id=ee.entity_type_id
  JOIN catalog_category_entity cce ON cc.entity_id=cce.entity_id
  WHERE cc.attribute_id = '57' AND cc1.attribute_id = '41' AND ee.entity_model = 'catalog/category';











-- ISSUE LIST : 77
# books-bibles/books-dvds/rcia.html-3
# furniture/furniture/chairs-flexible-seating.html-3
# sacraments/first-communion/dolls/40340-communion-doll-brunette-4
# sacraments/first-communion/dolls/40330-communion-doll-blonde-403
# sacraments/first-communion/rosaries-and-bracelets/7654-wh-first-
# sacraments/first-communion/rosaries-and-bracelets/7654-bk-first-
# sacraments/first-communion/sports-statues-and-medals/pc7500pw-ba
# sacraments/first-communion/sports-statues-and-medals/pc7501pw-fo
# sacraments/first-communion/party-goods/first-communion-wrapping-
# sacraments/first-communion/party-goods/gift-bag-small-165-20-101
# sacraments/first-communion/party-goods/first-communion-bag-large
# sacraments/first-communion/party-goods/large-gift-bag-165-20-201
# sacraments/first-communion/party-goods/xl-gift-bag-165-20-3001xl
# sacraments/first-communion/photo-albums-and-frames/first-communi
# sacraments/first-communion/photo-albums-and-frames/first-communi
# sacraments/first-communion/photo-albums-and-frames/first-communi
# sacraments/first-communion/cross-crucifix/8-first-communion-cros
# sacraments/first-communion/cross-crucifix/7-wall-cross-white-por
# sacraments/first-communion/dresses-veils-ties-and-apparel/first-
# sacraments/first-communion/keepsakes-and-gifts/communion-bookmar
# first-communion-pl-hir1203-695.html-3
# satin-finish-communion-hir2557.html-3
# sacraments/first-communion/boxes-rosary-keepsake-music/first-com
# sacraments/first-communion/party-goods/first-communion-gift-bag-
# sacraments/first-communion/gift-sets/boys/first-communion-spanis
# sacraments/first-communion/cross-crucifix/communion-pewter-cross
# sacraments/first-communion/books-and-bibles/first-communion-pray
# statuary/nativity-sets/best-selling-nativity-sets/5-scale-kostne
# sacraments/first-communion/dolls/painted-porcelain-brunette-comm
# sacraments/first-communion/dolls/painted-porcelain-blonde-commun
# sacraments/first-communion/photo-albums-and-frames/first-communi
# sacraments/first-communion/sports-statues-and-medals/jesus-and-t
# sacraments/first-communion/sports-statues-and-medals/jesus-and-s
# sacraments/first-communion/photo-albums-and-frames/4-x-6-black-p
# sacraments/confirmation-and-rcia/confirmation-and-rcia-gifts/sta
# sacraments/confirmation-and-rcia/confirmation-and-rcia-gifts/ros
# sacraments/first-communion/pins/gold-tone-chalice-first-communio
# sacraments/first-communion/rosaries-and-bracelets/black-glass-ro
# sacraments/first-communion/rosaries-and-bracelets/white-cat-s-ey
# sacraments/first-communion/photo-albums-and-frames/4-x-6-shadowb
# sacraments/first-communion/pins/chalice-first-communion-pin-5121
# sacraments/first-communion/gift-sets/girl/girl-gift-boxed-rosary
# sacraments/first-communion/gift-sets/boys/boy-gift-boxed-rosary-
# sacraments/first-communion/photo-albums-and-frames/4-x-6-white-p
# sacraments/first-communion/pins/enameled-cross-first-communion-p
# mom-heart-necklace-f1557.html-3
# jewelry/rosaries/cord-rosaries/1776-rosary-bm1d76.html-3
# jewelry/rosaries/cord-rosaries/st-joseph-ii-light-wood-rosary-sp
# jewelry/rosaries/cord-rosaries/ava-maria-rosary-bmam.html-3
# jewelry/rosaries/cord-rosaries/pouch-distressed-brown-leather-ro
# jewelry/rosaries/cord-rosaries/black-monk-light-blue-rosary-bmbl
# jewelry/rosaries/cord-rosaries/black-monk-brown-rosary-bmbro.htm
# jewelry/rosaries/cord-rosaries/pouch-black-suede-rosary-bmbsp.ht
# jewelry/rosaries/cord-rosaries/crusader-shield-rosary-spec-color
# jewelry/rosaries/cord-rosaries/pouch-distressed-dark-brown-leath
# jewelry/rosaries/cord-rosaries/ecce-homo-rosary-bmecce.html-3
# jewelry/rosaries/cord-rosaries/guadalupe-rosary-bmgr.html-3
# jewelry/rosaries/cord-rosaries/black-monk-emerald-green-rosary-b
# jewelry/rosaries/cord-rosaries/guadalupe-sanctus-rosary-bmgs.htm
# jewelry/rosaries/cord-rosaries/king-of-kings-rosary-bmkok.html-3
# jewelry/rosaries/cord-rosaries/miraculous-medal-rosary-bmmm.html
# jewelry/rosaries/cord-rosaries/ora-pro-nobis-rosary-bmopn.html-3
# jewelry/rosaries/cord-rosaries/passio-christi-rosary-bmpasc.html
# jewelry/rosaries/cord-rosaries/santus-patricius-rosary-bmpats.ht

# create table temp_feb_28_url_rewrite_for_product
# select
#   s.request_path,
#   max(case when s.store_id = 0 then s.store_id else -1 end) as store_0,
#   max(case when s.store_id = 1 then s.store_id else -1 end) as store_1,
#   max(case when s.store_id = 2 then s.store_id else -1 end) as store_2,
#   max(case when s.store_id = 3 then s.store_id else -1 end) as store_3
# from url_rewrite s
# where s.entity_type='product'
# -- and s.request_path='/embroidered-clergy-shirt-with-personalization-symbols.html'
# group by s.request_path;

select * from url_rewrite where request_path='40279t-christmas-joy-ornament.html';


select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_1=-1;
select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_2=-1;
select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_3=-1;
select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_0=-1;
select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_2=-1;
select * from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_3=-1;
-- -----------------------------------------------------------------------------------------------------------------------
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_1=-1
);

INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_2=-1
);

INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_0=0 and tf28urfp.store_3=-1
);

INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_0=-1
);
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_2=-1
);
INSERT ignore into url_rewrite(entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
select entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata
from url_rewrite where entity_type='product' and request_path in (
    select request_path from temp_feb_28_url_rewrite_for_product tf28urfp where tf28urfp.store_1=1 and tf28urfp.store_3=-1
);



-- ===================== [ ends CSW - category products missing soe friendly URL   ] =======================

-- ===================== [ starts RGW - 404 URL   ] =======================
select * from url_rewrite where target_path like '%catalog/category/view/id/2184%'

INSERT INTO a53979e5_csw_mig.url_rewrite (entity_type, entity_id, request_path, target_path, redirect_type, store_id, description, is_autogenerated, metadata)
VALUES ('category', 2184, 'apparel-vestments/banners-paraments.html', 'catalog/category/view/id/2184', 0, 0, null, 0, null);

select distinct store_id from url_rewrite where entity_type='category'
select * from store;

select * from catalog_category_entity
select * from catalog_category_entity where entity_id=2181
select * from catalog_category_entity where parent_id=2
select * from catalog_category_entity where parent_id=2181
SELECT * FROM catalog_category_entity cce
inner join catalog_category_entity_varchar ccev on cce.entity_id = ccev.entity_id
where ccev.value='Sacraments'

SELECT * FROM catalog_category_entity cce
inner join catalog_category_entity_varchar ccev on cce.entity_id = ccev.entity_id
where ccev.value='Reconciliation'

SELECT * FROM catalog_category_entity_varchar ccev where ccev.value='Reconciliation';



-- ===================== [ ends RGW - 404 URL   ] =========================