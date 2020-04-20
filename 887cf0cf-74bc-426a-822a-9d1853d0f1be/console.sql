




select * from review;
select * from review_status;
select * from review_detail;
select * from review_entity;
select * from review_entity_summary;

SET @PRODUCT_ID = 130;
 SELECT * FROM review WHERE entity_pk_value = @PRODUCT_ID;
SELECT * FROM review_detail WHERE review_id IN (SELECT review_id FROM review WHERE entity_pk_value = @PRODUCT_ID);
SELECT * FROM review_store WHERE review_id IN (SELECT review_id FROM review WHERE entity_pk_value = @PRODUCT_ID);
SELECT * FROM review_entity_summary WHERE entity_pk_value = @PRODUCT_ID;
SELECT * FROM rating_option_vote WHERE entity_pk_value = @PRODUCT_ID;
SELECT * FROM rating_option_vote_aggregated WHERE entity_pk_value = @PRODUCT_ID;

-- proudct query
select cpe.entity_id, cpev.value, ur.request_path from catalog_product_entity cpe
inner join              catalog_product_entity_varchar  cpev  on cpe.row_id=cpev.row_id
inner join url_rewrite ur on cpe.entity_id=ur.entity_id and ur.entity_type='product'
where cpev.attribute_id=73;

-- reviews query
select * from review r
inner join review_detail rd on r.review_id = rd.review_id
inner join review_store rs on r.review_id=rs.review_id
inner join review_entity_summary res on res.entity_pk_value=r.entity_pk_value
inner join rating_option_vote rov on r.review_id = rov.review_id
inner join rating_option_vote_aggregated rova on rova.entity_pk_value=r.entity_pk_value

-- merging above both queries

select cpe.entity_id as product_id,
       cpev.value as product_title,
       concat('https://www.kttape.com/',ur.request_path) as product_url,
       r.created_at as date,
       rd.detail as review_content,
       res.rating_summary as review_score,
       rd.title as review_title,
       rd.nickname as display_name,
       ce.email,
       'US' as md_customer_country
from catalog_product_entity cpe
inner join              catalog_product_entity_varchar  cpev  on cpe.row_id=cpev.row_id
inner join url_rewrite ur on cpe.entity_id=ur.entity_id and ur.entity_type='product'
inner join             review r on r.entity_pk_value=cpe.entity_id
inner join review_detail rd on r.review_id = rd.review_id
inner join review_store rs on r.review_id=rs.review_id
inner join review_entity_summary res on res.entity_pk_value=r.entity_pk_value
inner join rating_option_vote rov on r.review_id = rov.review_id
inner join rating_option_vote_aggregated rova on rova.entity_pk_value=r.entity_pk_value
inner join customer_entity ce on rd.customer_id = ce.entity_id
where cpev.attribute_id=73;


-- reviews query
select * from
              review r
inner join review_detail rd on r.review_id = rd.review_id
inner join review_store rs on r.review_id=rs.review_id
inner join review_entity_summary res on res.entity_pk_value=r.entity_pk_value
inner join rating_option_vote rov on r.review_id = rov.review_id
inner join rating_option_vote_aggregated rova on rova.entity_pk_value=r.entity_pk_value
inner join customer_entity ce on rd.customer_id = ce.entity_id
where rs.store_id=0;



select * from customer_entity ce

