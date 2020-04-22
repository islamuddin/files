select * from tp_customer_entity where email='uddinislam46@gmail.com';
select * from tp_customer_entity where email='id@plumtreegroup.net';

-- old  | new
-- reserve5@roadrunner.com              |   plumtree@1
--                                      |   plumtree@1
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN  |   $2y$10$piHRdqOiKfvvwvOI4X/wHO/IujLm1mw3eNCe6STb9NaYR3QI8ko5i (not worked well but changed to ) : 56fae8213dda1488141b3d76f6c3b0dbdd52e5396224741624c4ce2ef4a0cee7:zifptXgI5FtkKbI1:2
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN:0
-- b91b49b9a17b412d47d9edd8ad8d6de5:JN:0

# UPDATE `customer_entity`
# SET `password_hash` = CONCAT(SHA2('xxxxxxxxYOURPASSWORD', 256), ':xxxxxxxx:1')
# WHERE `entity_id` = 1;

select * from tp_customer_entity where entity_id=4972;
select * from tp_customer_entity_varchar where entity_id=4972; -- customer id yahan sy mili

