-- 13099
select DISTINCT  COUNT(ID) from squareup_omni_inventory
group by id having count(*)>1;

-- select * from squareup_omni_inventory where id=1;
-- truncate from squareup_omni_inventory where id=1;
-- delete from  squareup_omni_inventory where id=1;
select max(id) from squareup_omni_inventory;
select * from squareup_omni_inventory where id=14100;
select * from squareup_omni_location where id=1;
select * from squareup_omni_location;
-- INSERT INTO a13599fb_bh_new.squareup_omni_location (id, square_id, name, address_line_1, locality, administrative_district_level_1, postal_code, country, phone_number, status, currency, webhook_time, cc_processing) VALUES (1, 'WA3F7MSB9XAEF', 'theBetterHealthstore.com', '42875 Grand River Ave', 'Novi', 'MI', '48375', 'US', '+1 248-735-8100', '1', 'USD', '2019-10-24T16:58:56+00:00', 1);

select COUNT(product_id) from squareup_omni_inventory;
select DISTINCT  COUNT(product_id) from squareup_omni_inventory group by id having count(*)>1;
select * from sales_shipment order by created_at desc;

select * from eav_attribute;
select * from eav_attribute where entity_type_id=1
and attribute_code like '%email%';
select * from eav_entity_type;

select * from eav_attribute where entity_type_id=1
--                              and is_required=1;
and  attribute_id in (228,5,10,7,2,1);


select * from eav_attribute_label;
select * from eav_attribute_set;
select * from eav_attribute_group;
select * from customer_eav_attribute;
select * from customer_eav_attribute_website;

select * from customer_eav_attribute;

{"input_validation":"email"}
{"input_validation":"email"}




select * from eav_entity_attribute


select * from catalog_url_rewrite_product_category;
select curpc.*, ur.* from url_rewrite ur
inner join catalog_url_rewrite_product_category curpc on ur.url_rewrite_id=curpc.url_rewrite_id
where curpc.url_rewrite_id=242507;

