SELECT DISTINCT (
c.customer_email
), t.customer_points_active, c.store_id, 1 AS website_id
FROM `tp_sales_flat_order` c, tp_rewards_customer_index_points t
WHERE c.customer_id = t.customer_id
and c.customer_email='kellychase1975@icloud.com'

select * from tp_customer_entity where email='kellychase1975@icloud.com'; -- customer id yahan sy mili
select * from tp_customer_entity where email='id@plumtreegroup.net'; -- customer id yahan sy mili

select * from tp_rewards_customer_index_points where customer_id=30891;

select * from tp_rewardsref_referral where referral_email='kellychase1975@icloud.com';
select * from tp_rewards_customer_index_points;
select * from tp_rewards_reports_indexer_order;
select * from tp_rewards_transfer where customer_id=30891;

select * from tp_rewards_transfer order by  quantity desc;
select * from tp_customer_entity where entity_id=4972; -- reserve5@roadrunner.com
-- old  | new
-- reserve5@roadrunner.com
--                                      |   plumtree@1
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN  |   $2y$10$piHRdqOiKfvvwvOI4X/wHO/IujLm1mw3eNCe6STb9NaYR3QI8ko5i
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN:0

select * from tp_customer_entity_varchar where entity_id=4972; -- customer id yahan sy mili
select * from tp_customer_entity where entity_id=4972;
select * from tp_customer_entity_varchar where entity_id=30892; -- customer id yahan sy mili

select * from tp_eav_entity_type;
select * from tp_eav_attribute where attribute_id=12;
select * from tp_eav_attribute where entity_type_id=1
                                 and attribute_code like '%pass%';
