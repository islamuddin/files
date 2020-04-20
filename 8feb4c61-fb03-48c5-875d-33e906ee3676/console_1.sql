select * from rgw_catalog_category_entity
where entity_id=2926;

select count(*) from rgw_catalog_category_entity

select * from rgw_enterprise_url_rewrite_category_cl;
select * from rgw_catalog_category_product_cat_cl;
select * from rgw_catalog_category_flat_cl;
select * from rgw_m2_cl_catalog_category_entity;

-- INSERT IGNORE INTO `rgw_enterprise_url_rewrite_category_cl` (`entity_id`) VALUES (NEW.`entity_id`);
-- INSERT IGNORE INTO `rgw_catalog_category_product_cat_cl` (`category_id`) VALUES (NEW.`entity_id`);
-- INSERT IGNORE INTO `rgw_catalog_category_flat_cl` (`entity_id`) VALUES (NEW.`entity_id`);
-- INSERT INTO rgw_m2_cl_catalog_category_entity (`entity_id`, `operation`) VALUES (NEW.entity_id, 'INSERT')ON DUPLICATE KEY UPDATE operation = 'INSERT';

select * from rgw_customer_entity where entity_id=8390
select count(*) from rgw_customer_entity -- 8043
select max(entity_id) from rgw_customer_entity

show triggers
BEGIN
INSERT INTO rgw_m2_cl_customer_entity (`entity_id`, `operation`) VALUES (NEW.entity_id, 'INSERT')ON DUPLICATE KEY UPDATE operation = 'INSERT';
END

select count(*) from rgw_sales_flat_order

select count(*) from rgw_catalog_product_entity;

select * from rgw_catalog_product_entity
where created_at like '%2019-%'
order by sku asc


where entity_id>191916
      sku ='PRT-ALVITI-2017G'
ORDER BY created_at desc;



select COUNT(*) from rgw_customer_entity; -- 8561
select COUNT(*) from rgw_catalog_product_entity; -- 145900
select COUNT(*) from rgw_sales_flat_order; -- 22268

select * from rgw_catalog_product_entity
select * from rgw_m2_cl_customer_entity
select * from rgw_m2_cl_catalog_product_entity
select * from rgw_m2_cl_sales_flat_order

-- PRODUCTS 192
select *
from a53979e5_csm1.rgw_m2_cl_catalog_product_entity rm2ccpei
inner join a53979e5_csw_mig.catalog_product_entity cpe
on rm2ccpei.entity_id=cpe.entity_id

-- 1817
select *
from a53979e5_csm1.rgw_m2_cl_sales_flat_order rm2csfo
inner join a53979e5_csw_mig.sales_order so
on so.entity_id=rm2csfo.entity_id



select * from rgw_m2_cl_catalog_product_entity_int
-- update rgw_m2_cl_catalog_product_entity_int set processed=1
-- where value_id=2310428;
where value_id in (
    select rgw_catalog_product_entity_int.value_id from rgw_catalog_product_entity_int where -- entity_id=191710 and
    attribute_id in (1509,1510) and store_id=0 order by entity_id asc
    )
and value_id=2310428

select distinct  operation from rgw_m2_cl_catalog_product_entity_int

select * from rgw_m2_cl_catalog_product_entity_int
where value_id=2488493


SELECT * FROM store;
SELECT * FROM store_website;

SELECT
    e.entity_id AS product_id,
    e.type_id AS product_type,
    e.sku AS sku,
    j.value AS Product_Name,
    mB.value AS Brand,
    mc.value AS Color,
    mcs.value AS Size,
    p1.value AS Price,
    ps1.value AS Special_Price,
    itV.value AS inventory_type,
    CASE
        WHEN s.value = '1' THEN 'Enabled'
        WHEN s.value = '2' THEN 'Disabled'
        ELSE NULL
    END AS product_status
FROM
    rgw_catalog_product_entity AS e
        LEFT JOIN
    rgw_catalog_product_entity_int AS it ON it.attribute_id = 241
        AND it.entity_type_id = '4'
        AND it.STORE_ID = 0
        AND e.entity_id = it.entity_id
        LEFT JOIN
    rgw_eav_attribute_option_value itV ON itV.option_id = it.value
        AND itV.STORE_ID = 0
        LEFT JOIN
    rgw_catalog_product_entity_text AS si ON si.attribute_id = 133
        AND si.entity_type_id = '4'
        AND si.STORE_ID = 0
        AND e.entity_id = si.entity_id
        LEFT JOIN
    rgw_catalog_product_entity_varchar AS j ON j.attribute_id = 71
        AND j.entity_type_id = '4'
        AND j.STORE_ID = 0
        AND e.entity_id = j.entity_id
        LEFT JOIN
    rgw_catalog_product_entity_varchar AS spsk ON spsk.attribute_id = 168
        AND spsk.entity_type_id = '4'
        AND spsk.STORE_ID = 0
        AND e.entity_id = spsk.entity_id
        LEFT JOIN
    rgw_catalog_product_entity_int AS s ON s.attribute_id = 96
        AND s.entity_type_id = '4'
        AND s.STORE_ID = 0
        AND e.entity_id = s.entity_id
        LEFT JOIN
    rgw_catalog_product_entity_int AS m ON m.attribute_id = 81
        AND m.entity_type_id = '4'
        AND m.STORE_ID = 0
        AND e.entity_id = m.entity_id
        LEFT JOIN
    rgw_eav_attribute_option_value mB ON mB.option_id = m.value
        AND mB.STORE_ID = 0
        LEFT JOIN
    rgw_catalog_product_entity_int AS clm ON clm.attribute_id = 92
        AND clm.entity_type_id = '4'
        AND clm.STORE_ID = 0
        AND e.entity_id = clm.entity_id
        LEFT JOIN
    rgw_eav_attribute_option_value mc ON mc.option_id = clm.value
        AND mc.STORE_ID = 0
        LEFT JOIN
    rgw_catalog_product_entity_int AS cls ON cls.attribute_id = 148
        AND cls.entity_type_id = '4'
        AND cls.STORE_ID = 0
        AND e.entity_id = cls.entity_id
        LEFT JOIN
    rgw_eav_attribute_option_value mcs ON mcs.option_id = clm.value
        AND mcs.STORE_ID = 0
        LEFT JOIN
    rgw_catalog_product_entity_decimal p1 ON p1.attribute_id = 75
        AND m.entity_type_id = '4'
        AND m.STORE_ID = 0
        AND e.entity_id = p1.entity_id
        LEFT JOIN
    rgw_catalog_product_entity_decimal ps1 ON ps1.attribute_id = 76
        AND m.entity_type_id = '4'
        AND m.STORE_ID = 0
        AND e.entity_id = ps1.entity_id
WHERE
    s.value = 1

-- types attributes ki
SELECT * FROM `a53979e5_csm1`.`rgw_eav_entity_type`;


select * from rgw_core_website;
select * from rgw_core_store;

