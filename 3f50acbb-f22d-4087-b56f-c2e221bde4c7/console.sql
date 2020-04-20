SELECT DISTINCT (
c.customer_email
), t.customer_points_active, c.store_id, 1 AS website_id
FROM `tp_sales_flat_order` c, tp_rewards_customer_index_points t
WHERE c.customer_id = t.customer_id

select * from tp_rewards_catalogrule_product

SELECT DISTINCT (
c.customer_email
), t.customer_points_active, c.store_id, 1 AS website_id
FROM `tp_sales_flat_order` c, tp_rewards_customer_index_points t
WHERE c.customer_id = t.customer_id

