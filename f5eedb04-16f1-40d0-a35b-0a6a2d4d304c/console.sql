-- id@plumtreegroup.net :   plumtree@1   : 9e8af93cfe4d46dff68f35728adeb55e9ff38e52a33f1728ad946a2613dc8551:j5iOwRE8v2R9hfWO:2
select * from tp_customer_entity where email='id@plumtreegroup.net';
-- id@plumtreegroup.net :   ?   : b91b49b9a17b412d47d9edd8ad8d6de5:JN:0 : (changed to)  : 9e8af93cfe4d46dff68f35728adeb55e9ff38e52a33f1728ad946a2613dc8551:j5iOwRE8v2R9hfWO:2
select * from tp_customer_entity where email='reserve5@roadrunner.com';

-- old  | new
-- reserve5@roadrunner.com              |   plumtree@1
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN  |   $2y$10$piHRdqOiKfvvwvOI4X/wHO/IujLm1mw3eNCe6STb9NaYR3QI8ko5i
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN:0 | (changed to )    9e8af93cfe4d46dff68f35728adeb55e9ff38e52a33f1728ad946a2613dc8551:j5iOwRE8v2R9hfWO:2

select * from tp_customer_entity where entity_id=4972;
select * from tp_customer_entity_varchar where entity_id=4972; -- customer id yahan sy mili
