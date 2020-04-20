select *
from a53979e5_csm1.rgw_m2_cl_catalog_product_entity_int rm2ccpei
inner join a53979e5_csw_mig.catalog_product_entity cpe
on rm2ccpei.value_id=cpe.value_id
-- where entity_id=191721 and attribute_id=1509 and store_id=0 order by value_id desc;
